% 1.1
fatorial(0 ,1).
fatorial(N, F) :- N > 0,
            N1 is N - 1,
            fatorial(N1, Fn),
            F is N * Fn.

%1.2
somaRec(0, 0).
somaRec(N, Sum) :- N > 0,
                N1 is N - 1,
                somaRec(N1, Sumf),
                Sum is N + Sumf.

%2.1
% ancestor(?X, ?Y)
ancestor(X, Y) :- parent(X,Y).
ancestor(X, Y) :- 
                parent(X,A),
                ancestor(A,Y).

%2.2
%descendant (?X, ?Y)
descendant(X, Y):- parent(Y,X). %x é descendant se y for pai
descendant(X, Y):- 
                parent(Y,Z),    %x é descendant se y for pai de Z
                descendant(X,Z).    % e z pai de X

%4.1
%a) yes
%b) Syntax error
%c) yes
%d) [pfl | [lbaw, redes, ltw]] (H=pfl e T=[lbaw,redes,ltw])
%l) [One, Two | Tail] = [leic | Rest]. ---> One = leic, Rest = [Two|Tail]

%5.1
%list_size(+List, ?Size)
list_size([], 0).
list_size([_|T], Size):- 
                list_size(T, S1),
                Size is S1+1.

%5.2
%list_sum(+List, ?Sum)
list_sum([], 0).
list_sum([H|T], Sum):-
                list_sum(T, S1),
                Sum is S1 + H.


%6.1
%invert(+List1, ?List2)
invert(X,Y) :- invert_(X,Y,[]).
invert_([], Z, Z).
invert_([H|T], Y, Z):-
                invert_(T, Y, [H|Z]).

%invert1([], []).
%invert1([H|T], Y):-
%            L1 is [Y|T],
%            invert(T, L1),
%            Y is L1.


    
    
            