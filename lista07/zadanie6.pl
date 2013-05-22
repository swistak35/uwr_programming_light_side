pX-->"".
pX-->"a",pX,"b".

% ?- expand_term((word-->"a",word,"b"),X).
% X = (word([97|_G15], _G12):-word(_G15, _G21), _G21=[98|_G12]).
word(X,X).
word([a|T], X):- word(T, Y), Y = [b|X].

pX2-->"".
pX2-->"a",pX2,"b",!.
% Nie może być. Mamy odcięcie, więc prolog zadowolony z siebie skończy generowanie na "ab".

pX3(0) --> "".
pX3(X) --> "a", pX3(Y), { X is Y + 1 }, "b", !.
% phrase(pX3(X), "aabb").