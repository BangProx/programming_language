% 체스판 위에 퀸을 배치하는 규칙 정의
% 퀸이 다른 퀸과 같은 행 또는 열에 있으면 안 됨
% 퀸이 다른 퀸의 대각선에 있으면 안 됨
% N행 1열부터 N행 N열까지 퀸을 배치하는 규칙 정의

n_queen(N, Queens) :- 
    range(1, N, Rows), % 1부터 N까지의 숫자 리스트를 생성해서 Rows에 저장합니다.
    permutation(Rows, Queens), % Rows의 순열을 생성하여 Queens에 저장합니다.
    safe(Queens). % Queens의 퀸들이 서로 공격할 수 없는 위치에 있는지 확인합니다.

% range(Start, End, List)는 Start에서 End까지의 숫자들을 리스트 List로 생성하는 규칙
range(Start, Start, [Start]).
range(Start, End, [Start|List]) :- 
    Start < End, 
    Start1 is Start + 1, 
    range(Start1, End, List).

% permutation은 가능한 모든 퀸의 배치를 생성하기 위해 사용됩니다.
permutation([], []).
permutation(List, [X|Perm]) :- 
    select(X, List, Rest), % List에서 X 선택하여 Rest에 저장합니다.
    permutation(Rest, Perm).

% safe(Queens)는 Queens의 퀸들이 서로 공격할 수 없는 위치에 있는지 확인합니다.
safe([]).   %빈 리스트이면 당연히 퀸들이 서로 공격할수 없습니다.
safe([Queen|Otherqueens]) :- 
    safe(Otherqueens), % Otherqueens에 있는 퀸들이 서로 공격할 수 없는지 확인합니다.
    check(Queen, Otherqueens, 1).%첫번째 열부터 검사 시작.

% check(Queen, Otherqueens, N)은 주어진 위치에 퀸을 배치할때 배치한 위치가 다른 퀸과 공격가능한지 파악합니다.
% Queen은 현재 검사중인 퀸의 행 번호입니다. Otherqueens는 이전에 배치된 퀸들의 위치를 나타내는 리스트입니다.
check(_, [], _). %이전에 배치된 퀸이 없을때는 검사할 필요가 없습니다.
check(Y, [Y1|Ylist], Xdist) :-  %Y는 현재 검사중인 퀸의 행번호 [Y1|Ylist]는 이전 배치된 퀸들의 행 번호를 저장하고있습니다. 
                                % Xdist는 현재 검사중인 퀸과 이전 퀸들의 열 번호 차이를 의미합니다.
    Y1 - Y =\= Xdist, % 오른쪽 대각선에 겹치는 퀸을 확인합니다.
    Y - Y1 =\= Xdist, % 왼쪽 대각선에 겹치는 퀸을 확인합니다.
    Dist1 is Xdist + 1, %다음 열 번호 차이를 계산합니다.
    check(Y, Ylist, Dist1). %이전 퀸과 충돌하는지 재귀적으로 검사.
