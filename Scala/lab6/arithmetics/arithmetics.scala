import scala.util.parsing.combinator._

class ArithmeticParser extends JavaTokenParsers {
  def start = { operation ^^ {case (num, result) => eval(num) == result} }

  def operation: Parser[(List[BigInt], BigInt)] = wholeNumber ~ rep(number) ~ result ^^ 
    {case num ~ nums ~ result => (BigInt(num) :: nums, result)}
  def number = ("+" | "-") ~ wholeNumber ^^ {case sign ~ num => BigInt(sign + num)}
  def result = "=" ~> (dashline) ~> opt("-") ~ wholeNumber ^^ 
    {case sign ~ num => BigInt(sign.getOrElse("") + num)}
  def dashline: Parser[Any] = """[-]+""".r

  def eval(l: List[BigInt]): BigInt = {
    l match {
      case Nil => 0
      case x :: Nil => x
      case x :: next :: tl => eval((x + next) :: tl)
    }
  }
}
object TestMain {
  def main(args: Array[String]) = {
    val p = new ArithmeticParser
    args.foreach { filename =>
      val src = scala.io.Source.fromFile(filename)
      val lines = src.mkString
      p.parseAll(p.start, lines) match {
        case p.Success(result, _) => println(result.toString)
        case x => print(x.toString)
      }
      src.close()
    }
  }
}