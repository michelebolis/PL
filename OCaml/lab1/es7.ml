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
type expr =
  | Unario of op * expr
  | Binario of expr * op * expr 
  | Value of int
and op = Somma | Differenza | Divisione | Prodotto | Potenza 
;;
module type PolishCalculator =
  sig
    val expr_of_string : string -> expr
    val eval : expr -> int
  end 
;;
module Calculator_Stack : PolishCalculator = 
  struct
    let parse_op = function
      | "+" -> Somma
      | "-" -> Differenza
      | "/" -> Divisione
      | "*" -> Prodotto 
      | _ -> Potenza
    ;;
    let expr_of_string s = 
      let elements = String.split_on_char ' ' s in
      let stack = Stack.create() in
      List.iter (
        fun element ->
          match int_of_string_opt element with
          | Some n -> Stack.push (Value n) stack
          | None ->
            Stack.push (Binario ((Stack.pop stack), (parse_op element), (Stack.pop stack))) stack
      ) elements;
      Stack.pop stack
    ;;
    let rec eval = function  
      | Value x -> x
      | Unario (op, x) -> (eval_op op) (eval x) 0
      | Binario (x1, op, x2) -> (eval_op op) (eval x1) (eval x2)
    and eval_op = function 
      | Somma -> (+)
      | Differenza -> (-)
      | Divisione -> (/)
      | Prodotto -> ( * )
      | Potenza -> ( * )
    ;;
  end
;;