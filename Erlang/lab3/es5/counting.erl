% Write a module counting which provides the functionality for interacting with a server 
% that counts how many times its services has been requested.

% It has to implement several services dummy1, ... dummyn (doesn't matter what they do or their real interface) 
% and a service tot that returns a list of records indexed on each service (tot included) 
% containing also how many times such a service has been requested. Test it from the shell.
- module(counting).
- export([start/0, stop/0, dummy1/0, dummy2/0, tot/0]).
start() ->
    Countings = lists:zip(["dummy1", "dummy2", "tot"], [0,0,0]),
    register(server, spawn(fun() -> loop(Countings) end)),
    io:format("Server started\n").
stop() -> 
    exit(whereis(server), stopped),
    ok.
loop(Countings) ->
    receive
        {dummy1} -> 
            Countings = update("dummy1", Countings), 
            io:format("Updated dummy1 count"),
            loop(Countings);
        {dummy2} -> 
            Countings = update("dummy2", Countings), 
            io:format("Updated dummy2 count"),
            loop(Countings);
        {tot} -> Countings = update("tot", Countings), loop(Countings)
    end.
update(S, [{S, C}|T]) -> [{S, C+1}|T];
update(S, [H|T]) -> [H | update(T, S)].
dummy1() ->
    io:format("doneDummy1\n"),
    server ! {dummy1}.
dummy2() -> 
    io:format("doneDummy2\n"),
    server ! {dummy2}.
tot() -> server ! {tot}.