-module(lazy).

-compile(export_all).

%% generator(F, V) -> fun() -> [ V | generator(F,  F(V)) ] end.
generator(F, V) -> [V | fun() -> generator(F, F(V)) end].

take(N, G) when N >= 0 -> lists:reverse(take(N, G, 0, [])).

take(_,[],_,Acc) -> Acc;
take(N,_,N,Acc)  -> Acc;
take(N, [H|T], C, Acc) when is_function(T) -> take(N, T(), C+1, [H|Acc]);
take(N, [H|T], C, Acc) -> take(N, T, C+1, [H|Acc]).
