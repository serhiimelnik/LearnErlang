-module(complex4).
-export([foo/1, bar/1]).

foo(X) ->
  call_node({foo, X}).
bar(Y) ->
  call_node({bar, Y}).

call_node(Msg) ->
  {any, 'cnode@hostname'} ! {self(), Msg},
  receive
    {cnode, Result} ->
      Result
  end.
