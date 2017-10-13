-module(apimod_SUITE).

-include("/usr/local/lib/yaws/include/yaws.hrl").

-include("/usr/local/lib/yaws/include/yaws_api.hrl").

-include("../src/svatek.hrl").

-include_lib("common_test/include/ct.hrl").

-export([all/0, end_per_suite/1, init_per_suite/1]).

-export([svatky_name_martin/1, svatky_name_petr/1]).

all() -> [svatky_name_martin, svatky_name_petr].

init_per_suite(InitConfig) ->
    SC = #sconf{servername = "localhost", ssl = undegined},
    put(sc, SC),
    InitConfig.

end_per_suite(_InitConfig) -> ok.

svatky_name_martin(_Config) ->
    Arg = #arg{req =
		   #http_request{path = {abs_patch, "/?name=Martin"}},
	       headers = #headers{}},
    [#svatek{month = 11, day = 11, name = <<"Martin">>}] =
	apimod:svatky(Arg).

svatky_name_petr(_Config) ->
    Arg = #arg{req =
		   #http_request{path = {abs_patch, "/?name=Petr"}},
	       headers = #headers{}},
    [#svatek{month = 2, day = 22, name = <<"Petr">>},
     #svatek{month = 6, day = 29, name = <<"Petr">>}] =
	apimod:svatky(Arg).
