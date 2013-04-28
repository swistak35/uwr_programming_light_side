filter([],[]).
filter([H|T],[H|S]):-
  H >= 0, !,
  filter(T,S).
filter([H|T],S):-
  H < 0,
  filter(T,S).

count(_, [], 0).
count(X, [X|L], N):-
  count(X, L, C), !, %jesli tego tu by nie bylo, to prolog albo by zliczal, albo by nie zliczal, tak zeby mu wynik pasowal
  N is C+1.
count(X, [_|L], N):-
  count(X, L, N).

exp(_, 0, 1):-
  !.
exp(Base, Exp, Res):-
  Exp > 0,
  DecreasedExp is Exp-1,
  exp(Base, DecreasedExp, DecreasedRes), !,
  Res is DecreasedRes * Base.

% Dlaczego? Bo moge
exp2(Base,Exp,Res):- 
     Res is Base^Exp.


