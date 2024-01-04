import scala.util.parsing.combinator._

class Expr {}
case class InternalExpr(x : Expr, op : String, y : Expr) extends Expr{
    override def toString() : String = "(" + x.toString() + " " + op + " " + y.toString() + ")"
}
case class Number(x : Int) extends Expr{
    override def toString() : String = x.toString()
}

class exprStepByStepParser extends JavaTokenParsers {
    override val whiteSpace = """[ ]""".r
    def start = rep(expr <~ """[\r\n]*""".r) ^^ {l => l.foreach{s=> printSteps(s);println()}}
    def expr : Parser[Expr] = (term ~ op ~ expr) ^^ {case (x ~ op ~ y) => InternalExpr(x, op, y)} | term 
    def term : Parser[Expr] = ("(" ~> expr <~ ")") | wholeNumber ^^ {x => Number(x.toInt)}
    def op = ("+" | "-" | "*" | "/")
    
    def printSteps(e : Expr) : Unit = {
        println(e)
        e match {
            case Number(x) => 
            case e => printSteps(resolve(e))
        } 
    }
    def resolve(e : Expr) : Expr = {
        e match {
            case Number(x) => Number(x)
            case InternalExpr(Number(x), op, Number(y)) => Number(eval(x, op, y))
            case InternalExpr(x, op, y) => InternalExpr(resolve(x), op, resolve(y))
        }
    }
    def eval(x : Int, op : String, y : Int) = op match {
        case "+" => x + y
        case "-" => x - y
        case "/" => x / y
        case "*" => x * y
    }  
}

object Main {
    def main (args:Array[String]) : Unit = {
        args.foreach{ path =>
            var src = scala.io.Source.fromFile(path)
            var lines = src.mkString
            val p = new exprStepByStepParser
            p.parseAll(p.start, lines) match {
                case p.Success(t, _) => println()
                case x => println(x)
            }
        }
    }
}