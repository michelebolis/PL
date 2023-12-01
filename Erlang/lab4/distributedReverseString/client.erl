-module(client).
-export([reverse_string/2]).
reverse_string(W, NSlaves) -> 
    Reversed = server:long_reversed_string(W, NSlaves),
    io:format("String: ~p~nReversed: ~p~nTest: ~p~n", [W, Reversed, string:equal(string:reverse(W),Reversed)]).