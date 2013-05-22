insert([], Elem, [Elem]).
insert([Head|Tail], Elem, [Elem,Head|Tail]):-
  Elem =< Head,
  !.
insert([Head|Tail], Elem, [Head|Rest]):-
  Elem > Head,
  insert(Tail, Elem, Rest).

ins_sort([],[]).
ins_sort([Head|Tail], SortedList2):-
  ins_sort(Tail, SortedList),
  insert(SortedList, Head, SortedList2).