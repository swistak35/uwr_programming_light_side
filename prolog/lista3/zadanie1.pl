perm([],[]).
perm([LH|LT],P):-
  perm(LT, X),
  select(LH, P, X).
