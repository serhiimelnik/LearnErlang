-module(tut17).

-export([start_ping/1, start_pong/0,  ping/2, pong/0]).

ping(0, Pong_Node) ->
  {pong, Pong_Node} ! finished,
  io:format("Ping finalized~n", []);

ping(N, Pong_Node) ->
  {pong, Pong_Node} ! {ping, self()},
  receive
    pong ->
      io:format("Ping Pong received~n", [])
  end,
  ping(N - 1, Pong_Node).

pong() ->
  receive
    finished ->
      io:format("Pong finalized~n", []);
    {ping, Ping_PID} ->
      io:format("Pong Ping received~n", []),
      Ping_PID ! pong,
      pong()
  end.

start_pong() ->
  register(pong, spawn(tut17, pong, [])).

start_ping(Pong_Node) ->
  spawn(tut17, ping, [3, Pong_Node]).
