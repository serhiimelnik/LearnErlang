-module(pool_sup).
-author("Serhii Melnyk").
-bahaviour(supervisor).

-export([start_link/0, init/1]).
-export([start_child/0]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_child() ->
  ChildSpecs = [#{id => pool_worker_sup1,       
                 start => {pool_worker_sup, start_link, []},      
                 restart => permanent,   
                 shutdown => brutal_kill, 
                 type => supervisor,       
                 modules => [pool_sup]}], 
  supervisor:start_child(?MODULE, []).

init([]) ->
  SupFlags = #{strategy => simple_one_for_one, intensity => 1, period => 5},
  ChildSpecs = [#{id => pool_worker_sup,
    start => {pool_worker_sup, start_link, []},
    restart => permanent,
    shutdown => brutal_kill,
    type => supervisor,
    modules => [pool_sup]}],
  {ok, {SupFlags, ChildSpecs}}.