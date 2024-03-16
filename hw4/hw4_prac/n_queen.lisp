;; 유효한 위치인지 확인하는 함수 정의
(defun valid-position (board row col)
  (loop for i from 0 to (1- row)
        always (not (or (= (nth i board) col)
                        (= (abs (- col (nth i board))) (- row i))))))

;; n-queen 문제 해결 함수 정의
(defun n-queen (n)
  (let ((board (make-list n)))
    (labels ((place-queen (row)
               (if (= row n)
                   (print board) ; 모든 퀸이 배치된 보드를 출력합니다.
                   (loop for col from 0 to (1- n)
                         when (valid-position board row col)
                         do (progn
                              (setf (nth row board) col)
                              (place-queen (1+ row)))))))
      (place-queen 0))))

;; n = 4인 경우 테스트
(n-queen 4)
