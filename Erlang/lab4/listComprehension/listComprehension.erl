% c(listComprehension).ù
% listComprehension:squared_int([1, hello, 100, boo, “boo”, 9]).
% listComprehension:intersect([1,2,3,4,5], [4,5,6,7,8]).
% listComprehension:symmetric_difference([1,2,3,4,5], [4,5,6,7,8]).

-module(listComprehension).
-export([squared_int/1, intersect/2, symmetric_difference/2]).
squared_int(L) ->
    [X*X || X <- L, erlang:is_integer(X)].
intersect(L1, L2) ->
    [X || X <- L1, lists:member(X, L2)].
symmetric_difference(L1, L2) ->
    [X || X <- L1, not lists:member(X, L2)] ++ 
    [Y || Y <- L2, not lists:member(Y, L1)].