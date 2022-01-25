invert(List1, List2) :-
    invert(List1, List2, []).

invert([], List2, List2) :- !.
invert([H | List1], List2, Acc) :-
    invert(List1, List2, [H | Acc]).

del_one(_, [], []) :- !.
del_one(Elem, [Elem | List1], List1) :- !.
del_one(Elem, [X | List1], [X | List2]) :-
    del_one(Elem, List1, List2).

del_all(_, [], []) :- !.
del_all(Elem, [Elem | List1], List2) :- !,
    del_all(Elem, List1, List2).
del_all(Elem, [X | List1], [X | List2]) :-
    del_all(Elem, List1, List2).

del_all_list([], List, List) :- !.
del_all_list([Elem | ListElem], List1, List2) :-
    del_all(Elem, List1, List),
    del_all_list(ListElem, List, List2).

del_all_list2(_, [], []) :- !.
del_all_list2(ListElem, [H | List1], List2) :-
    member(H, ListElem), !,
    del_all_list2(ListElem, List1, List2).
del_all_list2(ListElem, [H | List1], [H | List2]) :-
    del_all_list2(ListElem, List1, List2).

del_dups(List1, List2) :- del_dups(List1, [], List2).

del_dups([], _, []) :- !.
del_dups([H | List1], Accepted, List2) :-
    memberchk(H, Accepted), !,
    del_dups(List1, Accepted, List2).
del_dups([H | List1], Accepted, [H | List2]) :-
    NewAccepted = [H | Accepted],
    del_dups(List1, NewAccepted, List2).

list_perm([], []) :- !.
list_perm([H | L1], L2) :-
    del_one(H, L2, NewL2),
    list_perm(L1, NewL2).

replicate(0, _, []) :- !.
replicate(Amount, Elem, [Elem | List]) :-
    NewAmount is Amount - 1,
    replicate(NewAmount, Elem, List).

intersperse(_, [], []) :- !.
intersperse(_, [H | []], [H]) :- !.
intersperse(Elem, [H | List1], [H, Elem | List2]) :-
    intersperse(Elem, List1, List2).

insert_elem(0, List1, Elem, [Elem | List1]) :- !.
insert_elem(Index, [H | List1], Elem, [H | List2]) :-
    NewIndex is Index - 1,
    insert_elem(NewIndex, List1, Elem, List2).

delete_elem(0, [Elem | List1], Elem, List1) :- !.
delete_elem(Index, [H | List1], Elem, [H | List2]) :-
    NewIndex is Index - 1,
    delete_elem(NewIndex, List1, Elem, List2).

replace([Old | List1], 0, Old, New, [New | List1]) :- !.
replace([H | List1], Index, Old, New, [H | List2]) :-
    NewIndex is Index - 1,
    replace(List1, NewIndex, Old, New, List2).
