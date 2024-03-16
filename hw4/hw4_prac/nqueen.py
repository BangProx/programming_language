n = int(input('n-queen 문제입니다. n을 설정해주세요>>'))
chess = [[0] * n for _ in range(n)]   #n x n 배열 모두 0으로 초기화
#퀸을 놓고나서 놓지 못하는 자리는 -1로 설정
#퀸이 놓인 자리는 1로 설정

for row in range(n):
    for col in range(n):
        if chess[row][col] == 0:    #queen이 들어갈 수 있는 자리이면 queen배치
            chess[row][col] = 1     #즉, 값을 1로 저장한다
            print(chess)            #debug
            for i in range(n-1):
                chess[row+1][i] = -1         #수평값 -1로 초기화
                chess[i][col] = -1         #수직값 -1로 초기화
            r = row
            c = col
            print(chess)
            while True:             #대각값들 -1로 초기화
                i = 1
                if r - i >= 0 and c - i >= 0:
                    chess[r-i][c-i] = -1
                    i += 1
                else:
                    break
            print('while1 break')
            print(chess)
            r = row
            c = col
            while True:
                i = 1
                if r + i < 8 and c + i < 8:
                    chess[r+i][c+i] = -1
                    i += 1
                else:
                    break          
            print('while2 break')
            print(chess)
          
for row in range(n):
    for col in range(n):
        if chess[row][col] == 1:
            print('({},{})'.format(row, col))