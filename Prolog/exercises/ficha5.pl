:- use_module(library(lists)).
% 1.
%a)
double(X, Y):- Y is X*2.

map(_, [], []).
map(Pred, [H|T], [H1|T1]) :-
    call(Pred,H,H1),
    map(Pred, T, T1).


%b)
sum(A, B, S):- S is A+B.

fold(_, StartValue, [], FinalValue):- FinalValue is StartValue.
fold(Pred, StartValue, [H|T], FinalValue) :-
    call(Pred,StartValue, H, Temp),
    fold(Pred, Temp, T, FinalValue).


%2.
%a)
my_arg(Index, Term, Arg) :-
    Term =.. List,
    NewIndex is Index + 1,
    nth1(NewIndex, List, Arg).


my_functor(Term, Name, Arity) :-
    (var(Term) 
        -> add_arguments(X, Arity, Args),
        Term =.. [Name, Args]

        ;Term =.. List,
        nth1(1, List, Name),
        length(List, ArityAux),
        Arity is ArityAux - 1
    ).

add_arguments(Args, 0, Args). 
add_arguments(Args, Index, FinalArgs) :-
    append(Args, [a], List),
    NewIndex is Index - 1,
    add_arguments(List, NewIndex, FinalArgs).


%3.
:-op(500, xfx, na).
:-op(500, yfx, la).
:-op(500, xfy, ra).

a ra b la c.

%a la b ra c.


%5.
%a)
% flight(X).

% %op(500, xf, flight).
% op(500, xfx, from).
% op(500, xfx, to).
% op(500, xfx, at).

/*
Operators of type xfx are not associative: it is a requirement that both of the two subexpressions which are the arguments of the operator must be of lower precedence than the operator itself, i.e. their principal functors must be of lower precedence, unless the subexpression is explicitly parenthesized (which gives it zero precedence).

Operators of type xfy are right-associative: only the first (left-hand) subexpression must be of lower precedence; the right-hand subexpression can be of the same precedence as the main operator. Left-associative operators (type yfx) are the other way around. 
*/

    
