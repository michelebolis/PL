# DistributedTasks

One of the basics of distributed computation consists of splitting the task to do in several subtasks that can be distributed among several computational units and then the partial results will be composed together to form the expected result.  

Neglecting the first point, mathematics can help a lot on the second point. If the original task can be expressed as a function f this can decomposed in several functions φ¹, ..., φⁿ such that holds.  
This means that each subtask is implemented by an easier function and the final result depends on the mathematical composition of such functions in the right order.
Given this, the whole approach is realized by an actors ring where the number of actors in the ring depends on the number of functions the original function is decomposed into.  

Each actor runs the function corresponding to its position in the sequence—i.e., the actor position in the ring corresponds to
the function position in the original function decomposition.  
The first actor applies its function to an external input; all the other actors will apply their function to the result of the computation of the actor that precedes them and the last actor will print out the final result.

Basically, all the actors have the same behavior but the last one.  
All data are exchanged through message passing.
You interact with the first actor in the ring through three functions:

- send_message/1, passes the initial value to the first actor and initiates the whole computations that ends when the message reaches the last actor in the ring
- send_message/2 does the same as the send_message/1 but the second argument represents the number of times the message should run through the whole ring—i.e., the number of times the whole algorithm should be applied
- stop/0 has to nicely shut down the actors ring.  

The actors ring is started by the start/2 functions whose arguments are the number of actors in the ring and a list of functions (the φ in the above formula).
This exercise consists in implementing the module ring that implements the described situation, To
simplify the exercise the only admissible functions are unary on integers—i.e., from int to int.
