-module(txtmod).

-include("/usr/local/lib/yaws/include/yaws_api.hrl").

-include("svatek.hrl").

-export([out/1]).

out(Arg) ->
    Print = fun (Svatek) ->
		    yaws_api:f("~2..0w~2..0w;~s~n",
			       [Svatek#svatek.day, Svatek#svatek.month,
				binary_to_list(Svatek#svatek.name)])
	    end,
    Svatky = apimod:svatky(Arg),
    Content = lists:map(Print, Svatky),
    apimod:out(Arg, <<"text/plain; charset=utf-8">>,
	       Content).
