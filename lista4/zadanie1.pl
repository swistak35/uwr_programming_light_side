length2(X, Y):-
  length2(X, Y, 0).
length2([], Y, Y).
length2([_|Tail], Y, Acc):-
  Acc \== Y,
  NextAcc is Acc+1,
  length2(Tail, Y, NextAcc).