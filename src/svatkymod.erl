-module(svatkymod).
-include("svatek.hrl").
-include("cs.hrl").
-export([by_name/1, by_month/1, by_day/1, by_month_day/2]).


by_name(Name) ->
    Pred = fun(Svatek) -> Svatek#svatek.name =:= Name end,
    lists:filter(Pred, ?CS).


by_month(Month) ->
    Pred = fun(Svatek) -> Svatek#svatek.month =:= Month end,
    lists:filter(Pred, ?CS).


by_day(Day) ->
    Pred = fun(Svatek) -> Svatek#svatek.day =:= Day end,
    lists:filter(Pred, ?CS).


by_month_day(Month, Day) ->
    Pred = fun(Svatek) -> Svatek#svatek.month =:= Month andalso Svatek#svatek.day =:= Day end,
    lists:filter(Pred, ?CS).
    