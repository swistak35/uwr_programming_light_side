mily(X):- 
  odwiedza_zoo(X),czlowiek(X). 
styka_sie(X,Y) :- 
  zwierze(X),
  mieszka_zoo(X),
  czlowiek(Y),
  odwiedza_zoo(Y).
styka_sie(X,Y):-
  zwierze(Y),
  mieszka_zoo(Y),
  czlowiek(X),
  odwiedza_zoo(X). 
szczesliwe(X):-
  zwierze(X),
  styka_sie(X,Y),
  mily(Y). 
niesmok(X):-
  szczesliwe(X),
  mieszka_zoo(X).

% Pierwszy brakujacy: Smok to zwierze
zwierze(X):-
  smok(X).

% Drugi brakujacy: Istnieje człowiek, ktory odwiedza zoo.
czlowiek(adam).
odwiedza_zoo(adam).
smok(strachota).

