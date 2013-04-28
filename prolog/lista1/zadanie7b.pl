% dom(czlowiek, nr_dzialki, kolor, zwierze, napoj, fajki)

po_lewej(1,2).
po_lewej(2,3).
po_lewej(3,4).
po_lewej(4,5).
po_prawej(5,4).
po_prawej(4,3).
po_prawej(3,2).
po_prawej(2,1).

% 2
dom(anglik, _, czerwony, _, _, _).

% 3
dom(hiszpan, _, _, pies, _, _).

% 4
dom(_, _, zielony, _, kawa, _).

% 5
dom(ukrainiec, _, _, _, herbata, _).

% 6
dom(_, DX, zielony, _, _, _):-
  dom(_, DY, bialy, _, _, _),
  po_lewej(DX, DY).
dom(_, DX, zielony, _, _, _):-
  dom(_, DY, bialy, _, _, _),
  po_prawej(DX, DY).

% 7
dom(_, _, _, waz, _, winstony).

% 8
dom(_, _, zolty, _, _, koole).

% 9
dom(_, 3, _, _, mleko, _).

% 10
dom(norweg, 1, _, _, _, _).

% 11
dom(_, DX, _, _, _, chesterfieldy):-
  dom(Y, DY, _, lis, _, _),
  po_lewej(DX, DY).
dom(_, DX, _, _, _, chesterfieldy):-
  dom(_, DY, _, lis, _, _),
  po_prawej(DX, DY).

% 12
dom(_, DX, _, kon, _, _):-
  dom(_, DX, _, _, _, koole),
  po_lewej(DX, DY).
dom(_, DX, _, kon, _, _):-
  dom(_, DX, _, _, _, koole),
  po_prawej(DX, DY).

% 13
dom(_, _, _, _, sok, lucky_strike).

% 14
dom(japonczyk, _, _, _, _, kenty).

% 15
dom(norweg, DX, _, _, _, _):-
  dom(_, DY, niebieski, _, _, _),
  po_lewej(DX,DY).
dom(norweg, DX, _, _, _, _):-
  dom(_, DY, niebieski, _, _, _),
  po_prawej(DX,DY).