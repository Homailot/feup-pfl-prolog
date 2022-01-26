:- use_module(library(between)).

double(X, R) :- R is X * 2. 
sum(X, Y, Z) :- Z is X + Y.

map(_, [], []) :- !.
map(Pred, [H | List1], [X | List2]) :-
    call(Pred, H, X),
    map(Pred, List1, List2).

fold(_, FinalValue, [], FinalValue) :- !.
fold(Pred, StartValue, [H | List], FinalValue) :-
    call(Pred, StartValue, H, Result),
    fold(Pred, Result, List, FinalValue).

even(X) :- 0 =:= X mod 2.

separate([], _, [], []) :- !.
separate([H | List], Pred, [H | Yes], No) :-
    call(Pred, H), !,
    separate(List, Pred, Yes, No).
separate([H | List], Pred, Yes, [H | No]) :-
    separate(List, Pred, Yes, No).

ask_execute :-
    write('Insire o que deseja executar'),
    read(Pred),
    Pred.