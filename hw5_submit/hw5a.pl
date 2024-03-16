% insert(X, List, Result)는 정렬된 리스트(List)에 원소(X)를 삽입해서 결과(Result)를 반환합니다.
insert(X, [], [X]). % 1. 빈 리스트에 원소를 삽입하면 그 원소만을 갖는 리스트를 반환합니다.
insert(X, [Y|Rest], [X,Y|Rest]) :- X =< Y. % 2. X<=Y이면 X를 Y 앞에 삽입합니다.
insert(X, [Y|Rest], [Y|Result]) :- X > Y, insert(X, Rest, Result). % 3. X>Y이면 Y를 결과 리스트에 유지한 채로 X를 재귀적으로 삽입합니다.

% sorting(List, Sortedlist)는 주어진 리스트(List)를 정렬하여 결과(Sortedlist)를 반환합니다.
sorting([], []). % 빈 리스트는 이미 정렬되어 있으므로 빈 리스트를 반환합니다.
sorting([X|Rest], Sortedlist) :- sorting(Rest, Psortedlist), insert(X, Psortedlist, Sortedlist). 
% 리스트를 재귀적으로 정렬한 후, 그 결과에 현재 원소 X를 삽입하여 전체 리스트를 정렬합니다. 

%TC1 : [11, 33, 23, 45, 13, 25, 8, 135]
%TC2 : [83 ,72 ,65 ,54 ,47 ,33 ,29 ,11]