%% expression(AST) --> simple_expression(AST).
%% expression(star(LeftAST, RightAST)) --> expression(LeftAST), [x], simple_expression(RightAST).
%% simple_expression(a) --> [a].
%% simple_expression(b) --> [b].
%% simple_expression(AST) --> [lewy], expression(AST), [prawy].


%% Chodzi raczej o to, że podczas sprawdzania czy dane słowo należy do gramatyki nie było mowy o nawracaniu, np.:
%% t-->"".
%% t-->"a",t,"b".
%% Ta gramatyka generująca słowa a^n b^n zapytana t([97,98],[]), czyli o to czy słowo "ab" do niej należy wpierw odpowie tak, ale będzie czekała dalej na polecenie, po czym gdy wciśniemy średnik odpowie false, bo więcej ab się w "ab" upchać nie da. Tutaj to zbytnio różnicy nie robi, ale te gramatyki z zad 1 i 2 napisane w zły sposób mogą przy zapytaniu o to, czy słowo należy do generowanego przez nie języka się zapętlić, zaś nam zależy na tym by zapytanie albo nam odpowiedziało true albo false, nie jedno i drugie, ani nie zapętlenie.

%% expression(AST, X, Y):-
%%   simple_expression(AST, X, Y).
%% expression(star(LeftAST, RightAST), X, Y):-
%%   expression(LeftAST, X, Z),
%%   Z=[x|T],
%%   simple_expression(RightAST, T, Y).
%% simple_expression(a, [a|X], X):-
%%   true.
%% simple_expression(b, [b|X], X):-
%%   true.
%% simple_expression(AST, [lewy|X], Y):-
%%   expression(AST, X, Z),
%%   Z=[prawy|Y].

expression(AST, Num, X, Y):-
  simple_expression(AST, Num, X, Y),
  !.
expression(star(LeftAST, RightAST), Num, X, Y):-
  length(X, Len),
  Num =< Len,
  Xum is Num +1,
  expression(LeftAST, Xum, X, Z),
  Z=[x|T],
  simple_expression(RightAST, Xum, T, Y).

simple_expression(a, Num, [a|X], X):- !.
simple_expression(b, Num, [b|X], X):- !.
simple_expression(AST, Num, [lewy|X], Y):-
  expression(AST, Num, X, Z),
  Z=[prawy|Y].

