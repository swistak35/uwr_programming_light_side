sublist(_,[]).
sublist([H|T],[H|S]):-
  sublist(T,S).
sublist([_|T],S):-
  sublist(T,S).


concat_number(Digits, Num):-
  concat_number(Digits, 0, Num).
concat_number([], Res, Res).
concat_number([H|T], Acc, Res):-
  NextAcc is (Acc * 10) + H,
  concat_number(T, NextAcc, Res).

?- length(_L, 7),
  sublist([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], _L),
  permutation([_A, _C, _E, _P, _R, _S, _U], _L),
  _U \= 0,
  _P \= 0, 
  concat_number([_U, _S, _A], USA),
  concat_number([_U, _S, _S, _R], USSR),
  concat_number([_P, _E, _A, _C, _E], PEACE),
  PEACE is USA + USSR.