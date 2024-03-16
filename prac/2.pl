% n-queen 문제 해결을 위한 코드

% main_predicates/1: n-queen 문제를 해결하기 위한 메인 프레디케이트
main_predicates(N) :-
    length(Board, N),  % N 크기의 리스트 Board를 생성
    maplist(generate_row(N), Board),  % Board의 각 요소에 대해 N 크기의 행을 생성
    safe_queens(Board),  % Board에 있는 여왕들이 서로 공격하지 않는지 확인
    print_board(Board).  % 최종적으로 생성된 보드 출력

% generate_row/2: 길이가 N인 행을 생성하는 프레디케이트
generate_row(N, Row) :-
    length(Row, N).

% safe_queens/1: Board에 있는 여왕들이 서로 공격하지 않는지 확인하는 프레디케이트
safe_queens([]).  % 빈 리스트인 경우, 여왕들이 서로 공격하지 않으므로 성공

safe_queens([Row|Rest]) :-
    safe_queens(Rest),  % 나머지 행에 있는 여왕들이 서로 공격하지 않는지 확인
    no_attack(Row, Rest, 1).  % 현재 행의 여왕이 다른 행의 여왕들과 공격하지 않는지 확인

% no_attack/3: 현재 행의 여왕이 다른 행의 여왕들과 공격하지 않는지 확인하는 프레디케이트
no_attack(_, [], _).  % 더 이상 비교할 행이 없는 경우, 성공

no_attack(Queen, [Row|Rest], N) :-
    no_attack(Queen, Rest, N),  % 다음 행에 있는 여왕들과의 비교를 위해 재귀 호출
    Queen \== Row,  % 현재 행의 여왕과 다음 행의 여왕이 같지 않은 경우
    Queen =\= Row + N,  % 대각선(\) 방향으로 공격하지 않는 경우
    Queen =\= Row - N,  % 대각선(/) 방향으로 공격하지 않는 경우
    N1 is N + 1.  % 다음 열로 이동

% print_board/1: 최종적으로 생성된 보드를 출력하는 프레디케이트
print_board([]).  % 빈 리스트인 경우, 출력 종료

print_board([Row|Rest]) :-
    print_row(Row),  % 현재 행 출력
    print_board(Rest).  % 나머지 행 출력

% print_row/1: 특정 행을 출력하는 프레디케이트
print_row([]) :- nl.  % 행이 빈 경우, 개행 후 출력 종료

print_row([Cell|Rest]) :-
    print_cell(Cell),  % 현재 셀 출력
    print_row(Rest).  % 나머지 셀 출력

% print_cell/1: 특정 셀을 출력하는 프레디케이트
print_cell(Queen) :-
    Queen = 1,  % Queen이 1인 경우, 여왕을 나타내는 Q 출력
    write('Q ').

print_cell(_) :-
    write('. ').  % 그 외의 경우, 빈 공간을 나타내는 . 출력

% 사용자로부터 n 값을 입력받아 n-queen 문제 해결
solve_n_queen :-
    write('Enter the value of N: '),
    read(N),  % 사용자로부터 N 값 입력받기
    main_predicates(N).  % n-queen 문제 해결 메인 프레디케이트 호출
