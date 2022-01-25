
% fatorial(+N, ?F)
:- use_module(library(lists)).

fatorial(N, F) :- fatorial(N, F, 1).

fatorial(0, Acc, Acc).
fatorial(N, F, Acc) :- N > 0, 
                       NAcc is N * Acc, 
                       N1 is N - 1, 
                       fatorial(N1, F, NAcc).


fatorialRec(0, 1).
fatorialRec(N, F) :- N > 0,
                     N1 is N - 1,
                     fatorialRec(N1, Fac),
                     F is Fac * N.


% somaRec(+N, ?Sum)
somaRec(N, Sum) :- somaRec(N, Sum, 0).

somaRec(0, Sum, Sum).
somaRec(N, Sum, Acc) :- N > 0,
                        N1 is N - 1,
                        NAcc is Acc + N,
                        somaRec(N1, Sum, NAcc).

somaRec2(0, 0).
somaRec2(N, Sum) :- N > 0,
                    N1 is N - 1,
                    somaRec2(N1, Sum1),
                    Sum is Sum1 + N.

% fibonacci (+N, ?F)
fibonacci(0, 0) :- !.
fibonacci(1, 1) :- !.
fibonacci(N, F) :- N > 1, fibonacci(N, F, 1, 0, 1).

fibonacci(N, F, F, _, N) :- N > 1, !.
fibonacci(N, F, Last, BeforeLast, Cur) :- Cur < N,
                                          N1 is Cur + 1,
                                          NBeforeLast is Last,
                                          NLast is BeforeLast + Last,
                                          fibonacci(N, F, NLast, NBeforeLast, N1).



% isPrime(-X).
isPrime(X) :- X > 1, isPrime(X, 2).

isPrime(X, Cur) :- Y is Cur * Cur,
                   X mod Cur =\= 0,
                   Cur1 is Cur + 1,
                   (Y > X; isPrime(X, Cur1)).
