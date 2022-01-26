%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60). 
flight(lisbon, madrid, tap, tp1018, 1805, 75). 
flight(lisbon, paris, tap, tp440, 1810, 150). 
flight(lisbon, london, tap, tp1366, 1955, 165). 
flight(london, lisbon, tap, tp1361, 1630, 160). 
flight(porto, madrid, iberia, ib3095, 1640, 80). 
flight(madrid, porto, iberia, ib3094, 1545, 80). 
flight(madrid, lisbon, iberia, ib3106, 1945, 80). 
flight(madrid, paris, iberia, ib3444, 1640, 125). 
flight(madrid, london, iberia, ib3166, 1550, 145). 
flight(london, madrid, iberia, ib3163, 1030, 140). 
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).
flight(lisbon, frankfurt, lufthansa, lh1177, 1230, 165).

airport(Airport) :-
    flight(Airport, _, _, _, _, _).
airport(Airport) :-
    flight(_, Airport, _, _, _, _).

get_all_nodes(ListOfAirports) :-
    setof(Airport, airport(Airport), ListOfAirports).

company_destinations(Company, Destinations) :-
    setof(Destination, S^C^H^D^flight(S, Destination, Company, C, H, D), List),
    length(List, Dest),
    Destinations is -Dest.

most_diversified(Company) :-
    setof(Destinations-Cmp, company_destinations(Cmp, Destinations), [_D-Company | _]).

find_flights(Origin, Destination, Flights) :-
    find_flights(Origin, Destination, [Origin], Flights).

find_flights(Destination, Destination, _, []) :- !.
find_flights(Origin, Destination, Visited, [Code | Flights]) :-
    flight(Origin, Z, _, Code, _, _),
    \+ member(Z, Visited),
    find_flights(Z, Destination, [Z | Visited], Flights).

find_flights_breadth(Origin, Destination, Flights) :-
    find_flights_breadth([[Origin]], Destination, [], Flights).

find_flights_breadth([[Destination | Parents] | _], Destination, _, Parents) :- !.
find_flights_breadth([[Child | Parents] | Queue], Destination, Visited, Flights) :-
    findall([Next, Code | Parents], (
        flight(Child, Next, _, Code, _, _),
        \+ member(Next, Visited),
        \+ member([Next | _], [[Child | _] | Queue])
    ), NextQueue),
    append(Queue, NextQueue, NewQueue),
    find_flights_breadth(NewQueue, Destination, [Child | Visited], Flights).
