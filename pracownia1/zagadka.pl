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

wybierz_i_wypelnij_rzad(N, M, Tabela, Litery):-
  select(Typ, [[kolumna, M], [wiersz, N]], _),
  wybierz_i_wypelnij_rzad(Typ, Tabela, Litery).

wybierz_i_wypelnij_rzad([kolumna, M], Tabela, Litery):-
  numlist(1, M, ListaLiczb),
  select(Liczba, ListaLiczb, _),
  pobierz_kolumne(Liczba, Tabela, Lista),
  jaka_literka_w_liscie(Lista, Wynik, []), % niech zwraca 'dowolna' lub numer litery, lub fail, jesli jest wiecej literek w tym rzedzie
  wypelnij_rzad(Wynik, Lista, Litery).

wybierz_i_wypelnij_rzad([wiersz, N], Tabela, Litery):-
  numlist(1, N, ListaLiczb),
  select(Liczba, ListaLiczb, _),
  pobierz_wiersz(Liczba, Tabela, Lista),
  jaka_literka_w_liscie(Lista, Wynik, []), % niech zwraca 'dowolna' lub numer litery, lub fail, jesli sa dwie
  wypelnij_rzad(Wynik, Lista, Litery).

wypelnij_rzad(dowolna, Lista, Litery):-
  select(Litera, Litery, _),
  wypelnij_liste(Lista, Litera).
wypelnij_rzad(Litera, Lista, _Litery):-
  wypelnij_liste(Lista, Litera).

pobierz_kolumne(Numer, Tabela, Lista):-
  pobierz_kolumne(Numer, Tabela, Lista, []).
pobierz_kolumne(_Numer, [], Lista, Lista):-
  !.
pobierz_kolumne(Numer, [Wiersz|Tabela], Lista, Acc):-
  nth1(Numer, Wiersz, Wartosc),
  pobierz_kolumne(Numer, Tabela, Lista, [Wartosc|Acc]).

pobierz_wiersz(Numer, Tabela, Lista):-
  nth1(Numer, Tabela, Lista).

wypelnij_liste([], _X):-
  !.
wypelnij_liste([H|T], X):-
  var(H),
  !,
  H = X,
  wypelnij_liste(T, X).
wypelnij_liste([_H|T], X):-
  wypelnij_liste(T, X).

jaka_literka_w_liscie([], dowolna, []):-
  !.
jaka_literka_w_liscie([], Wynik, [Wynik]):-
  !.
jaka_literka_w_liscie([Element|Ogon], Wynik, Acc):-
  nonvar(Element),
  !,
  jaka_literka_w_liscie(Ogon, Wynik, [Element|Acc]).
jaka_literka_w_liscie([_Element|Ogon], Wynik, Acc):-
  jaka_literka_w_liscie(Ogon, Wynik, Acc).





%% wypelnij_wiersz(dowolna, Liczba, Tabela, TabelaZRzedem, Litery):-
%%   select(Litera, Litery, _),
%%   wypelnij_wiersz(Litera, Liczba, Tabela, TabelaZRzedem, Litery).
%% wypelnij_wiersz(Litera, 1, [H|Tabela], [X|Tabela], Litery):-
%%   wypelnij_liste(H, Litera, X).
%% wypelnij_wiersz(Litera, Liczba, [H|Tabela], [H|TabelaZRzedem], Litery):-
%%   NLiczba is Liczba - 1,
%%   wypelnij_wiersz(Litera, NLiczba, Tabela, TabelaZRzedem, Litery).

  
  



%% glowny predykat rozwiazujacy, MaxLetter, to numer litery!!!
rozwiaz(N, M, MaxLetter, InitList, Tabela):-
  lista_liter(MaxLetter, Litery),
  pusta_tabela(N, M, Tabela),
  wypelniona_tabela(InitList, Tabela),
  wybierz_i_wypelnij_rzad(N, M, Tabela, Litery).

%% rozwiaz(4, 4, 67, [[3,1,66], [4,1,65], [1,2,66], [4,2,67], [1,3,67], [2,4,65]], Wynik).


