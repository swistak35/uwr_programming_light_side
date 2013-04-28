% ?- append(X,X,Y).
% X = Y, Y = [] ;
% X = [_G15],
% Y = [_G15, _G15] ;
% X = [_G15, _G21],
% Y = [_G15, _G21, _G15, _G21] .
%
% ?- select(X,[a,b,c,d],[a,c,d]).
% X = b ;
% false.
%
% ?- append([a,b,c],X,[a,b,c,d,e]).
% X = [d, e].

even([]).
even([_|T]):-
  odd(T).
odd([_|T]):-
  even(T).

palindrom(X) :- X = Y, reverse(X,Y).

singleton([_|[]]).

head(H,[H|_]).

last([H],H).
last([_|T],H):-
  last(T,H).

tail(T,[_|T]).

init([_],[]).
init([H|X],[H|T]):-
  init(X,T).

prefix([H],[H|_]).
prefix([H|P],[H|T]):-
  prefix(P,T).

suffix(L,L).
suffix([_|T],S):-
  suffix(T,S).

sublist(_,[]).
sublist([H|T],[H|S]):-
  sublist(T,S).
sublist([_|T],S):-
  sublist(T,S).

perm([],[]).
perm(L,[PH|PT]):-
  select(PH, L, LT),
  perm(LT, PT).
