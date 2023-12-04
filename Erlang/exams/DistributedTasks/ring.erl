-module(ring).
-export([start/2, stop/0, send_message/1, send_message/2, create/3]).
start(N, L) -> 
    Start = spawn_link(?MODULE, create, [N, L, self()]),
    case whereis(start) of
        undefined -> register(start, Start);
        _Any -> unregister(start), register(start, Start)
    end, 

    receive
        ready -> ok
        after 5000 -> {error, timeout}
    end.

stop() -> start ! {stop}.

create(1, [H|_], Start) ->
    io:format("Actor 1 created~n"),
    Start ! ready,
    loop_last(start, H);
create(NumberProcesses, [H|TL], Start) ->
    io:format("Actor ~p created with ~p ~n", [NumberProcesses, self()]),
    Next = spawn_link(?MODULE, create, [NumberProcesses - 1, TL, Start]),
    loop(Next, H).

send_message(N) -> send_message(N, 1).

send_message(N, K) -> start ! {apply, {N, K}}.

loop(Next, F) ->
    % io:format("~p looping ~n", [self()]), 
    receive
        {stop} -> exit(stop);
        {apply, {N, K}} -> 
            %io:format("~p send ~p ~p to ~p~n", [self(), F(N), K, Next]),
            Next ! {apply, {F(N), K}}, 
            loop(Next, F)
    end.
loop_last(Next, F) -> 
    % io:format("~p looping last ~n", [self()]), 
    receive
        {stop} -> exit(stop);
        {apply, {N, 1}} ->
            io:format("~p~n", [F(N)]),
            loop_last(Next, F);
        {apply, {N, K}} -> 
            Next ! {apply, {F(N), K-1}},
            loop_last(Next, F)
    end.