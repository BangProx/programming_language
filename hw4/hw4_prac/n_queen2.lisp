;; 유효한 위치인지 확인하는 함수 정의
(defun valid-position (board row col)
  "현재 위치(row, col)이 유효한 퀸의 배치 위치인지 확인합니다."
  (loop for i from 0 to (1- row)
        always (not (or (= (nth i board) col) ;; 같은 열에 퀸이 있는지 확인
                        (= (abs (- col (nth i board))) (- row i)))))) ;; 대각선 상에 퀸이 있는지 확인

;; n-queen 문제 해결 함수 정의
(defun n-queen (n)
  "n-queen 문제를 해결하는 함수입니다. n은 체스판의 크기이며, 퀸의 개수를 의미합니다."
  (let ((board (make-list n))) ;; 크기가 n인 리스트를 생성하여 보드를 초기화합니다.
    (labels ((place-queen (row)
               "row 행에 퀸을 배치하는 재귀적인 함수입니다."
               (if (= row n)
                   (print board) ;; 모든 퀸이 배치된 보드를 출력합니다.
                   (loop for col from 0 to (1- n)
                         when (valid-position board row col) ;; 현재 위치가 유효한지 확인합니다.
                         do (progn
                              (setf (nth row board) col) ;; 퀸을 현재 위치에 배치합니다.
                              (place-queen (1+ row))))))) ;; 다음 행에 대해 재귀적으로 호출합니다.
      (place-queen 0)))) ;; 첫 번째 행부터 시작하여 퀸을 배치합니다.

;; n = 4인 경우 테스트
(n-queen 4)
