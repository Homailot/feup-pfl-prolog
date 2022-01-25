max(A, B, R):- B >= A, !, R is B.
max(A, B, A).

read_until([]) :-
    peek_char(C),
    C == '\n', !,
    get_char(_).

read_until(String) :-
    get_char(C),
    String = [C | Rest],
    read_until(Rest).