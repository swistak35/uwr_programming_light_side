halve(List, Left, Right):-
  halve(List, List, Left, Right).

halve(Right, [], [], Right):-
  !.
halve(Right, [_], [], Right):-
  !.
halve([Head|Tail], [_,_|Bound], [Head|Left], Right):-
  halve(Tail, Bound, Left, Right).