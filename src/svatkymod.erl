-module(svatkymod).
-include("svatek.hrl").
-export([out/0, out/1, out/2]).


svatky() ->
    [#svatek{month = 1, day = 1, name = <<"Jméno0101"/utf8>>},
     #svatek{month = 1, day = 2, name = <<"ěščřžýáíé"/utf8>>},
     #svatek{month = 1, day = 2, name = <<"Jméno0102b"/utf8>>},
     #svatek{month = 2, day = 1, name = <<"Jméno0201"/utf8>>}].


out() ->
    {_Year, Month, Day} = erlang:date(),
    out(Month, Day).


out(Name) ->
    {Name}.


out(Month, Day) ->
    Svatky = svatky(),
    Pred = fun(Svatek) -> Svatek#svatek.month =:= Month andalso Svatek#svatek.day =:= Day end,
    lists:filter(Pred, Svatky).
    