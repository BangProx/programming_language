% 주어진 퀸들이 서로 공격할 수 없는지 확인하는 규칙
is_safe(_, []).
is_safe(X/Y, [X1/Y1 | Rest]) :-
    Y =\= Y1,                   % 같은 열에 놓여있지 않은지 확인
    Y1 - Y =\= X1 - X,          % 주 대각선에 놓여있지 않은지 확인
    Y1 - Y =\= X - X1,          % 보조 대각선에 놓여있지 않은지 확인
    is_safe(X/Y, Rest).

% N-Queen 문제를 푸는 규칙
n_queen(N, Solution) :-
    range(1, N, Rows),           % 1부터 N까지의 숫자 리스트 생성
    permutation(Rows, Solution), % 순열 생성
    safe_queens(Solution).

% 순열의 각 요소들이 서로 공격하지 않는지 확인
safe_queens([]).
safe_queens([X/Y | Rest]) :-
    is_safe(X/Y, Rest),
    safe_queens(Rest).

% 주어진 범위의 숫자 리스트를 생성하는 규칙
range(N, N, [N]).
range(N, M, [N | Rest]) :-
    N < M,
    NextN is N + 1,
    range(NextN, M, Rest).
queens(N, Queens) :-
    length(Queens, N),
	board(Queens, Board, 0, N, _, _),
	queens(Board, 0, Queens).

board([], [], N, N, _, _).
board([_|Queens], [Col-Vars|Board], Col0, N, [_|VR], VC) :-
	Col is Col0+1,
	functor(Vars, f, N),
	constraints(N, Vars, VR, VC),
	board(Queens, Board, Col, N, VR, [_|VC]).

constraints(0, _, _, _) :- !.
constraints(N, Row, [R|Rs], [C|Cs]) :-
	arg(N, Row, R-C),
	M is N-1,
	constraints(M, Row, Rs, Cs).

queens([], _, []).
queens([C|Cs], Row0, [Col|Solution]) :-
	Row is Row0+1,
	select(Col-Vars, [C|Cs], Board),
	arg(Row, Vars, Row-Row),
	queens(Board, Row, Solution).

%queens(n, X).