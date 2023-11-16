% Then write a client to be connected to such a server and link these two processes each other. 
% When the stop function is called, instead of sending the stop message, make the first process terminate abnormally. 
% This should result in the EXIT signal propagating to the other process, causing it to terminate as well.
- module(client).
- export([start/0]).
start() -> 
    server:start(),
    link(whereis(server)),
    print(100),
    server:stop().
print(0) -> 0;
print(N) ->
    server:print(N),
    timer:sleep(50),
    print(N-1).