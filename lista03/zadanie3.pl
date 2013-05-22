factorial(0,1):-
  !.
factorial(X,Y):-
  X > 0,
  DecreasedX is X-1,
  factorial(DecreasedX, DecreasedY),
  Y is DecreasedY * X.

concat_number(Digits, Num):-
  concat_number(Digits, 0, Num).
concat_number([], Res, Res).
concat_number([H|T], Acc, Res):-
  NextAcc is (Acc * 10) + H,
  concat_number(T, NextAcc, Res).

%decimal(0, Res, Res):-!.
decimal(0, Acc, Res):-
  !,
  Acc = Res.
decimal(Num, Acc, Res):-
  CurrentDigit is Num mod 10,
  NewNum is Num // 10,
  decimal(NewNum, [CurrentDigit|Acc], Res).


