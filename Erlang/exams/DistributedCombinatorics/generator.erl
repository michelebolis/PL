-module(generator).
-export([generate/3]).
generate(Ntot, N, M) -> % start
    generate(N, M, trunc(math:pow(M, Ntot-N)), 1, 1, trunc(math:pow(M, Ntot)), [1]).
% all the number in the column have been generated, send result to master
generate(N, _, _, _, _, Limit, Acc) when length(Acc) == Limit -> 
    master ! {N, Acc};
% increase the number in the column and set 0 to repeatCount
generate(N, M, Repeat, RepeatCount, ToRepeat, Limit, Acc) when RepeatCount == Repeat ->
    generate(N, M, Repeat, 0, ToRepeat+1, Limit, Acc);
% set the number in the column to 1 (repeatCount already at 0)
generate(N, M, Repeat, RepeatCount, ToRepeat, Limit, Acc) when ToRepeat > M ->
    generate(N, M, Repeat, RepeatCount, 1, Limit, Acc);
% add the number in the column and increase the repeatCount
generate(N, M, Repeat, RepeatCount, ToRepeat, Limit, Acc) ->
    generate(N, M, Repeat, RepeatCount+1, ToRepeat, Limit, Acc++[ToRepeat]).