import scala.util.parsing.combinator._
import scala.collection.mutable._
class DeskParser extends JavaTokenParsers{
    val map = new HashMap[String, Int]
    def start = "print" ~> expression ~ ("where" ~> repsep(declaration, ",")) ^^ {case e ~ _ => println(e()); map}
    def expression : Parser[() => Int] = (
        ((x ~ ("+" ~> expression) | (num ~ ("+" ~> expression))) 
            ^^ {case f1 ~ f2 => () => f1() + f2()}:Parser[() => Int]) 
        | x | num) 
    def x = """[a-z]""".r ^^ {x => () => map(x)}
    def num = wholeNumber ^^ {n => () => n.toInt}
    def declaration = """[a-z]""".r ~ ("=" ~> wholeNumber) ^^ {case y ~ n => map(y) = n.toInt}
}

object DeskEvaluator {
    def main(args : Array[String]) : Unit = {
        args.foreach { path =>
            val src = scala.io.Source.fromFile(path)
            val lines = src.mkString
            val p = new DeskParser
            p.parseAll(p.start, lines) match {
                case p.Success(t, _) => println(t)
                case x => print(x.toString)
            }
        }
    }
}