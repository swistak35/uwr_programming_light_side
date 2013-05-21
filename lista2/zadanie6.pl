sublist(_,[]).
sublist([H|T],[H|S]):-
  sublist(T,S).
sublist([_|T],S):-
  sublist(T,S).
