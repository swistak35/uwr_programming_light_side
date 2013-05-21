select_min([Head|Tail], Min, Rest):-
  select_min(Tail, Min, ReversedRest, [], Head),
  reverse(ReversedRest, Rest).

select_min([], Min, Rest, Rest, Min).
select_min([H|T], Min, Rest, AccRest, CurrentMin):-
  H >= CurrentMin, !,
  select_min(T, Min, Rest, [H|AccRest], CurrentMin).
select_min([H|T], Min, Rest, AccRest, CurrentMin):-
  H < CurrentMin,
  select_min(T, Min, Rest, [CurrentMin|AccRest], H).

sel_sort([],[]):-!.
sel_sort(List, [Min|OtherRes]):-
  select_min(List, Min, Rest),
  sel_sort(Rest, OtherRes).
