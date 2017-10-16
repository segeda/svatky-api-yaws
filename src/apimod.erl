-module(apimod).

-include("/usr/local/lib/yaws/include/yaws_api.hrl").

-export([out/3, svatky/1]).

svatky(Arg) ->
    Q = yaws_api:parse_query(Arg),
    N = case lists:keyfind("name", 1, Q) of
	  {"name", Name} when Name =/= [] ->
	      Name_ = list_to_binary(Name), {"name", Name_};
	  _ -> false
	end,
    M = case lists:keyfind("month", 1, Q) of
	  {"month", Month} when Month =/= [] ->
	      try list_to_integer(Month) of
		Month_ when Month_ > 0 andalso Month_ < 13 ->
		    {"month", Month_};
		_ -> false
	      catch
		_:_ -> false
	      end;
	  _ -> false
	end,
    D = case lists:keyfind("day", 1, Q) of
	  {"day", Day} when Day =/= [] ->
	      try list_to_integer(Day) of
		Day_ when Day_ > 0 andalso Day_ < 32 -> {"day", Day_};
		_ -> false
	      catch
		_:_ -> false
	      end;
	  _ -> false
	end,
    by(N, M, D).

by({"name", Name}, _, _) -> svatkymod:by_name(Name);
by(_, {"month", Month}, {"day", Day}) ->
    svatkymod:by_month_day(Month, Day);
by(_, {"month", Month}, _) -> svatkymod:by_month(Month);
by(_, _, {"day", Day}) -> svatkymod:by_day(Day);
by(_, _, _) ->
    {_Year, Month, Day} = erlang:date(),
    svatkymod:by_month_day(Month, Day).

out(Arg, MimeType, Content) ->
    case (Arg#arg.req)#http_request.method of
      'GET' -> {content, MimeType, Content};
      _Else ->
	  [{status, 405}, {header, "Allow: GET"},
	   {html, "Method Not Allowed"}]
    end.
