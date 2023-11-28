-module(client). 
-export([start/2]). 
-define(NODE, 's@LAPTOP-79NBJLG6').
start(Group, Nick) -> 
	spawn(fun() -> 
        process_flag(trap_exit, true), 
        {chat_server, ?NODE} ! {login, self(), Group, Nick},
		Pid = waitPid(),
        active(Pid)
        end
    ).

waitPid() ->
    receive
        {controller, Pid} -> Pid;
        Other -> io:format("unexpected:~p~n",[Other]), waitPid()
    end.

active(Controller) -> 
	receive 
		{msg, Nick, Str} -> 
			Controller ! {msg, Nick, Str}, 
			active(Controller); 
		{msg, From, Pid, Str} -> 
			io:format("~p@~p: ~p~n", [From,Pid,Str]), 
			active(Controller); 
		{close, MM} -> exit(serverDied); 
		Other -> 
			io:format("chat_client active unexpected:~p~n",[Other]), 
			active(Controller) 
	end.