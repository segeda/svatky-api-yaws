-module(svatkymod).
-include("svatek.hrl").
-include("cs.hrl").
-export([out/0, out/1, out/2]).


out() ->
    {_Year, Month, Day} = erlang:date(),
    out(Month, Day).


out(Name) ->
    Pred = fun(Svatek) -> Svatek#svatek.name =:= Name end,
    lists:filter(Pred, ?CS).


out(Month, Day) ->
    Pred = fun(Svatek) -> Svatek#svatek.month =:= Month andalso Svatek#svatek.day =:= Day end,
    lists:filter(Pred, ?CS).
    