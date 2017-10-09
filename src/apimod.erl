-module(apimod).
-include("/usr/local/lib/yaws/include/yaws_api.hrl").
-export([svatky/1, out/3]).


svatky(Arg) ->
    Q = yaws_api:parse_query(Arg),
    N = case lists:keysearch("name", 1, Q) of
            {value, {"name", Name}} when Name =/= undefined andalso Name =/= [] -> Name;
            _ -> undefined
        end,
    M = case lists:keysearch("month", 1, Q) of
            {value, {"month", Month}} when Month =/= undefined andalso Month =/= [] -> Month;
            _ -> undefined
        end,
    D = case lists:keysearch("day", 1, Q) of
            {value, {"day", Day}} when Day =/= undefined andalso Day =/= [] -> Day;
            _ -> undefined
        end,
    io:format("Name:~p; Month:~p; Day:~p~n", [N, M, D]),
    {_Year, Month_, Day_} = erlang:date(),
    svatkymod:by_month_day(Month_, Day_).


out(Arg, MimeType, Content) ->
    case (Arg#arg.req#http_request.method) of
        'GET' ->
            {content, MimeType, Content};
        _Else ->
            [{status, 405},
             {header, "Allow: GET"},
             {html, "Method Not Allowed"}]
    end.
