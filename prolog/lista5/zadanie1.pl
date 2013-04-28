flatten(List, Flattened):-
  flatten(List, Flattened, []).

flatten([], Flattened, Flattened).
flatten([H|T], [H|Flattened], Acc):-
  atomic(H), !,
  flatten(T, Flattened, Acc).
flatten([H|T], Flattened, Acc):-
  flatten(T, TailFlattened, Acc),
  flatten(H, Flattened, TailFlattened).