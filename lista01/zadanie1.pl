ryba(_):-fail.
ptak(_):-fail.
dzdzownica(_):-fail.
kot(my_cat).

przyjaciel(me, my_cat).

lubi(X,Y):-przyjaciel(X,Y).
lubi(X,Y):-przyjaciel(Y,X).
lubi(X,Y):-kot(X),ryba(Y).
lubi(X,Y):-ptak(X),dzdzownica(Y).

je(my_cat,X):-lubi(my_cat,X).

% ?- je(my_cat, X).
% X = me ;
% false.

