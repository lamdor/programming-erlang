-module(fib).
-export([fib/1]).
-include_lib("eunit/include/eunit.hrl").

fib(N) ->
    fib(N, 1).

fib(0, Acc) ->
    Acc;
fib(N, Acc) ->
    fib(N - 1, N * Acc).

fib_test_() ->
    [?_assert(fib(0) == 1),
     ?_assert(fib(1) == 1),
     ?_assert(fib(2) == 2),
     ?_assert(fib(3) == 6)
    ].





