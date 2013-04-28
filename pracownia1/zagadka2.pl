%% dopisać komentarze, które coś znaczą
%% zmienić nazwy predykatów z czasowników na "stany", np. pustaTabela, wypelnionaTabela etc.
%% przerobić na wersje z akumulatorami coś?
%% zdecydować się na camelCase lub underscore

%% pusta_tabela(+N, +M, -Tabela)
pusta_tabela(N, M, Tabela):-
  pusta_tabela(N, M, Tabela, []).
pusta_tabela(0, _M, Tabela, Tabela):-
  !.
pusta_tabela(N, M, Tabela, Acc):-
  NextN is N - 1,
  length(H, M),
  pusta_tabela(NextN, M, Tabela, [H|Acc]).

%% wypelniona_tabela(+InitList, -Tabela)
wypelniona_tabela([], _Tabela).
wypelniona_tabela([E|InitList], Tabela):-
  E = [Kolumna, Wiersz, Litera],
  nth1(Wiersz, Tabela, Lista),
  nth1(Kolumna, Lista, Litera),
  wypelniona_tabela(InitList, Tabela).

%% lista_liter(+MaxLetter, -ListaLiter).
lista_liter(MaxLetter, ListaLiter):-
  numlist(65, MaxLetter, ListaLiter).

pobierz_kolumne(Numer, Tabela, Lista):-
  pobierz_kolumne(Numer, Tabela, Lista, []).
pobierz_kolumne(_Numer, [], Lista, Lista):-
  !.
pobierz_kolumne(Numer, [Wiersz|Tabela], Lista, Acc):-
  nth1(Numer, Wiersz, Wartosc),
  pobierz_kolumne(Numer, Tabela, Lista, [Wartosc|Acc]).

wypelnij_liste([], _):-!.
wypelnij_liste([E|Wiersz], Litery):-
  var(E),
  !,
  select(E, Litery, _),
  wypelnij_liste(Wiersz, Litery).
wypelnij_liste([_E|Wiersz], Litery):-
  wypelnij_liste(Wiersz, Litery).

wypelnij_wiersze([], _Litery):-!.
wypelnij_wiersze([Lista|Tabela], Litery):-
  wypelnij_liste(Lista, Litery),
  sprawdz_liste(Lista),
  wypelnij_wiersze(Tabela, Litery).

sprawdz_kolumny(_Tabela, _Litery, 0):-!.
sprawdz_kolumny(Tabela, Litery, M):-
  pobierz_kolumne(M, Tabela, Lista),
  sprawdz_liste(Lista),
  NextM is M - 1,
  sprawdz_kolumny(Tabela, Litery, NextM).

count(_, [], 0).
count(X, [X|L], N):-
  count(X, L, C), !, %jesli tego tu by nie bylo, to prolog albo by zliczal, albo by nie zliczal, tak zeby mu wynik pasowal
  N is C+1.
count(X, [_|L], N):-
  count(X, L, N).

pobierz_rozne(Lista, Rozne):-
  pobierz_rozne(Lista, Rozne, []).
pobierz_rozne([], Rozne, Rozne):-!.
pobierz_rozne([H|Lista], Rozne, Acc):-
  member(H, Acc),
  !,
  pobierz_rozne(Lista, Rozne, Acc).
pobierz_rozne([H|Lista], Rozne, Acc):-
  pobierz_rozne(Lista, Rozne, [H|Acc]).


zlicz_elementy([], _Lista, _IloscKazdego).
zlicz_elementy([H|Rozne], Lista, IloscKazdego):-
  count(H, Lista, Ilosc),
  Ilosc is IloscKazdego,
  zlicz_elementy(Rozne, Lista, IloscKazdego).

% optymalizacja przez sprawdzenie dzielnika
sprawdz_liste(Lista):-
  pobierz_rozne(Lista, Rozne),
  length(Rozne, IloscRoznych),
  length(Lista, DlugoscListy),
  0 is DlugoscListy mod IloscRoznych,
  IloscKazdego is DlugoscListy / IloscRoznych,
  zlicz_elementy(Rozne, Lista, IloscKazdego).

czy_jest_rzad_jednoliterowy(Tabela):-
  czy_jest_kolumna_jednoliterowa(Tabela).
czy_jest_rzad_jednoliterowy(Tabela):-
  czy_jest_wiersz_jednoliterowy(Tabela).
  

%% glowny predykat rozwiazujacy, MaxLetter, to numer litery!!!
rozwiaz(N, M, MaxLetter, InitList, Tabela):-
  lista_liter(MaxLetter, Litery),
  pusta_tabela(N, M, Tabela),
  wypelniona_tabela(InitList, Tabela),
  wypelnij_wiersze(Tabela, Litery),
  sprawdz_kolumny(Tabela, Litery, M),
  czy_jest_rzad_jednoliterowy(Tabela).

%% rozwiaz(4, 4, 67, [[3,1,66], [4,1,65], [1,2,66], [4,2,67], [1,3,67], [2,4,65]], Wynik).


