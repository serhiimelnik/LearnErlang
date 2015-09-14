-module(pool_app).
-author("Serhii Melnyk").
-behaviour(application).

-export([start/2, stop/1]).
-export([create/0]).

start(_, _) ->
  pool_sup:start_link().

stop(_) ->
  ok.

create() ->
  pool_sup:start_child().
    