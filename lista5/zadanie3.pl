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

mergesort([],[]):-
  !.
mergesort([X],[X]):-
  !.
mergesort(List,Sorted):-
  halve(List, Left, Right),
  mergesort(Left, SortedLeft),
  mergesort(Right, SortedRight),
  merge(SortedLeft, SortedRight, Sorted).