(defun insort (arr) ;삽입정렬 함수이고 매개변수로 리스트를 받는다.
  (do ((i 1 (+ i 1)))  ; 인덱스 i는 1부터 시작하고 1씩 증가한다.
      ((>= i (length arr)))  ; i가 리스트의 길이를 초과하면 반복문을 종료한다.
    (let ((k (nth i arr))  ; k에 현재 인덱스의 원소를 저장한다. c언어로 치면 k = arr[i]
          (j (- i 1)))  ; j를 i의 이전 인덱스로 초기화한다.
      (loop
         (cond
          ((< j 0)  ; j가 0보다 작아지면 
           (setf (nth (+ j 1) arr) k)  ; k를 j+1번째 자리에 저장하고 arr[j+1] = k
           (return))  ; 반복문을 종료한다.
          ((< k (nth j arr))                  ; k가 j번째 원소보다 작으면(k < arr[j])
           (setf (nth (+ j 1) arr) (nth j arr))  ; j번째 원소를 j+1번째로 이동시킨다.
           (decf j))  ; j는 왼쪽으로 한칸 이동한다. (j--)
          (t  ; k가 j번째 원소보다 크거나 같으면(k>= arr[j])
           (setf (nth (+ j 1) arr) k)  ; k를 j+1번째 원소에 저장하고  arr[j+1] = k
           (return))))))  ; 반복문을 종료한다.
  arr)  ; 정렬된 리스트를 반환한다.

; 입력값을 리스트로 선언한다.
(setq TC1 '(11 33 23 45 13 25 8 135))
(setq TC2 '(83 72 65 54 47 33 29 11))

;테스트 케이스 리스트를 출력한다.
(print TC1)
(print TC2)
(terpri);개행한다.
;; insertionsort를 사용하여 정렬된 결과를 출력한다.
(format t "결과: ~a~%" (insort TC1))
(format t "결과: ~a~%" (insort TC2))

