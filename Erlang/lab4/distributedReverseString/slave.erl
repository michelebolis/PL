-module(slave).
-export([reverse/3]).
reverse(K, Master, Stringa) -> 
    Master ! {reversed, K, lists:reverse(Stringa)}.