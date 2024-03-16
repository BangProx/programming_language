def promising(i,col):
    k = 1
    while(k < i):   #
        if(col[i] == col[k] or abs(col[i] - col[k]) == (i-k)):  #같은 열에 있거나 대각선상에 위치할 경우 퀸을 놓을수 없다. 
            return False
        k+=1
    return True

def nqueen(i, col):#i는 현재 depth이자 행의 값, col은 칼럼값
    n = len(col)-1#n은 0부터 시작한다.
    if(promising(i,col)):
        if(i == n):#n은 가장 깊은 depth. 따라서 i==n은 끝인 경우
            print(col[1:n+1])#[1,n]이니까 해당하는 칼럼의 row 번호를 전달해준다.
        else:
            for j in range(1,n+1):#for문으로 (i+1,j)에서 j에 가능한 값을 모두 조사.
                col[i+1] = j    #(i+1, j)에서 j를 일단 넣어봐야 조사가 가능하니까 넣어보고
                nqueen(i+1,col) #재귀호출->조건에 성립하는지 확인

n = int(input('n-queens 문제입니다. n의 값을 입력해주세요>>'))
col = [0]*(n+1)#col 리스트를 0으로 초기화
nqueen(0,col)#nqueen알고리즘을 초기값부터 시작한다.
