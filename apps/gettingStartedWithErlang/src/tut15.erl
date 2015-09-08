-module(tut15).

-export([start/0, ping/2, pong/0]).

ping(0, Pong_PID) ->
  Pong_PID ! finished,
  io:format("Ping finalized~n", []);

ping(N, Pong_PID) ->
  Pong_PID ! {ping, self()},
  receive
    pong ->
      io:format("Ping Pong received~n", [])
  end,
  ping(N - 1, Pong_PID).

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
  Pong_PID = spawn(tut15, pong, []),
  spawn(tut15, ping, [3, Pong_PID]).
