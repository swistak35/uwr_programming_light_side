difference_append(List1-Hole1,List2-Hole2,List1-Hole2):-
  Hole1 = List2.
put(Element, Stack, Result):-
  difference_append(Stack, [Element|Hole2]-Hole2, Result).
get([Element|Rest]-Hole, Element, Rest-Hole).
empty([X]-X).

addall(Element, Goal, Stack, Rest):-
  findall(Element, Goal, List),
  putall(List, Stack, Rest).

putall([],Rest,Rest).
putall([Head|Tail],Stack,Rest):-
  put(Head,Stack,NewStack),
  putall(Tail,NewStack,Rest).

male(jan).
male(jozek).
female(anna).