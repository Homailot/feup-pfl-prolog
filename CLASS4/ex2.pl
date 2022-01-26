:- use_module(library(lists)).

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

find_flights_breadth([[Destination | Parents] | _], Destination, _, Flights) :- reverse(Parents, Flights), !.
find_flights_breadth([[Child | Parents] | Queue], Destination, Visited, Flights) :-
    findall([Next, Code | Parents], (
        flight(Child, Next, _, Code, _, _),
        \+ member(Next, Visited),
        \+ member([Next | _], [[Child | _] | Queue])
    ), NextQueue),
    append(Queue, NextQueue, NewQueue),
    find_flights_breadth(NewQueue, Destination, [Child | Visited], Flights).

find_all_flights(Origin, Destination, ListOfFlights) :-
    findall(Codes, find_flights(Origin, Destination, Codes), ListOfFlights).

find_flights_least_stops(Origin, Destination, ListOfFlights) :-
    bagof(Codes, (
        find_flights(Origin, Destination, Codes),
        length(Codes, _)
    ), ListOfFlights), !.

find_flights_stops(Origin, Destination, Stops, ListOfFlights) :-
    findall(Flights, find_flights_stops_dfs(Origin, Destination, Stops, Flights), ListOfFlights).

find_flights_stops_dfs(Origin, Destination, Stops, Flights) :-
    find_flights_stops_dfs(Origin, Destination, Stops, [Origin], Flights).

find_flights_stops_dfs(Destination, Destination, _, _, []) :- !.
find_flights_stops_dfs(Origin, Destination, Stops, Visited, [Code | Flights]) :-
    flight(Origin, Next, _, Code, _, _),
    \+ member(Next, Visited),
    (Next == Destination;  member(Next, Stops)),
    find_flights_stops_dfs(Next, Destination, Stops, [Next | Visited], Flights).

find_circular_trips(MaxSize, Origin, Cycles) :-
    bagof(Cycle, find_circular_trips_dfs(MaxSize, Origin, Cycle), Cycles). % used bagof so it returns no instead of empty list.

find_circular_trips_dfs(MaxSize, Origin, Cycle) :-
    find_circular_trips_dfs(MaxSize, Origin, Origin, Cycle).

find_circular_trips_dfs(_, Origin, Origin, []).
find_circular_trips_dfs(0, _, _, []) :- !, fail.
find_circular_trips_dfs(MaxSize, Origin, Current, [Code | Cycle]) :-
    MaxSize > 0,
    flight(Current, Next, _, Code, _, _),
    NextSize is MaxSize - 1,
    find_circular_trips_dfs(NextSize, Origin, Next, Cycle).