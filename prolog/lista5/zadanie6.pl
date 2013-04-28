nat(1).
nat(X):-
  nat(Y),
  X is Y + 1.

% Rozwiazanie 1 - nie generujace duplikatow
gen(Poczatek, _, Poczatek).
gen(Poczatek, Koniec, X):-
  NowyPoczatek is Poczatek+1,
  NowyPoczatek =< Koniec,
  gen(NowyPoczatek, Koniec, X).

iteruj(xplus, N, X, N):-
  Poczatek is -N + 1,
  Koniec is N,
  gen(Poczatek, Koniec, X).
iteruj(yminus, N, N, Y):-
  Poczatek is -N,
  Koniec is N - 1,
  gen(Poczatek, Koniec, Y).
iteruj(xminus, N, X, Y):-
  Y is -N,
  Poczatek is -N,
  Koniec is N - 1,
  gen(Poczatek, Koniec, X).
iteruj(yplus, N, X, Y):-
  X is -N,
  Poczatek is -N + 1,
  Koniec is N,
  gen(Poczatek, Koniec, Y). 

sum(X, Y, Suma):-
  integer(X),
  integer(Y),
  !,
  Suma is X + Y.
sum(X, Y, Suma):-
  integer(X),
  integer(Suma),
  !,
  Y is Suma - X.
sum(X, Y, Suma):-
  integer(Y),
  integer(Suma),
  !,
  X is Suma - Y.

sum(X, Y, Suma):-
  nat(N),
  select(Tryb, [xplus, yminus, xminus, yplus], _),
  iteruj(Tryb, N, X, Y),
  Suma is X + Y.


zas(Zasieg, Zasieg).
zas(Zasieg, Y):-
  Y is -Zasieg.
zas(Zasieg, X):-
  Zasieg2 is Zasieg - 1,
  Zasieg2 >= 0,
  zas(Zasieg2, X).

sum2(0, 0, 0).
sum2(X, Y, Suma):-
  nat(N),
  select(Tryb, [1, -1], _),
  select(Z1, [X, Y], [Z2]),
  Z1 is N * Tryb,
  zas(N, Z2),
  Suma is X + Y.