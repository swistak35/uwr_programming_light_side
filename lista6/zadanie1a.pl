
put(Element, Stack, [Element|Stack]).
get([Element|Rest], Element, Rest).
empty([]).
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