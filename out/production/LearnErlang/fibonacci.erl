-module(fibonacci).
-author("Serhii Melnyk").

-export([fibonacci/1]).

fibonacci(N) when is_integer(N), N > 0 -> fibonacci(N, 0, 1).

fibonacci(0, _, S) -> S;
fibonacci(1, _, S) -> S;
fibonacci(N, F, S) -> fibonacci(N - 1, S, S + F).
