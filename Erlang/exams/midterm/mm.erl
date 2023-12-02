-module(mm).
-export([init/2]).
init(MM, Server) -> 
    group_leader(whereis(user), self()),
    io:format("MM is running~n"),
    loop(MM, Server).
loop(MM, Server) ->
    receive
        {TotalSize, Start, L, Size} -> 
            io:format("sending TotalSize:~p, FirstIndex:~p, List:~p to Server~n", [TotalSize, Start, L]),
            forward(TotalSize, Start, Size, L, Server, MM);
        Any -> 
            io:format("sending ~p to Server~n", [Any]),
            loop(MM, Server)
    end.

forward(_, _, _, [], Server, Mm) -> loop(Mm, Server);
forward(TotalSize, Idx, Size, [H|T], Server, Mm) -> 
    Server ! {TotalSize, Idx, Size, H, Mm}, 
    forward(TotalSize, Idx+1, Size, T, Server, Mm).