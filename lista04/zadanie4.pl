mirror(leaf, leaf).
mirror(node(Left, Value, Right), node(MirrorRight, Value, MirrorLeft)):-
  mirror(Left, MirrorLeft),
  mirror(Right, MirrorRight).

flatten(leaf, []). 
flatten(node(Left, Value, Right), List):-
  flatten(Left, ListLeft),
  flatten(Right, ListRight),
  append(ListLeft, [Value|ListRight], List).

