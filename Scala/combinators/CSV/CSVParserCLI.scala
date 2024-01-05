import scala.util.parsing.combinator._
import scala.math._
/* 
    1. is plain text using a character set such as ASCII or Unicode,
    2. consists of records (one record per line),
    3. with the records divided into fields separated by commas, any character can be part of a field
    including the comma in that case the whole field is quoted
    4. where every record has the same sequence of fields,
    5. often the first record has the special role of header and describes the various data
    
    Grammar
    file   ::= record { "\n" record }
    record ::= field { "," field }
    field  ::= stringLiteral | stringLiteral { ws stringLiteral }
    ws     ::= " " | "\t"
*/
class CSVParser extends JavaTokenParsers {
    override val skipWhitespace = false
    override val whiteSpace = """[ \t\n]""".r
    def start : Parser[Unit] = record ~ rep("""\r\n""".r ~> record) ^^ {case r1 ~ l => printTable(List(r1):::l)}
    def record : Parser[List[String]] = field ~ "," ~ record ^^ 
        {case first ~ _ ~ fields => List(first):::fields} | field ^^ {f => List(f)}
    def field : Parser[String] = "[^\r\n\t,]*".r ^^ {s => s.toString} 

    def printTable(l : List[List[String]]) : Unit = {
        l match {
            case t::tl =>
                val sizes = getMaxSizes(l)
                var totSizes = t.length + 1
                for (k <- 0 to sizes.length-1) totSizes += sizes(k) + 2
                val dashes = "-" * totSizes
                println(getRowString(t, sizes))
                println(dashes)
                tl.foreach{row =>
                    println(getRowString(row, sizes))
                }
                println(dashes)
            case x =>
        }
    }
    def getMaxSizes(l : List[List[String]]) : Array[Int] = {
        var sizes = new Array[Int](l(1).length)
        l.foreach{ row =>
            var i = 0
            row.foreach{ field =>
                sizes(i) = max(sizes(i), field.length)
                i += 1
            }
        }
        sizes
    }
    def getRowString(l : List[String], sizes : Array[Int]) : String = {
        var col = 0
        var s = "| "
        l.foreach{ field =>
            s += field
            for(k <- 1 to (sizes(col) - field.length)) s += " " 
            s += " | "
            col += 1
        }
        return s
    }
}

object Main {
    def main(args : Array[String]) : Unit = {
        args.foreach{ path =>
            val src = scala.io.Source.fromFile(path)
            val lines = src.mkString 
            val p = new CSVParser
            p.parseAll(p.start, lines) match {
                case p.Success(t, _) => 
                case x => print(x.toString)
            }
        }
    }
}