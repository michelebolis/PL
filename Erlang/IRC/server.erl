-module(server).
-export([start/0]).
start() -> register(chat_server, 
		spawn(fun() -> 
			process_flag(trap_exit, true),
            io:format("Server started"), 
			Val = (catch server_loop([])), 
			io:format("Server terminated with:~p~n",[Val]) 
		end)).
server_loop(L) ->
	receive 
		{login, Pid1, Group, Nick} -> 
			io:format("Received login ~p~n ~p~n ~p~n", [Pid1, Group, Nick]),
			case lookup(Group, L) of 
			{ok, Pid} -> 
			% nella lista L ho già un group manager per quel gruppo, 
			% quindi mando un messaggio
                Pid1 ! {controller, Pid},
				Pid ! {login, Pid1, Nick}, 
				server_loop(L); 
			error -> 
			% nella lista NON ho un group manager per quel gruppo,
			% creo quindi il nuovo group manager
				Pid = spawn_link(
					fun() -> chat_group:start(Pid1, Nick) end), 
                Pid1 ! {controller, Pid},
                io:format("Created new controller for group ~p~n at ~p~n", [Group, Pid]),
				server_loop([{Group,Pid}|L]) 
			end; 
		{mm_closed, _} -> server_loop(L); 
		{'EXIT', Pid, allGone} -> 
			L1 = remove_group(Pid, L), 
			server_loop(L1); 
		Msg -> 
			io:format("Server received Msg=~p~n", [Msg]), 
			server_loop(L) 
	end. 
lookup(G, [{G,Pid}|_]) -> {ok, Pid}; 
lookup(G, [_|T]) -> lookup(G, T); 
lookup(_,[]) -> error. 

remove_group(Pid, [{G,Pid}|T]) -> io:format("~p removed~n",[G]), T; 
remove_group(Pid, [H|T]) -> [H|remove_group(Pid, T)]; 
remove_group(_, []) -> []. 