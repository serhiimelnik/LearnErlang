-module(pool_sup).
-author("Serhii Melnyk").
-bahaviour(supervisor).

-export([start_link/0, init/1, start_pool/3, stop_pool/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_pool(Name, Limit, MFA) ->
  ChildSpec = {Name,
                {ppool_sup, start_link, [Name, Limit, MFA]},
                permanent, 10500, supervisor, [ppool_sup]},
  supervisor:start_child(ppool, ChildSpec).

stop_pool(Name) ->
  supervisor:terminate_child(ppool, Name),
  supervisor:delete_child(ppool, Name).

init([]) ->
  SupFlags = #{strategy => simple_one_for_one, intensity => 1, period => 5},
  ChildSpecs = [#{id => pool_worker_sup,
    start => {pool_worker_sub, start_link, [Name, Limit, MFA]},
    restart => permanent,
    shutdown => brutal_kill,
    type => supervisor,
    modules => [pool_sup]}],
  {ok, {SupFlags, ChildSpecs}}.
