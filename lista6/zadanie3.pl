insert(leaf, Value, node(leaf, Value, leaf)).
insert(node(Left, NValue, Right), Value, node(Left, NValue, InsertedRight)):-
  Value >= NValue,
  insert(Right, Value, InsertedRight).
insert(node(Left, NValue, Right), Value, node(InsertedLeft, NValue, Right)):-
  Value < NValue,
  insert(Left, Value, InsertedLeft).

find(Element, node(_, Value, _)):-
  Element == Value,
  !.
find(Element, node(Left, _, _)):-
  find(Element, Left),
  !.
find(Element, node(_, _, Right)):-
  find(Element, Right).

max(X1, X2, X1):- X1 >= X2, !.
max(X1, X2, X2):- X2 >= X1.

max(X1, X2, X3, X1):- X1 >= X2, X1 >= X3, !.
max(X1, X2, X3, X2):- X2 >= X1, X2 >= X3, !.
max(X1, X2, X3, X3):- X3 >= X1, X3 >= X2.

findMax(node(_, Value, leaf), Value):- !.
findMax(node(_, _, Right), Max):-
  findMax(Right, Max).
findMin(node(leaf, Value, _), Value):- !.
findMin(node(Left, _, _), Min):-
  findMin(Left, Min).

empty(leaf).

delete(_,leaf,leaf):-!.
delete(Value,node(leaf,Value,leaf),leaf):- !.
delete(Value,node(Left,Value,leaf),Left):- !.
delete(Value,node(leaf,Value,Right),Right):- !.
delete(Value,node(Left,Value,Right),node(Left,RightMin,RightWithoutMin)):-
  findMin(Right, RightMin),
  delete(RightMin,Right,RightWithoutMin),
  !.

delete(Element,node(Left,Value,Right),node(ResLeft,Value,ResRight)):-
  delete(Element,Left,ResLeft),
  delete(Element,Right,ResRight).