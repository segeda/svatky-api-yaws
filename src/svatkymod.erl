-module(svatkymod).
-include("svatek.hrl").
-export([out/0, out/1, out/2]).


svatky() ->
    [#svatek{month = 1, day = 1, name = "Jméno0101"},
     #svatek{month = 2, day = 2, name = "Jméno0102"}].


out() ->
    {_, Month, Day} = erlang:date(),
    out(Month, Day).


out(Name) ->
    {Name}.


out(Month, Day) ->
    {Month, Day}.
    