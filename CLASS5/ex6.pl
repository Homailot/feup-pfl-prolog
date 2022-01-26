:- use_module(library(lists)).

:- op(500, xfx, exists_in).

exists_in(Element, List) :- member(Element, List).

:- op(550, fx, append_).
:- op(600, xfx, results).
:- op(500, xfx, to).

results(append_(to(List1, List2)), Result) :-
    append(List2, List1, Result), !.

:- op(550, fx, remove).
:- op(500, xfx, from).

results(remove(from(Elem, List)), Result) :-
    delete(List, Elem, Result).
