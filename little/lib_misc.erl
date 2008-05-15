-module (lib_misc).
-compile (export_all).

% Our own for control structure
for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I+1, Max, F)].

% The world famous quicksort
quicksort([]) -> [];
quicksort([Pivot|T]) ->
  quicksort([X || X <- T, X < Pivot])
  ++ [Pivot] ++
  quicksort([X || X <- T, X > Pivot]).

% Creating pythagorean triplets
% Up to N (A^2 + B^2 = C^2)
pythagorean_triplets(N) ->
  [ {A,B,C} ||
    A <- lists:seq(1, N),
    B <- lists:seq(1, N),
    C <- lists:seq(1, N),
    A + B + C =< N,
    A * A + B * B =:= C * C
  ].

% Find all permutations of a word
permutations([]) -> [[]];
permutations(L) -> [ [H|T] || H <- L, T <- permutations(L -- [H]) ].

% Separate list into odds and evens
odds_and_evens(L) ->
  Odds = [X || X <- L, X rem 2 =:= 1],
  Evens = [X || X <- L, X rem 2 =:= 0],
  {Odds, Evens}.

odds_and_evens_acc(L) ->
  odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of
    1 -> odds_and_evens_acc(T, [H|Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H|Evens])
  end;
odds_and_evens_acc([], Odds, Evens) ->
  {lists:reverse(Odds), lists:reverse(Evens)}.

sleep(T) ->
    receive
    after T ->
	true
    end.

flush_buffer() ->
    receive
	_Any ->
	    flush_buffer()
    after 0 ->
	    true
    end.

priority_receive() ->
    receive
	{alarm, X} ->
	    {alarm, X}
    after 0 ->
	    receive
		Any ->
		    Any
	    end
    end.

