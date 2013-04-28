% trzeba dodac te rozne czlowiek(anglik), zwierze(pies) itd...

po_lewej(1,2).
po_lewej(2,3).
po_lewej(3,4).
po_lewej(4,5).
po_prawej(5,4).
po_prawej(4,3).
po_prawej(3,2).
po_prawej(2,1).

sasiad(X,Y):-
  dzialka(X, DX),
  dzialka(Y, DY),
  po_lewej(DX, DY).

sasiad(X,Y):-
  dzialka(X, DX),
  dzialka(Y, DY),
  po_prawej(DX, DY).

% 2
mieszka(anglik, czerwony).

% 3
ma_zwierze(hiszpan, pies).

% 4
pije(X, kawa):-
  mieszka(X, zielony).

% 5
pije(ukrainiec, herbata).

% 6 ???
mieszka(X, zielony):-
  sasiad(X, Y),
  mieszka(Y, bialy).

% 7
pali(X, winstony):-
  ma_zwierze(X, waz).

% 8
pali(X, koole):-
  mieszka(X, zolty).

% 9
pije(X, mleko):-
  dzialka(X, 3).

% 10
dzialka(norweg, 1).

% 11
pali(X, chesterfieldy):-
  sasiad(X, Y),
  ma_zwierze(Y, lis).

% 12
pali(X, koole):-
  sasiad(X, Y),
  ma_zwierze(Y, kon).

% 13
pali(X, luckystrike):-
  pije(X, sok).

% 14
pali(japonczyk,kenty).

% 15
mieszka(X, niebieski):-
  sasiad(X,norweg).
dom
% (pozycja, mieszkaniec, kolor, )
