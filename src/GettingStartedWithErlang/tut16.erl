-module(tut16).

-export([start/0, ping/1, pong/0]).

ping(0) ->
  pong ! finished,
  io:format("Ping finalized~n", []);

ping(N) ->
  pong ! {ping, self()},
  receive
    pong ->
      io:format("Ping Pong received~n", [])
  end,
  ping(N - 1).

pong() ->
  receive
    finished ->
      io:format("Pong finalized~n", []);
    {ping, Ping_PID} ->
      io:format("Pong Ping received~n", []),
      Ping_PID ! pong,
      pong()
  end.

start() ->
  register(pong, spawn(tut15, pong, [])),
  spawn(tut16, ping, [3]).
