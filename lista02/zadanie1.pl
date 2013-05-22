append2([], X, X).
append2([H|T], X, [H|Y]) :-
	append2(T, X, Y).

select2(H, [H|T], T).
select2(X, [H|T], [H|S]) :-
	select2(X, T, S).
