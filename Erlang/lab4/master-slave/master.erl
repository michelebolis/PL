% This problem illustrates a situation where we have a process (the master) which supervises other processes (the slaves). 
% In a real example the slave could, for example, be controlling different hardware units. 
% The master's job is to ensure that all the slave processes are alive. 
% If a slave crashes (maybe because of a software fault), the master is to recreate the failed slave.

% Write a module ms with the following interface:
% start(N) which starts the master and tell it to start N slave processes and registers the master as the registered process master.
% to_slave(Message, N) which sends a message to the master and tells it to relay the message to slave N; 
% the slave should exit (and be restarted by the master) if the message is die.
% the master should detect the fact that a slave process dies, restart it and print a message that it has done so.

% The slave should print all messages it receives except the message die
% Hints:
% the master should trap exit messages and create links to all the slave processes.
% the master should keep a list of pids of the slave processes and their associated numbers.

-module(master).
-export([start/1, to_slave/2]).
start(N) -> 
    process_flag(trap_exit, true),
    Slaves = lists:map(
        fun(X) -> spawn_link(slave_md, loop, [X]) end,
        lists:seq(1,N)
    ),
    io:format("Slaves at: ~p~n", [Slaves]),
    loop(Slaves).
to_slave(Message, N) -> self() ! {msg, Message, N}.
loop(L) -> 
    receive
        {msg, die, To} -> 
            io:format("Sending dying message to slave~p~n", [To]),
            lists:nth(To, L) ! {die}, 
            loop(L);
        {msg, Message, To} -> 
            io:format("Sending message to slave~p~n", [To]),
            lists:nth(To, L) ! {Message}, 
            loop(L);
        {'EXIT', Pid, died} -> 
            io:format("Died slave at ~p~n", [Pid]),
            NewL = delete(Pid, L),
            io:format("new Slaves: ~p~n", [NewL]),
            loop(NewL);
        _Other -> io:format("Unsupported"), loop(L)
    end.

delete(Pid, L) -> delete(Pid, 0, L).
delete(Pid, N, [Pid | TL]) -> 
    io:format("master restarting dead slave~p~n", [N+1]), 
    [spawn_link(slave_md, loop, [N+1]) | TL];
delete(Pid, N, [Pid2 | TL]) -> [Pid2 | delete(Pid, N+1, TL)];
delete(_, _, []) -> error.