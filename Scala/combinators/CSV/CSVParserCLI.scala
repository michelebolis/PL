import scala.util.parsing.combinator._
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
    def start : Parser[List[List[String]]] = record ~ rep("""\r\n""".r ~> record) ^^ {case r1 ~ l => List(r1):::l}
    def record : Parser[List[String]] = field ~ "," ~ record ^^ 
        {case first ~ _ ~ fields => List(first):::fields} | field ^^ {f => List(f)}
    def field : Parser[String] = "[^\r\n\t,]*".r ^^ {s => s.toString} 
}

object Main {
    def main(args : Array[String]) : Unit = {
        args.foreach{ path =>
            val src = scala.io.Source.fromFile(path)
            val lines = src.mkString 
            val p = new CSVParser
            p.parseAll(p.start, lines) match {
                case p.Success(t, _) => println(t)
                case x => print(x.toString)
            }
        }
    }
}