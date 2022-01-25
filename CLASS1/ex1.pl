% gender

male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(cameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(pameron).
female(haley).
female(alex).
female(lily).
female(poppy).

% family

parent(grace, phil).
parent(frank, phil).

parent(dede, claire).
parent(jay, claire).

parent(dede, mitchell).
parent(jay, mitchell).

parent(jay, joe).
parent(gloria, joe).

parent(javier, manny).
parent(gloria, manny).

parent(barb, cameron).
parent(merle, cameron).

parent(barb, pameron).
parent(merle, pameron).

parent(phil, haley).
parent(claire, haley).

parent(phil, alex).
parent(claire, alex).

parent(phil, luke).
parent(claire, luke).

parent(mitchell, lily).
parent(cameron, lily).

parent(mitchell, rexford).
parent(cameron, rexford).

parent(pameron, calhoun).
parent(bo, calhoun).

parent(dylan, george).
parent(haley, george).

parent(dylan, poppy).
parent(haley, poppy).

% queries

%i.     ?- female(haley). -> yes
%ii.    ?- male(gil). -> no
%iii.   ?- parent(frank, phil) -> yes
%iv.    ?- parent(X, claire).
%       X = dede ? n
%       X = jay ? n
%       no
%v.     ?- parent(gloria, X).
%       X = joe ? n
%       X = manny ? n
%       no
%vi.    ?- parent(jay, _X), parent(_X, Y).
%       Y = haley ? n
%       Y = alex ? n
%       Y = luke ? n
%       Y = lily ? n
%       Y = rexford ? n
%       no
%vii.   ?- parent(_Y, lily), parent(X, _Y)
%       parent(haley, poppy).
%       X = dede ? n
%       X = jay ? n
%       X = barb ? n
%       X = merle ? n
%       no
%viii.  ?- parent(alex, _X).
%       no
%ix.    ?- parent(jay, X), \+ parent(gloria, X).
%       X = claire ? n
%       X = mitchell ? n
%       no

% c)

father(X, Y) :- parent(X, Y), male(X).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandmother(X, Y) :- grandparent(X, Y), female(X).
siblings(X, Y) :- parent(_Z, X), parent(_A, X), parent(_Z, Y), parent(_A, Y), (_Z \= _A), (X \= Y).
halfSiblings(X, Y) :- parent(_P, X), parent(_P, Y), \+ siblings(X, Y).
cousins(X, Y) :- parent(P1, X), parent(P2, Y), siblings(P1, P2).
uncle(X, Y) :- parent(P, Y), siblings(X, P), male(X).

% e)

married(jay, gloria, 1968).
married(gloria, jay, 1968).

divorced(gloria, jay, 2003).
divorced(jay, gloria, 2003).

ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

descendant(X, Y) :-
    parent(Y, X).
descendant(X, Y) :-
    parent(Z, X),
    descendant(Z, Y).