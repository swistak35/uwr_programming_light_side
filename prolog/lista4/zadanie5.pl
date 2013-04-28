% insert(Tree, Value, Result).

insert(leaf, Value, node(leaf, Value, leaf)).
insert(node(Left, NValue, Right), Value, node(Left, NValue, InsertedRight)):-
  Value >= NValue,
  insert(Right, Value, InsertedRight).
insert(node(Left, NValue, Right), Value, node(InsertedLeft, NValue, Right)):-
  Value < NValue,
  insert(Left, Value, InsertedLeft).

treesort(List, SortedList):-
  treesort(List, SortedTree, leaf),
  flatten(SortedTree, SortedList).
treesort([], SortedTree, SortedTree).
treesort([H|T], SortedTree, Acc):-
  insert(Acc, H, NextAcc),
  treesort(T, SortedTree, NextAcc).
  