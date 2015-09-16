-module(pool_app).
-author("Serhii Melnyk").
-behaviour(application).
-bahaviour(supervisor).

-export([start/2, stop/1]).
-export([init/1]).
-export([create/1]).

-spec create(Size :: integer()) -> pid().
create(Size) ->
  {ok, PoolPid} = supervisor:start_child(pool_sup, []),
  [pool_worker_sup:start_child() || X <- lists:seq(1, Size)],
  PoolPid.

start(_, _) ->
  supervisor:start_link({local, pool_sup}, ?MODULE, []).

stop(_) ->
  ok.

init(_) ->
  SupFlags = #{strategy => simple_one_for_one, 
               intensity => 1, 
               period => 5},
  PoolWorkerSupSpec = #{id => pool_worker_sup,
                        start => {pool_worker_sup, start_link, []},
                        restart => permanent,
                        shutdown => brutal_kill,
                        type => supervisor,
                        modules => [pool_sup]},
  {ok, {SupFlags, [PoolWorkerSupSpec]}}.
