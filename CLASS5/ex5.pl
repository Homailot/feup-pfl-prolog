:- op(550, fx, flight).
:- op(500, xfy, from).
:- op(500, xfx, to).
:- op(600, xfx, at).

:- op(550, xfx, then).
:- op(500, fy, if).
:- op(500, xfx, else).


flight tp1949 from porto to lisbon at 16:15.

then(if(X), else(Z, _)) :-
    X, !,
    Z.
then(_, else(_, Y)) :-
    Y.
