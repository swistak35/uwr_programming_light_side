rev(X,Y):-
  rev(X,[],Y).
rev([],A,A).
rev([H|T],A,Y):-
  !,
  rev(T,[H|A],Y).
% Proste wytlumaczenie: Bez wykrzyknika, wypluwal poprawna odpowiedz, ale potem sie zapetlal, probujac zunifikowac coraz to wieksza liste z Y, ktora ma skonczona dlugosc przeciez.
% Psuje sie dla rev(X,Y)...