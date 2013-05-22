% ?- append(X,X,Y).
% X = Y, Y = [] ;
% X = [_G15],
% Y = [_G15, _G15] ;
% X = [_G15, _G21],
% Y = [_G15, _G21, _G15, _G21] .
%
% ?- select(X,[a,b,c,d],[a,c,d]).
% X = b ;
% false.
%
% ?- append([a,b,c],X,[a,b,c,d,e]).
% X = [d, e].
