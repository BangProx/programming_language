% 정의
near(a,b). near(a,c).
near(b,c). near(b,d).
near(c,e).
near(d,f).

% 규칙
path(X,X).
path(X,Y) :- near(X,Z), path(Z,Y).

fnd() :- findall(X, path(b,X),L), write(L).
