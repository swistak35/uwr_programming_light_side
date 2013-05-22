perm([],[]).
perm(L,[PH|PT]):-
  select(PH, L, LT),
  perm(LT, PT).
