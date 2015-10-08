-module(pool_app).
-behaviour(application).
-export([start/2, stop/1, start_pool/1,
  async_queue/2, stop_pool/0]).
-define(WORKER_NAME, worker).

start(normal, _Args) ->
  io:format("done"),
  pool_supersup:start_link().

stop(_State) ->
  ok.

start_pool(Limit) ->
  pool_supersup:start_pool(?WORKER_NAME, Limit, {pool_worker, start_link, []}).

stop_pool() ->
  pool_supersup:stop_pool(?WORKER_NAME).

async_queue(Args, Size) ->
  [pool_gen:async_queue(?WORKER_NAME, Args) || X <- lists:seq(1, Size)].