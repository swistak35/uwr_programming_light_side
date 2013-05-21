'!!'(0, 1):-!.
'!!'(1, 1):-!.
'!!'(N, R):-
  Ntmp is N - 2,
  '!!'(Ntmp, Rtmp),
  R is N * Rtmp.
:-arithmetic_function('!!'/1).
:-op(50, yf, '!!').

!(0, 1):-!.
!(N, R):-
  Ntmp is N - 1,
  !(Ntmp, Rtmp),
  R is N * Rtmp.
:-arithmetic_function(!/1).
:-op(100, yf, !).