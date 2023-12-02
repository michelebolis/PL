-module(client).
-export([start/0, stop/0, reverse/1]).
start() -> 
    group_leader(whereis(user), self()),
    {ok, Host} = inet:gethostname(),
    Server = spawn_link(list_to_atom("server@"++Host), server, init, []),
    MM1 = spawn_link(list_to_atom("mm1@"++Host), mm, init, [mm1, Server]),
    MM2 = spawn_link(list_to_atom("mm2@"++Host), mm, init, [mm2,Server]),
    process_flag(trap_exit, true),
    Client = spawn_link(fun() -> client_loop(MM1, MM2) end),
    register(client, Client),
    io:format("Client is running~n").
stop() -> 
    io:format("Shut down everything~n"),
    client ! {stop}.
client_loop(MM1, MM2) -> 
    receive
        {L, L1, L2} -> 
            MM1 ! {L, 1, L1, length(L1)}, 
            MM2 ! {L, 1, L2, length(L2)},
            client_loop(MM1, MM2);
        {stop} -> exit(stop)
    end.
reverse(L) when length(L) rem 2 == 0 -> 
    Size = trunc(length(L) / 2),
    client ! {length(L), lists:sublist(L, Size), lists:sublist(L, Size+1, Size)};
reverse(L) ->
    Size = trunc(length(L) / 2) + 1,
    client ! {length(L), lists:sublist(L, Size), lists:sublist(L, Size, Size)}.
