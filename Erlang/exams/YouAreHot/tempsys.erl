-module(tempsys).
-export([startsys/0]).
startsys() -> 
    register('FromC', spawn(fun() -> loop_first(fun(T) -> T end ) end)),
    register('FromF', spawn(fun() -> loop_first(fun(T) -> (T - 32)/9/5 end ) end)),
    register('FromK', spawn(fun() -> loop_first(fun(T) -> T - 273.15 end ) end)),
    register('FromR', spawn(fun() -> loop_first(fun(T) -> (T-491.67)*5/9 end ) end)),
    register('FromDe', spawn(fun() -> loop_first(fun(T) -> 100 - (T * 2/3) end ) end)),
    register('FromN', spawn(fun() -> loop_first(fun(T) -> T * 100/33 end ) end)),
    register('FromRe', spawn(fun() -> loop_first(fun(T) -> T * 5/4 end ) end)),
    register('FromRo', spawn(fun() -> loop_first(fun(T) -> (T-7.5) * 40/21  end ) end)),

    register('ToC', spawn(fun() -> loop_second(fun(T) -> T end ) end)),
    register('ToF', spawn(fun() -> loop_second(fun(T) -> T * 9/5 + 32 end ) end)),
    register('ToK', spawn(fun() -> loop_second(fun(T) -> T + 273.15 end ) end)),
    register('ToR', spawn(fun() -> loop_second(fun(T) -> (T + 273.15) * 9/5 end ) end)),
    register('ToDe', spawn(fun() -> loop_second(fun(T) -> (100 - T) * 3/2 end ) end)),
    register('ToN', spawn(fun() -> loop_second(fun(T) -> T * 33/100 end ) end)),
    register('ToRe', spawn(fun() -> loop_second(fun(T) -> T * 4/5 end ) end)),
    register('ToRo', spawn(fun() -> loop_second(fun(T) -> T * 21/40 + 7.5 end ) end)),

    register(client, spawn(fun() -> client_loop() end) ).

client_loop() ->
    receive
        {convert, FromScale, ToScale, T} -> 
            list_to_atom("From"++atom_to_list(FromScale)) ! {convert, {self(), ToScale, T}},
            receive
                {converted, T2} -> io:format("~p°~p are equivalent to ~p°~p~n", [T, FromScale, T2, ToScale])
            end,
            client_loop()
    end.

loop_first(F) -> 
    receive
        {convert, {Pid, ToScale, T}} -> 
            %io:format("Received from ~p convert to ~p, ~p, sended to ~p~n", [Pid, ToScale, T, whereis(list_to_atom("To"++atom_to_list(ToScale)))]),
            list_to_atom("To"++atom_to_list(ToScale)) ! {convert, {self(), F(T)}},
            receive 
                {converted, T2} -> Pid ! {converted, T2} 
            end,
            loop_first(F)
    end.
loop_second(F) -> 
    receive
        {convert, {Pid, T}} -> 
            %io:format("Received from ~p convert, ~p~n", [Pid, T]),
            Pid ! {converted, F(T)}, 
            loop_second(F)
    end.