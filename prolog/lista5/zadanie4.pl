halve(List-Hole, List-Right, Right-Hole):-
  find_mid(List, List-Hole, Right).

find_mid(Tail, H-H, Tail):-
  !.
find_mid(Tail, [_|H]-H, Tail):-
  !.
find_mid([_|Tail], [_,_|Bound]-H, Right):-
  find_mid(Tail, Bound-H, Right).

merge([], List, List):-
  !.
merge(List, [], List):-
  !.

merge([Head1|Tail1], [Head2|Tail2], [Head1|Merged]):-
  Head1 =< Head2,
  !,
  merge(Tail1, [Head2|Tail2], Merged).
merge([Head1|Tail1], [Head2|Tail2], [Head2|Merged]):-
  merge([Head1|Tail1], Tail2, Merged).

mergesort(T-T,[]):-
  !.
mergesort([X|T]-T,[X]):-
  !.
mergesort(List,Sorted):-
  halve(List, Left, Right),
  mergesort(Left, SortedLeft),
  mergesort(Right, SortedRight),
  merge(SortedLeft, SortedRight, Sorted).