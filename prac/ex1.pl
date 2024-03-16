sum(A) :- func(A,R) , write(R), nl.
func(0,0) :- !.
func(N,R) :- 
    N > 0,
    N1 is N-1,
    func(N1,R1),
    R is R1 + N.