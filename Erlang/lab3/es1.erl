- module(es1).
- export([is_palindrome/1, is_an_anagram/2, factors/1, is_proper/1]).

% is_palindrome: string → bool that checks if the string given as input is palindrome, 
% a string is palindrome when the represented sentence can be read the same way 
% in either directions in spite of spaces, punctual and letter cases, 
% e.g., detartrated, "Do geese see God?", "Rise to vote, sir.", ...;
is_palindrome("") -> true;
is_palindrome(S) -> 
    Lista = re:split(S, "[ .,?]", [{return, list}]),
    S_lowered = string:lowercase(string:join(Lista, "")),
    string:equal(S_lowered, string:reverse(S_lowered)).

% is_an_anagram : string → string list → boolean that given a dictionary of strings, 
% checks if the input string is an anagram of one or more of the strings in the dictionary;
is_an_anagram(S, []) -> false;
is_an_anagram(S, [H|TL]) -> is_empty((lists:sort(H) -- lists:sort(S)) ++ (lists:sort(S) -- lists:sort(H)), TL).

is_empty(S, TL) when S == [] -> true;
is_empty(S, TL) -> is_an_anagram(S, TL).

% factors: int → int list that given a number calculates all its prime factors;
factors(N) when N =< 1 -> [];
factors(N) -> [X || X <- lists:seq(2, N+1), is_prime(X), N rem X == 0].

is_prime(N) -> length([X || X <- lists:seq(2, N-1), N rem X == 0])==0.

% is_proper: int → boolean that given a number calculates if it is a perfect number or not, 
% where a perfect number is a positive integer equal to the sum of its proper positive divisors (excluding itself), 
% e.g., 6 is a perfect number since 1, 2 and 3 are the proper divisors of 6 and 6 is equal to 1+2+3;
is_proper(N) -> lists:foldl(fun(X, Sum) -> X+Sum end, 0, divisors(N)) == N.
divisors(N) -> [X || X <- lists:seq(1, N-1), N rem X == 0].