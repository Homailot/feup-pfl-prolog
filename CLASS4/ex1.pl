:- dynamic male/1, female/1, parent/2.

valid_gender(male).
valid_gender(female).

person(Person) :- male(Person).
person(Person) :- female(Person).

add_person :-
    repeat,
    format('~s', ["Are you male or female: "]),
    read(Gender),
    valid_gender(Gender), !,
    format('~s', ["Please give me your name: "]),
    read(Name),
    add_person(Gender, Name).

add_person('male', Name) :-
    assert(male(Name)).
add_person('female', Name) :-
    assert(female(Name)).

add_parent(Person) :-
    repeat,
    format('~s', ["male or female: "]),
    read(Gender),
    valid_gender(Gender), !,
    format('~s', ["Please give me name: "]),
    read(Name),
    add_person(Gender, Name),
    assert(parent(Name, Person)).

add_parents(Person) :-
    person(Person),
    repeat,
    format('~s', ["Insert Parent: "]),
    add_parent(Person),
    fail.

remove_parents(Person) :-
    clause(parent(Parent, Person), A),
    A,
    retract(parent(Parent, Person)),
    fail.
remove_parents(_).

remove_children(Person) :-
    clause(parent(Person, Child), A),
    A,
    retract(parent(Person, Child)),
    fail.
remove_children(_).

remove_person :-
    format('~s', ["Who do you want to erase from existence: "]),
    read(Person),
    (retract(male(Person)); retract(female(Person))),
    remove_children(Person),
    remove_parents(Person).

