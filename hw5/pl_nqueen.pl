% n-queen 문제입니다. n을 설정해주세요.
n_queen :-
    write('n-queen 문제입니다. n을 설정해주세요>>'),
    read(N),
    n_queen(N, [], Solutions),  % n_queen/3를 호출하여 해답을 구합니다.
    print_solutions(Solutions). % 구한 해답을 출력합니다.

n_queen(N, Rows, Solutions) :-
    length(Rows, N),          % Rows 리스트의 길이를 N으로 설정합니다.
    place_queens(N, Rows),    % 퀸을 배치합니다.
    findall(Rows, valid_solution(Rows), Solutions). % 유효한 해답을 찾아 Solutions 리스트에 저장합니다.

place_queens(0, _).  % 퀸 배치를 완료했을 때, 종료합니다.
place_queens(N, Rows) :-
    N > 0,
    N1 is N - 1,
    place_queens(N1, Rows),  % 이전 행에 퀸을 배치합니다.
    member(Y, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]),  % 현재 행의 Y 좌표를 선택합니다. (0부터 N-1까지의 값)
    safe_place(N, Y, Rows),  % (N, Y)에 퀸을 배치할 수 있는지 확인합니다.
    Rows = [Y | _].  % 현재 행에 Y 값을 추가합니다.

valid_solution(Rows) :-
    \+ invalid_solution(Rows). % 유효하지 않은 해답이 아닌지 확인합니다.

invalid_solution(Rows) :-
    select(Y, Rows, Rest),  % 첫 번째 행의 Y 값을 선택하고 나머지 행들과 매칭합니다.
    invalid_solution(Y, Rest). % 다른 행들과 충돌하는지 확인합니다.

invalid_solution(_, []).
invalid_solution(Y1, [Y2 | Rest]) :-
    Y1 =:= Y2,  % 같은 열에 있는지 확인합니다.
    invalid_solution(Y1, Rest).
invalid_solution(Y1, [Y2 | Rest]) :-
    abs(Y1 - Y2) =:= Length,  % 대각선에 있는지 확인합니다.
    invalid_solution(Y1, Rest),
    Length =:= length(Rest) + 1. % Rest 리스트의 길이와 차이가 1인지 확인합니다.

print_solutions([]).  % 출력할 해답이 없을 때, 종료합니다.
print_solutions([Solution | Rest]) :-
    write(Solution), nl,  % 해답을 출력합니다.
    print_solutions(Rest).

n_queen.  % n_queen을 호출하여 실행합니다.
