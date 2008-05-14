-module(area_server0).
-export([loop/0]).

loop() ->
    receive
	{rectangle, Width, Height} ->
	    io:format("Area of a rectangle is ~p~n", [Width * Height]),
	    loop();
	{circle, R} ->
	    io:format("Area of a circle is ~p~n", [3.14159 * R * R]),
	    loop();
	Other ->
	    io:format("I don't know what the area of ~p is ~n", [Other]),
	    loop()
    end.
