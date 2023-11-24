- module(client).
- export([test/0]).
test() ->
    counting:start(),
    counting:dummy1(),
    counting:tot(),
    counting:dummy2(),
    counting:dummy2(),
    counting:tot(),
    rime:sleep(1000),
    counting:stop().