zrob_liste([_]).
zrob_liste([_|Y]):-
  zrob_liste(Y). 

fill([]).
fill([0|Xs]):-
  fill(Xs).
fill([1|Xs]):-
  fill(Xs).

bin([0]). 
bin([1]). 
bin([1|X]):-
  zrob_liste(X),
  fill(X).

rfill([1]).
rfill([0|Xs]):-
  rfill(Xs).
rfill([1|Xs]):-
  rfill(Xs).

rbin([0]). 
rbin(X):-
  zrob_liste(X),
  rfill(X).