-module(collatz).
-author("Serhii Melnyk").

-export([collatz/1]).

collatz(N) -> collatz(N, 0, []).

collatz(1, C, Acc) -> io:format("~w~n Number of steps - ~w~n", [lists:reverse(Acc), C]);
collatz(N, C, Acc) when N rem 2 =:= 0 -> collatz(N, C + 1, [N / 2 |Acc]);
collatz(N, C, Acc) when N rem 2 =/= 0 -> collatz(N, C + 1, [N * 3 + 1 |Acc]);
collatz(_, _, Acc) -> Acc.
