:- use_module(library(between)).

move(LM/LC-RM/RC-left, NLM/NLC-NRM/NRC-right) :-
    MaxM is min(2, LM),
    MaxC is min(2, LC),
    between(0, MaxM, BoatM),
    between(0, MaxC, BoatC),
    Total is BoatM + BoatC,
    Total =< 2,
    Total > 0,
    NLM is LM - BoatM,
    NLC is LC - BoatC,
    NRM is RM + BoatM,
    NRC is RC + BoatC.
move(LM/LC-RM/RC-right, NLM/NLC-NRM/NRC-left) :-
    MaxM is min(2, RM),
    MaxC is min(2, RC),
    between(0, MaxM, BoatM),
    between(0, MaxC, BoatC),
    Total is BoatM + BoatC,
    Total =< 2,
    Total > 0,
    NLM is LM + BoatM,
    NLC is LC + BoatC,
    NRM is RM - BoatM,
    NRC is RC - BoatC.

missionaries_and_cannibals(Moves) :-
    missionaries_and_cannibals(3/3-0/0-left, [3/3-0/0-left], Moves).

% missionaries_and_cannibals(+Left-+Right, -Moves)
missionaries_and_cannibals(0/0-3/3-Boat, _, [0/0-3/3-Boat]) :- !.
missionaries_and_cannibals(LM/LC-_/_-_, _, _) :-
    LM > 0, LC > LM, !, fail.
missionaries_and_cannibals(_/_-RM/RC-_, _, _) :-
    RM > 0, RC > RM, !, fail.
missionaries_and_cannibals(LM/LC-RM/RC-Boat, Visited, [LM/LC-RM/RC-Boat | Moves]) :-
    move(LM/LC-RM/RC-Boat, NLM/NLC-NRM/NRC-NewBoat),
    \+ member(NLM/NLC-NRM/NRC-NewBoat, Visited),
    missionaries_and_cannibals(NLM/NLC-NRM/NRC-NewBoat, [NLM/NLC-NRM/NRC-NewBoat | Visited], Moves).
