connected(porto, lisbon).
connected(lisbon, madrid).
connected(lisbon, paris).
connected(lisbon, porto).
connected(madrid, paris).
connected(madrid, lisbon).
connected(paris, madrid).
connected(paris, lisbon).

not(Goal) :- Goal, !, fail.
not(_).

connects_dfs(S, F, P):-
    connects_dfs(S, F, [S], P).

connects_dfs(F, F, Path, Path).
connects_dfs(S, F, T, Path):-
    connected(S, N),
    not( member(N, T) ),
    connects_dfs(N, F, [N|T], Path).

connects_bfs(S, F, P) :-
    connects_bfs([0-S], F, [], P).

connects_bfs([Parent-F | _], F, _, Path) :- parents_to_list(Parent-F, Path).
connects_bfs([Parent-H | Queue], F, Visited, Path) :-
    findall(Parent-H-NewNode, (
        connected(H, NewNode),
        not(member(NewNode, Visited)),
        not(member(_-NewNode, [_-H | Queue]))    
    ), Next),
    append(Queue, Next, NewQueue),
    connects_bfs(NewQueue, F, [H | Visited], Path).

parents_to_list(Parents, List) :-
    parents_to_list(Parents, [], List).

parents_to_list(0, List, List) :- !.
parents_to_list(Parent-Child, Acc, List) :-
    parents_to_list(Parent, [Child | Acc], List).
