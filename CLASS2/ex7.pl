:- use_module(library(lists)).

list_append([], L2, L2) :- !.
list_append([H | L1], L2, [H | L3]) :-
    list_append(L1, L2, L3).

list_member(Elem, List) :- append(_, [Elem | _], List).

list_last(List, Last) :- append(_, [Last], List).

list_nth(N, List, Elem) :- append(Prefix, [Elem | _], List), length(Prefix, N).

list_append(ListOfLists, List) :-
    list_append_lists(ListOfLists, [], List).

list_append_lists([], Res, Res) :- !.
list_append_lists([List1 | ListOfLists], Acc, Res) :-
    list_append(Acc, List1, List2),
    list_append_lists(ListOfLists, List2, Res).

list_append_good_version([L1], L1) :- !.
list_append_good_version([L1 | ListOfLists], List) :-
    list_append(L1, Rem, List),
    list_append_good_version(ListOfLists, Rem).