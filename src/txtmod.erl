-module(txtmod).
-include("/usr/local/lib/yaws/include/yaws_api.hrl").
-include("svatek.hrl").
-export([out/1]).


out(Arg) ->
    case (Arg#arg.req#http_request.method) of
        'GET' ->
            Svatky = svatkymod:out(1, 2),
            Print = fun(Svatek) -> yaws_api:f("~2..0w~2..0w;~s~n", [Svatek#svatek.day, Svatek#svatek.month, binary_to_list(Svatek#svatek.name)]) end,
            {content, "text/plain; charset=utf-8", lists:map(Print, Svatky)};
        _Else ->
            [{status, 405},
             {header, "Allow: GET"},
             {html, "Method Not Allowed"}]
    end.
