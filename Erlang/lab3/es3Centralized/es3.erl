% Write a program that will create N processes connected in a ring. 
% Once started, these processes will send M number of messages around the ring 
% and then terminate gracefully when they receive a quit message. 
% You can start the ring with the call ring:start(M, N, Message).

% There are two basic strategies to tackling this exercise. 
% The first one is to have a central process that sets up the ring and initiates sending the message. 
% The second strategy consists of the new process spawning the next process in the ring. 
% With this strategy, you have to find a method to connect the first process to the second process.

% Try to solve the exercise in both manners. 
% Note, when writing your program, make sure your code has many io:format statements in every loop iteration; 
% this will give you a complete overview of what is happening (or not happening) and should help you solve the exercise.

- module(es3).
- export([start/3]).
start(M, N, Message) -> 
    create(N),
    first ! {M, Message}.
% Create the ring
create(1, PID) ->
    register(first, spawn(fun() -> ring_process(PID) end)),
    io:format("Create process first with PID ~p linked to node with PID ~p\n", [whereis(first), PID]);
create(N, PID) ->
    PID2 = spawn(fun() -> ring_process(PID) end),
    io:format("Create process with PID ~p linked to node with PID ~p\n", [PID2, PID]),
    create(N-1, PID2).
create(N) -> 
    PID = spawn(fun() -> ring_process(first) end ),
    io:format("Create process with PID ~p linked to first\n", [PID]),
    create(N-1, PID).

% Receive message
ring_process(Next) -> 
    receive 
        stop -> 
            io:format("PID ~p: stopping\n", [self()]),
            exit(stop);
        {Count, Message} -> send_message(Count, Message, Next)
    end.
% Send message
send_message(0, _, Next) ->             
    io:format("Stop from ~p to ~p\n", [self(), Next]),
    catch Next ! stop;
send_message(Count, Message, Next) ->
    io:format("From ~p to ~p - ~p:~p\n", [self(), Next, Count, Message]),
    catch Next ! {Count, Message},
    send_message(Count-1, Message, Next).