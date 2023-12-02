-module(server).
-export([init/0]).
init() -> 
    group_leader(whereis(user), self()),
    io:format("Server started~n"),
    loop(0, 0, [], []).
loop(I1, I2, L1, L2) -> 
    receive
        {TotalSize, _Index, Size, El, mm1} when I1 == Size, I2 == Size + 1 -> 
            io:format("Reversed: ~p~n", [concat(TotalSize, [El|L1], L2)]), 
            loop(1, 1, [], []);
        {TotalSize, _Index, Size, El, mm2} when I2 == Size, I1 == Size + 1 -> 
            io:format("Reversed: ~p~n", [concat(TotalSize, L1, [El|L2])]), 
            loop(1, 1, [], []);
        {_, Index, _, El, mm1} -> loop(Index+1, I2, [El|L1], L2);
        {_, Index, _, El, mm2} -> loop(I1, Index+1, L1, [El|L2])
    end.

concat(TotalSize,L1,L2) when TotalSize rem 2 == 0 -> L2++L1;
concat(_, [_|T], L) -> L++T.