-module(collatz).
-author("Serhii Melnyk").

-export([collatz/1]).

collatz(N) when is_integer(N), N > 0 -> collatz(N, 0, [N]).

collatz(1, C, Acc) -> io:format("~w~nNumber of steps - ~w~n", [lists:reverse(Acc), C]);
collatz(N, C, Acc) when N rem 2 =:= 0 ->
  R = N div 2,
  collatz(R, C + 1, [R|Acc]);
collatz(N, C, Acc) when N rem 2 =:= 1 ->
  R = N * 3 + 1,
  collatz(R, C + 1, [R|Acc]).
