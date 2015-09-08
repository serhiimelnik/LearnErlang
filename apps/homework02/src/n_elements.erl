-module(n_elements).
-author("Serhii Melnyk").

-export([take/2]).

take(N, L) -> lists:reverse(take(N, L, [])).

take(0, _, Acc)     -> Acc;
take(_, [], Acc)    -> Acc;
take(N, [H|T], Acc) -> take(N - 1, T, [H|Acc]).
