sibling(X,Y):-
  parent(P,X),
  parent(P,Y).

sister(S,X):-
  sibling(S,X),
  female(S).

grandson(W,D):-
  parent(D,P),
  parent(P,W),
  male(W).

cousin(X,Y):-
  parent(P1,X),
  sibling(P1,P2),
  parent(P2,Y),
  male(X).

descendant(X,Y):-
  parent(Y,X).

descendant(X,Y):-
  parent(Y,Z),
  descendant(X,Z).

is_father(F):-
  parent(F,_).

is_mother(M):-
  parent(M,_).

male(adam).
male(john).
male(mark).
male(david).
male(joshua).

female(helen).
female(eve).
female(anna).
female(ivonne).

parent(adam, helen).
parent(adam, ivonne).
parent(adam, anna).
parent(eve, helen).
parent(eve, ivonne).
parent(eve, anna).
parent(john, joshua).
parent(helen, joshua).
parent(ivonne, david).
parent(mark, david).

% 1.
% ?- descendant(john,mark).
% false.

% 2.
% ?- descendant(X,adam).
% X = helen ;
% X = ivonne ;
% X = anna ;
% X = joshua ;
% X = david ;
% false.

% 3.
% ?- sister(X,ivonne).
% X = helen ;
% X = ivonne ;
% X = anna ;
% X = helen ;
% X = ivonne ;
% X = anna ;
% false.

% 4.
% ?- cousin(X,Y).
% X = Y, Y = joshua ;
% X = joshua,
% Y = david ;
% X = Y, Y = joshua ;
% X = joshua,
% Y = david ;
% X = david,
% Y = joshua ;
% X = Y, Y = david ;
% X = david,
% Y = joshua ;
% X = Y, Y = david ;
% false.


