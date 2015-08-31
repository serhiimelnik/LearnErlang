-module(functions).

-export([head/1, second/1, valid_time/1]).

head([H|_]) -> H.

second([_,X|_]) -> X.

valid_time({Date = {Y,M,D}, Time = {H,Min,S}}) ->
  io:format("Date taple (~p) say today: ~p/~p/~p,~n", [Date,Y,M,D]),
  io:format("Time taple (~p) show: ~p:~p:~p,~n", [Time,H,Min,S]);
valid_time(_) ->
  io:format("Wrong data!~n").