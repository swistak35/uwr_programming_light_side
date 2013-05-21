%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          Rafał Łasocha (258338)          %%
%%            Zagadka "A, B, C"             %%
%% http://archiwum.wiz.pl/2001/01124800.asp %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

abc(File, Result):-
  open(File, read, Str),
  read(Str, M),
  read(Str, N),
  read(Str, MaxLetter),
  read(Str, InitList),
  close(Str),
  rozwiaz(N, M, MaxLetter, InitList, Result).

%% Główny predykat rozwiązujący
rozwiaz(N, M, MaxLetter, InitList, TabelaKol):-
  lista_liter(MaxLetter, Litery),
  pusta_tabela(N, M, Tabela),
  wypelniona_tabela(InitList, Tabela),
  numlist(1, M, ListaM),
  tabela_kolumnami(Tabela, N, ListaM, TabelaKol),
  wypelnij_wiersze(Tabela, TabelaKol, ListaM, Litery, M, N, Tabela, TabelaKol).

%% Generuje listę liter od 'A' do OstatniaLitera.
%% lista_liter(+OstatniaLitera, -ListaLiter).
lista_liter(OstatniaLitera, ListaLiter):-
  char_code(OstatniaLitera, OstatniaLiteraKod),
  numlist(65, OstatniaLiteraKod, ListaKodow),
  maplist(char_code, ListaLiter, ListaKodow).

%% Inicjuje pustą tabelę, pełną nieukonkretnionych zmiennych
%%    o M kolumnach i N wierszach
%% pusta_tabela(+N, +M, -Tabela)
pusta_tabela(N, M, Tabela):-
  pusta_tabela(N, M, Tabela, []).
pusta_tabela(0, _, Tabela, Tabela):-
  !.
pusta_tabela(N, M, Tabela, Acc):-
  NextN is N - 1,
  length(H, M),
  pusta_tabela(NextN, M, Tabela, [H|Acc]).

%% Wypelnia tabele danymi ukladem poczatkowym liter z zadania
%% wypelniona_tabela(+InitList, -Tabela)
wypelniona_tabela([], _Tabela).
wypelniona_tabela([E|InitList], Tabela):-
  E = (Kolumna, Wiersz, Litera),
  nth1(Wiersz, Tabela, Lista),
  nth1(Kolumna, Lista, Litera),
  wypelniona_tabela(InitList, Tabela).

%% Generuje tabelę kolumn, na podstawie tabeli wierszy (obraca tabelę o 90 stopni)
%% ListaM = [1 .. M]
%% tabela_kolumnami(+Tabela, +IloscWierszy, +ListaM, -TabelaKolumn)
tabela_kolumnami(_, _, [], []).
tabela_kolumnami(Tabela, N, [X|T], [Kol|TabelaKol]):-
  pobierz_kolumne(X, Tabela, Kol),
  tabela_kolumnami(Tabela, N, T, TabelaKol).

%% Pobiera kolumnę o indeksie Numer z tabeli wierszy
%% pobierz_kolumne(+Numer, +Tabela, -Kolumna)
pobierz_kolumne(_Numer, [], []).
pobierz_kolumne(Numer, [Wiersz|Tabela], [Wartosc|Lista]):-
  nth1(Numer, Wiersz, Wartosc),
  pobierz_kolumne(Numer, Tabela, Lista).

%% %% Wypełnianie wierszy metodą siłową:
%% %%
%% Tabela i TabelaKol przekazujemy dwa razy.
%% Względem pierwszych dwóch prowadzimy indukcję, dwa ostatnie przydadzą nam się
%%    gdy będziemy sprawdzać czy rząd jest wypełniony jedną literą.
%% wypelnij_wiersze(+Tabela, +TabelaKol, +ListaM, +Litery, +M, +N, +Tabela, +TabelaKol)

%% Przypadek, jeśli ilość N = M (listy się opróżniły jednocześnie)
wypelnij_wiersze([], [], _, _, _, _, Tabela, TabelaKol):-
  !,
  czy_jest_rzad_jednoliterowy(Tabela, TabelaKol).

%% Przypadek, jeśli ilość N < M (lista wierszy opróżniła się szybciej niż lista kolumn)
wypelnij_wiersze([], PozostaleKolumny, _, _, _, N, Tabela, TabelaKol):-
  !,
  czy_jest_rzad_jednoliterowy(Tabela, TabelaKol),
  weryfikuj(PozostaleKolumny, N).

%% Przypadek, jeśli ilość N > M (lista kolumn opróżniła się szybciej niż lista wierszy)
wypelnij_wiersze(PozostaleWiersze, [], _, _, M, _, Tabela, TabelaKol):-
  !,
  czy_jest_rzad_jednoliterowy(Tabela, TabelaKol),
  weryfikuj(PozostaleWiersze, M).

%% Zwykły przypadek, jeśli ciągle są zarówno wiersze jak i kolumny do wygenerowania.
wypelnij_wiersze([Wiersz|PozostaleWiersze], [Kolumna|PozostaleKolumny], ListaM, Litery, M, N, Tabela, TabelaKol):-
  wypelnij_liste(Wiersz, Litery),
  sprawdz_liste(Wiersz, M),
  wypelnij_liste(Kolumna, Litery),
  sprawdz_liste(Kolumna, N),
  wypelnij_wiersze(PozostaleWiersze, PozostaleKolumny, ListaM, Litery, M, N, Tabela, TabelaKol).

%% Predykat do weryfikacji tego, co zostało
%% weryfikuj(+ListaRzedow, +DlugoscRzedu)
weryfikuj([], _).
weryfikuj([Rzad|Pozostalo], Ilosc):-
  sprawdz_liste(Rzad, Ilosc),
  weryfikuj(Pozostalo, Ilosc).

%% Wypelnianie listy algorytmem siłowym
%% wypelnij_liste(+Lista, +Litery)
wypelnij_liste([], _):-!.
wypelnij_liste([E|Wiersz], Litery):-
  var(E),
  !,
  select(E, Litery, _),
  wypelnij_liste(Wiersz, Litery).
wypelnij_liste([_E|Wiersz], Litery):-
  wypelnij_liste(Wiersz, Litery).

%% Sprawdzenie, czy lista jest poprawną listą
%% sprawdz_liste(Lista, DlugoscListy)
sprawdz_liste(Lista, M):-
  pobierz_rozne(Lista, Rozne),
  length(Rozne, IloscRoznych),
  0 is M mod IloscRoznych,
  IloscKazdego is M / IloscRoznych,
  forall(member(X, Rozne), count(X, Lista, IloscKazdego)).

%% Zwykły predykat zliczający ilość wystąpienia elementu w liście
%% count(+X, +Lista, -N)
count(_, [], 0).
count(X, [X|L], N):-
  count(X, L, C),
  !,
  N is C+1.
count(X, [_|L], N):-
  count(X, L, N).

%% Predykat zwracający tylko te elementy listy, które są jeszcze nieukonkretnione
%% ukonkretnione_elementy_listy(+Lista, -Wynik)
ukonkretnione_elementy_listy([], []).
ukonkretnione_elementy_listy([H|List], Wyn):- var(H), !, ukonkretnione_elementy_listy(List, Wyn).
ukonkretnione_elementy_listy([H|List], [H|Wyn]):- ukonkretnione_elementy_listy(List, Wyn).

%% Pobierz ukonkretnione elementy z listy, bez duplikatów
%% Używam tutaj sort, który zwraca listę posortowaną, bez duplikatów,
%%    ponieważ jest on bardzo efektywny.
%% pobierz_rozne(+Lista, -Rozne)
pobierz_rozne([], []).
pobierz_rozne(Lista, Wynik):-
  sort(Lista, Posortowane),
  ukonkretnione_elementy_listy(Posortowane, Wynik).

%% Predykat sprawdzający, czy w liście każde dwa elementy są równe
%% all_the_same(+Lista)
all_the_same([E|List]):-
  all_the_same(List, E).
all_the_same([], _E).
all_the_same([E|Tail], E):-
  all_the_same(Tail, E).

%% Predykat poszukującego rzędu (wiersza lub kolumny) "jednoliterowego"
%% Odcinamy, bo gdybyśmy nie odcięli, to w przypadku, gdy jest jednoliterowa kolumna
%%    i jednoliterowy wiersz, to po nawrocie prolog zwróci nam dwa wyniki.
%% Musimy mu powiedzieć, że jesteśmy kompletnie usatysfakcjonowani z jednego jednoliterowego rzędu.
%% czy_jest_rzad_jednoliterowy(Tabela)
czy_jest_rzad_jednoliterowy(Tabela, _):-
  rzad_jednoliterowy_w_tabeli(Tabela),
  !.
czy_jest_rzad_jednoliterowy(_, TabelaKol):-
  rzad_jednoliterowy_w_tabeli(TabelaKol).

rzad_jednoliterowy_w_tabeli([Rzad|_Reszta]):-
  all_the_same(Rzad),
  !.
rzad_jednoliterowy_w_tabeli([_Rzad|Reszta]):-
  rzad_jednoliterowy_w_tabeli(Reszta).
