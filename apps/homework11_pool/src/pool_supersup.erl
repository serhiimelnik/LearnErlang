-module(pool_supersup).
-behaviour(supervisor).
-export([start_link/0, start_pool/3, stop_pool/1]).
-export([init/1]).

start_link() ->
  supervisor:start_link({local, pool}, ?MODULE, []).

start_pool(Name, Limit, MFA) ->
  ChildSpec = {Name,
                {pool_sup, start_link, [Name, Limit, MFA]},
                permanent, 10500, supervisor, [pool_sup]},
  supervisor:start_child(pool, ChildSpec).

stop_pool(Name) ->
  supervisor:terminate_child(pool, Name),
  supervisor:delete_child(pool, Name).

init([]) ->
  MaxRestart = 6,
  MaxTime = 3000,
  {ok, {{one_for_one, MaxRestart, MaxTime}, []}}.