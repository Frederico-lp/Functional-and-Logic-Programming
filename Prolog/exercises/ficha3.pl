% 1.
s(1).
s(2):- !.
s(3).
%a)
% s(X).
% X = 1 ? n
% X = 2 ? n

%c)
% s(X), !, s(Y).
% X = 1,
% Y = 1 ? n         % como tem o cut(!) para logo
% X = 1,
% Y = 2 ? n

%2.
data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a('five').
cut_test_b(X):- data(X), !.
cut_test_b('five').
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c('five', 'five').

%a)
% one
% two
% three
% five

%b)
% one

%c)
% one-one
% one-two
% one-three

%3.


%4.
print_n(S, N) :-
    print_1n(S, N, 0).

print_1n(S, N, Index) :-
    write(S),
    (Index+1 =:= N -> stop(1); print_1n(S, N, Index+1)).
stop(1).

%print_text(+Text, +Symbol, +Padding)
print_text(Text, Symbol, Padding) :-
    write(Symbol),
    print_n(' ', Padding),
    my_string(Text),
    print_n(' ', Padding),
    write(Symbol),
    write('\n').


my_string([]).
my_string([H|T]) :- 
    put_code(H),
    my_string(T).




%5. 
%a)
children(Person, Children) :-
    findall(Child, parent(homer, Child), Children).

%b).
children_of(ListOfPeople, ListOfPairs) :-
    bagof(Child, parent(Person, Child), Children),
    ListOfPairs = (Person, Children).
    



