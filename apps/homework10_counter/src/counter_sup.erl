-module(counter_sup).
-author("Serhii Melnyk").
-bahaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
  ChildSpecs = [#{id => counter_worker,
    start => {counter_worker, start_link, []},
    restart => permanent,
    shutdown => brutal_kill,
    type => worker,
    modules => [counter]}],
  {ok, {SupFlags, ChildSpecs}}.