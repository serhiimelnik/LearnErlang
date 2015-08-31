-module(zip_with).
-author("Serhii Melnyk, Viktor Kudlai").

-export([zip_with/3]).

zip_with(F, L1, L2) -> lists:reverse(zip_with_rec(F, L1, L2, [])).

zip_with_rec(_F, [], [], Acc) -> Acc;
zip_with_rec(_F, [], _, Acc) -> Acc;
zip_with_rec(_F, _, [], Acc) -> Acc;
zip_with_rec(F, [H1|T1], [H2|T2], Acc) ->
  zip_with_rec(F, T1, T2, [F(H1,H2)|Acc]).
