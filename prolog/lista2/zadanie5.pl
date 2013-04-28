head(H,[H|_]).

last([H|[]],H).
last([_|T],H):-
  last(T,H).

tail(T,[_|T]).

init([_|[]],[]).
init([H|X],[H|T]):-
  init(X,T).

prefix([H|[]],[H|_]).
prefix([H|P],[H|T]):-
  prefix(P,T).

suffix(L,L).
suffix([_|T],S):-
  suffix(T,S).
