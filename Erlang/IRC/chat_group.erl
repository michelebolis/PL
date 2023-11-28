-module(chat_group). 
-export([start/2]). 
start(Pid, Nick) -> 
	process_flag(trap_exit, true), 
	self() ! {msg, Pid, Nick, "I'm starting the group"}, 
	group_controller([{Pid, Nick}]). 

delete(Pid, [{Pid,Nick}|T], L) -> {Nick, lists:reverse(T, L)}; 
delete(Pid, [H|T], L) -> delete(Pid, T, [H|L]); 
delete(_, [], L) -> {"????", L}. 

group_controller([]) -> exit(allGone); 
group_controller(L) -> 
	receive 
		{msg, Pid1, Nick, Str} -> 
			lists:foreach(fun({Pid,_}) -> 
				(Pid ! {msg, Pid1, Nick, Str}) end, L), 
			group_controller(L); 
		{login, Pid, Nick} -> 
			self() ! {msg, Pid, Nick, "I'm joining the group"}, 
			group_controller([{Pid,Nick}|L]); 
		{delete, Pid} -> 
			{Nick, L1} = delete(Pid, L, []), 
			self() ! {msg, Pid, Nick, "I'm leaving the group"}, 
			group_controller(L1); 
		Any -> 
			io:format("group controller received Msg=~p~n", [Any]), 
			group_controller(L) 
	end.