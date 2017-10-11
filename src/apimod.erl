-module(apimod).

-include("/usr/local/lib/yaws/include/yaws_api.hrl").

-export([out/3, svatky/1]).

svatky(Arg) ->
    Q = yaws_api:parse_query(Arg),
    [io:format("~p:~p~n", [K, V])
     || {K, V} <- Q,
	lists:member(K, ["name", "month", "day"]),
	V =/= undefined andalso V =/= []],
    {_Year, Month, Day} = erlang:date(),
    svatkymod:by_month_day(Month, Day).

out(Arg, MimeType, Content) ->
    case (Arg#arg.req)#http_request.method of
      'GET' -> {content, MimeType, Content};
      _Else ->
	  [{status, 405}, {header, "Allow: GET"},
	   {html, "Method Not Allowed"}]
    end.
