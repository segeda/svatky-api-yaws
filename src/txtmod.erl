-module(txtmod).
-include("/usr/local/lib/yaws/include/yaws_api.hrl").
-include("svatek.hrl").
-export([out/1]).


out(Arg) ->
    case (Arg#arg.req#http_request.method) of
        'GET' ->
            Svatky = svatkymod:out(),
            {content, "text/plain", yaws_api:f("~p", [Svatky])};
        _Else ->
            [{status, 405},
             {header, "Allow: GET"},
             {html, "Method Not Allowed"}]    
    end.
