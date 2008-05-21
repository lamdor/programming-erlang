-module(simple).
-include_lib("eunit/include/eunit.hrl").

basic_test() ->
    ?assert(1 + 1 == 2).

length_test() ->
    ?assert(length([1,2,3]) == 3).

reverse_nil_test() ->
    [] = lists:reverse([]).

reverse_one_test() ->
    [1] = lists:reverse([1]).

reverse_two_test() ->
    [1,2] = lists:reverse([2,1]).
