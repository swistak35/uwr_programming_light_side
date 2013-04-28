even([]).
even([_|T]):-
  odd(T).
odd([_|T]):-
  even(T).

palindrom(X) :- X = Y, reverse(X,Y).

singleton([_|[]]).
