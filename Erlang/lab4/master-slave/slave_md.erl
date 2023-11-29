-module(slave_md).
-export([loop/1]).
loop(N) ->
    receive
        {die} -> exit(died);
        Any -> io:format("Slave ~p at ~p received message ~p~n", [N, self(), Any]), loop(N)
    end.