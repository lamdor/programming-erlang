-module(attrs).
-vsn(1234).
-author({luke,amdor}).
-purpose("an example of attributes").
-export([fac/1]).

fac(1) -> 1;
fac(X) -> X * fac(X-1).
