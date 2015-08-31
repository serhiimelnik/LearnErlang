-module(useless).
%%% Modules in learnyousomeerlang
-export([add/2, hello/0, greet_and_add_two/1]).
-define(HOUR, 3600). % in seconds

%% return sum A + B
add(A,B) ->
  A + B.

%% Print Hello
hello() ->
  io:format("Hello, world!~n").

greet_and_add_two(X) ->
  hello(),
  add(X,?HOUR).