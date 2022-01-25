:- use_module(library(lists)).

list_size(List, Size) :-
    list_size(List, Size, 0).

list_size([], Size, Size) :- !.
list_size([_ | T], Size, Acc) :-
    Acc1 is Acc + 1,
    list_size(T, Size, Acc1).

list_sum(List, Sum) :-
    list_sum(List, Sum, 0).

list_sum([], Sum, Sum) :- !.
list_sum([Val | Rest], Sum, Acc) :-
    Acc1 is Val + Acc,
    list_sum(Rest, Sum, Acc1).

inner_product(List1, List2, Result) :-
    inner_product(List1, List2, 0, Result).

inner_product([], [], Result, Result) :- !.
inner_product([H1 | Rest1], [H2 | Rest2], Sum, Result) :-
    Sum1 is H1 * H2 + Sum,
    inner_product(Rest1, Rest2, Sum1, Result).

count(Elem, List, N) :-
    count(Elem, List, 0, N).

count(_, [], N, N) :- !.
count(Elem, [Elem | Rest], Count, N) :- !,
    N1 is Count + 1,
    count(Elem, Rest, N1, N).
count(Elem, [_ | Rest], Count, N) :-
    count(Elem, Rest, Count, N).
