-module(pool_sup).
-author("Serhii Melnyk").
-bahaviour(supervisor).

-export([start_link/0, init/1]).

start_link(MFA = {_,_,_}) ->
  supervisor:start_link(?MODULE, MFA).

init({M,F,A}) ->
  SupFlags = #{strategy => simple_one_for_one, intensity => 1, period => 5},
  ChildSpecs = [#{id => pool_worker,
    start => {pool_worker, start_link, {M,F,A}},
    restart => temporary,
    shutdown => brutal_kill,
    type => worker,
    modules => [M]}],
  {ok, {SupFlags, ChildSpecs}}.
