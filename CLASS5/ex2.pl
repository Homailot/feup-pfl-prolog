my_arg(Index, Term, Arg) :-
    Term =.. [_Name | Args],
    nth1(Index, Args, Arg).

my_functor(Term, Name, Arity) :-
    Term =.. [Name | Args],
    length(Args, Arity).

univ(_, Current, Arity, []) :-
    Current > Arity, !.
univ(Term, Current, Arity, [Arg | Args]) :-
    arg(Current, Term, Arg),
    Next is Current + 1,
    univ(Term, Next, Arity, Args).

univ(Term, [Name | Args]) :-
    functor(Term, Name, Arity),
    univ(Term, 1, Arity, Args).

:- op(700, xfx, univ).
    