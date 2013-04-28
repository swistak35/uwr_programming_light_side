polaczenie(wroclaw,warszawa).
polaczenie(wroclaw,krakow).
polaczenie(wroclaw,szczecin).
polaczenie(szczecin,lublin).
polaczenie(szczecin,gniezno).
polaczenie(warszawa,katowice).
polaczenie(gniezno,gliwice).
polaczenie(lublin,gliwice).
polaczenie(warszawa,wroclaw).

% 1
% ?- polaczenie(wroclaw,lublin).
% false.

% 2
% ?- polaczenie(wroclaw,X).
% X = warszawa ;
% X = krakow ;
% X = szczecin.
% ?- polaczenie(X,wroclaw).
% false.

% 3
% ?- polaczenie(X,Y),polaczenie(Y,gliwice).
% X = szczecin,
% Y = lublin ;
% X = szczecin,
% Y = gniezno ;
% false.

% 4
% ?- polaczenie(X,gliwice).
% X = gniezno ;
% X = lublin.
% ?- polaczenie(X,Y),polaczenie(Y,gliwice).
% X = szczecin,
% Y = lublin ;
% X = szczecin,
% Y = gniezno ;
% false.
% ?- polaczenie(X,Y),polaczenie(Y,Z),polaczenie(Z,gliwice).
% X = wroclaw,
% Y = szczecin,
% Z = lublin ;
% X = wroclaw,
% Y = szczecin,
% Z = gniezno ;
% false.

% Pozostałe.
% Jeśli dodamy do tego połączenie np. z Warszawy do Wrocławia, to gdy zapytamy
% gdzie możemy się dostać z Wrocławia, to na liście będzie Wrocław oraz wszystko się zapętla.

connection(X,Y):-
  polaczenie(X,Y).
connection(X,Y):-
  polaczenie(X,Z),
  connection(Z,Y).
