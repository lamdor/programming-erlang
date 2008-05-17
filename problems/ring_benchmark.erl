-module(ring_benchmark).
-export([benchmark/1]).

benchmark([N,M]) ->
    benchmark(convert(N),convert(M)).

convert(Atom) ->
    list_to_integer(atom_to_list(Atom)).

benchmark(N, M) ->
    statistics(runtime),
    statistics(wall_clock),
    Main_process = self(),
%    io:format("Creating ~p ring processes~n", [N]),
    spawn(fun() -> ring(1,N,M,self(), Main_process) end),
    receive
	ended -> void
    end,
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),
    io:format("Ring benchmark for ~p processes and ~p messages (~p Total Messags) = ~p (~p) milliseconds ~n", [N, M, N*M, Time1, Time2]).

ring(N, N, M, First_process, Main_process) ->
%    io:format("Ring process ~p (~p) created.~n", [N,self()]),
%    io:format("Sending ~p messages through the ring.~n", [M]),
    First_process ! {send, main_process, Main_process},
    loop(M, N, N, First_process, Main_process);
ring(I, N, M, First_process, Main_process) ->
%    io:format("Ring process ~p (~p) created.~n", [I,self()]),
    Next_process = spawn(fun() ->
				 ring(I+1,N,M,First_process,Main_process) end),
    loop(M,I,N,Next_process, Main_process).

loop(0, N, N, _, Main_process) ->
%    io:format("Ring process ~p (~p) finished~n", [N, self()]),
    Main_process ! ended;
loop(0, I, _N, _Next_process, _Main_process) ->
    void;
%    io:format("Ring process ~p (~p) finished~n", [I, self()]);
loop(M, I, N, Next_process, Main_process) ->
    receive
	{send, From, From_process} ->
%	    io:format("Process ~p (~p) received message ~p from process ~p (~p)~n", [I, self(), M, From, From_process]),
	    Next_process ! {send, I, self()},
	    loop(M - 1, I, N, Next_process, Main_process)
    end.

