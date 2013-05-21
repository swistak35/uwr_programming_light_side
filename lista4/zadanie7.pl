is_list2([]).
is_list2([_|T]):-
  is_list2(T).

rev(X,Y):-
  rev(X,[],Y).
rev([],A,A).
rev([H|T],A,Y):-
  is_list2(H), !,
  rev(H, R),
  rev(T,[R|A],Y).
rev([H|T],A,Y):-
  rev(T,[H|A],Y).