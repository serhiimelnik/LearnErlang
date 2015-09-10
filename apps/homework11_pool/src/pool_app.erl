-module(pool_app).
-author("Serhii Melnyk").
-behaviour(application).

-export([start/2, stop/1]).

start(_, _) ->
    pool_sup:start_link().

stop(_) ->
    ok.
