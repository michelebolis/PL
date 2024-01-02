import scala.util.parsing.combinator._

class ExprCompleteParser extends JavaTokenParsers {
    def expr : Parser[String] = 
        (n ~ op ~ (completeExpr | expr | n )) ^^ {case (n ~ op ~ e) => eval(n, op, e)} | n ^^ {n => n}
    def completeExpr : Parser[String] = ("(" ~> expr <~ ")") ~ opt(op ~ expr) ^^ 
        {case (n ~ o) => o match {
            case None => n 
            case Some(op ~ e) => eval(n, op, e)
        }
    }

    def n = floatingPointNumber
    def op = "+" | "-"
    def eval(n: String, op: String, e: String) : String = {
        (n, op, e) match {
            case (x, "+", y) => (x.toFloat + y.toFloat).toString
            case (x, "-", y) => (x.toFloat - y.toFloat).toString
        }
    }
}
object Main {
    def main(args : Array[String]) : Unit = {
        args.foreach{ path =>
            val src = scala.io.Source.fromFile(path)
            val lines = src.mkString 
            val p = new ExprCompleteParser
            p.parseAll(p.expr, lines) match {
                case p.Success(t, _) => println(t)
                case x => print(x.toString)
            }
        }
    }
}