(format t "n-queen 문제입니다. n을 설정해주세요>>") ; 사용자에게 입력 요청 메시지 출력
(let ((n (parse-integer (read-line)))) ; 사용자로부터 n 값 입력 받음
  (let ((row (make-list n :initial-element 0))) ; 퀸들의 위치를 저장하는 리스트 생성 및 초기화
    (defun promising (x)
      ; 현재 열에서 유효한 위치인지 확인하는 함수
      (loop for i from 0 below x
            always (not (or (= (nth x row) (nth i row))
                            (= (abs (- (nth x row) (nth i row))) (- x i))))))

    (defun nqueen (x)
      ; 퀸 배치 함수
      (if (= x n)
          ; 모든 퀸이 배치된 경우
          (progn
            (print row) ; 해당 로우 출력
            (return-from nqueen))
          (loop for i from 0 below n
                do (progn
                     (setf (nth x row) i) ; 현재 열에 퀸 배치
                     (when (promising x) ; 유효한 위치인지 확인
                       (nqueen (1+ x)))))))

    (nqueen 0) ; 퀸을 놓을 자리 탐색을 시작한다.
    ))
