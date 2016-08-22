-module(complex3).
-export([foo/1, bar/1]).

foo(X) ->
  call_node({foo, X}).

bar(Y) ->
  call_node({bar, Y}).

call_node(Msg) ->
  {ok, Hostname} = inet:gethostname(),
  {any, list_to_atom("c1@" ++ string:to_lower(Hostname))} ! {self(), Msg},
  receive
    {cnode, Result} ->
      Result
  end.
