-module(client).
-export([start/1, to_slave/2]).

start(N) ->
    case whereis(master) of
        undefined -> register(master, spawn(master, start, [N]));
        _Any -> unregister(master), register(master, spawn(master, start, [N]))
    end,
    ok.

to_slave(Message, N) ->
    master ! {msg, Message, N}.
