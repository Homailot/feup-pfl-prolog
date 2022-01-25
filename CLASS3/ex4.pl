print_n(S, 0).
print_n(S, N) :- put_char(S), N1 is N - 1,  print_n(S, N1).

print_("") :- !.
print_([A|R]) :-
	put_code(A),
	print_(R).

print_text(Text, Symbol, Padding) :- 
	put_char(Symbol), 
	print_n(' ', Padding), 
	print_(Text),
       	print_n(' ', Padding),	
	put_char(Symbol).

print_banner(Text, Symbol, Padding) :-
	length(Text, Len),
	InnerSize is Len + Padding * 2,
	Size is InnerSize + 2,
	print_n(Symbol, Size), nl,
	put_char(Symbol), print_n(' ', InnerSize), put_char(Symbol), nl,
	put_char(Symbol), print_n(' ', Padding),
	print_(Text), print_n(' ', Padding), put_char(Symbol), nl,
	put_char(Symbol), print_n(' ', InnerSize), put_char(Symbol), nl,
	print_n(Symbol, Size), nl.
