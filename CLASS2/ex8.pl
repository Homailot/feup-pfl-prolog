:- use_module(library(lists)).

list_to(N, List) :- list_to(N, [], List).

list_to(0, List, List) :- !.
list_to(N, Acc, List) :-
    NewN is N - 1,
    list_to(NewN, [N | Acc], List).
