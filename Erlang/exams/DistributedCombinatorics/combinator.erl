-module(combinator).
-export([start/2]).
start(N, M) -> 
    register(master, self()),
    lists:map(fun(X) -> spawn(generator, generate, [N, X, M]) end, 
    lists:seq(1, N)),
    waiting(N, []).

waiting(N, Cols) when N==0-> 
    %io:format("~p~n", [Cols]),
    LastCol = lists:nth(length(Cols), Cols),
    NewCols = lists:sublist(Cols, length(Cols)-1),
    print_result(NewCols, 1, length(lists:nth(1,NewCols)), LastCol);
waiting(N, Cols) ->
    receive 
        {N, Result} -> waiting(N-1, [Result|Cols])
    end.

print_result(Cols, Index, Max, LastCol) when Index == Max-1 -> 
    lists:foreach(fun(X) -> io:format("~p, ", [lists:nth(Index, X)]) end, Cols),
    io:format("~p", [lists:nth(Index, LastCol)]),
    io:format("~n"),
    unregister(master);
print_result(Cols, Index, _Max, LastCol) ->
    lists:foreach(fun(X) -> io:format("~p, ", [lists:nth(Index, X)]) end, Cols),
    io:format("~p", [lists:nth(Index, LastCol)]),
    io:format("~n"),
    print_result(Cols, Index+1, _Max, LastCol).