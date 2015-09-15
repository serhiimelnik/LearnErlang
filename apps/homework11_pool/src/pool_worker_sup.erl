-module(pool_worker_sup).
-author("Serhii Melnyk").
-bahaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  SupFlags = #{strategy => simple_one_for_one, intensity => 1, period => 5},
  ChildSpecs = [#{id => pool_worker,
    start => {pool_worker, start_link, []},
    restart => temporary,
    shutdown => brutal_kill,
    type => worker,
    modules => [pool_worker_sup]}],
  {ok, {SupFlags, ChildSpecs}}.