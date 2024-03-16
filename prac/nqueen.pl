% 체스판 위에 퀸을 배치하는 규칙 정의
% 퀸이 다른 퀸과 같은 행 또는 열에 있으면 안 됨
% 퀸이 다른 퀸의 대각선에 있으면 안 됨
% N행 1열부터 N행 N열까지 퀸을 배치하는 규칙 정의

n_queen(N, Queens) :- 
    range(1, N, Rows), 
    permutation(Rows, Queens),
    safe(Queens).

% range(P, Q, L)은 P에서 Q까지의 숫자들을 리스트 L로 생성
range(P, P, [P]).
range(P, Q, [P|L]) :- 
    P < Q, 
    P1 is P + 1, 
    range(P1, Q, L).

% permutation(L1, L2)는 리스트 L1의 순열이 L2인 것을 나타냄
permutation([], []).
permutation(List, [Element|Perm]) :- 
    select(Element, List, Rest), 
    permutation(Rest, Perm).

% safe(Queens)는 Queens의 퀸들이 서로 공격할 수 없는 위치에 있는지 확인
safe([]).
safe([Queen|Others]) :- 
    safe(Others),
    no_attack(Queen, Others, 1).

% no_attack(Queen, Others, N)는 Queen이 Others와 N열에 있는 퀸들과 공격하지 않는지 확인
no_attack(_, [], _).
no_attack(Y, [Y1|Ylist], Xdist) :- 
    Y1 - Y =\= Xdist, 
    Y - Y1 =\= Xdist, 
    Dist1 is Xdist + 1, 
    no_attack(Y, Ylist, Dist1).

