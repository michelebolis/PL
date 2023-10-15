(*
Write a PolishCalculator module that implements a stack-based calculator that adopts polish notation for the expressions to be evaluated.

Polish Notation is a prefix notation wherein every operator follows all of its operands; 
this notation has the big advantage of being unambiguous and permits to avoid the use of parenthesis. 
E.g., (3+4)*5 is equal to 3 4 + 5 *.

The module should include an:
- Expr datatype representing an expression
- a function expr_of+string: string → Expr which build the expression in the corresponding infix notation out of the string in polish notation;
- a function eval: Expr → int which will evaluate the expression and returns such evaluation
The recognized operators should be +, - (both unary and binary), *, /, ** over integers. At least a space ends each operands and operators.

The evaluation/translation can be realized by pushing the recognized elements on a stack. 
Define the module independently of the Stack implementation and try to use functors to adapt it.   
*)
module PolishCalculator :
  sig
    type Expr 
    val expr_of_string : string -> a' Expr
    val eval : expr -> int
  end 
  = 
  struct
    type expr = []
    let rec pow x = function
      | 0 -> 1.0
      | i -> x *. (pow x (i-1))
    ;;
    let expr_of_string s =
      []
    ;;
    let eval x = 
      1
    ;;
  end
;;