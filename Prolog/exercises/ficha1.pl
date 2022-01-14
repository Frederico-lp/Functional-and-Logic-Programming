%comentario
% x para fazer pergunta S/N com variavel desconhecida
% X para pergunta em que devolve coisas
% , para fazer &&
% varias rules para fazer || ou ;
% not é \+
male(frank).
male(jay).
male(javier).
male(merle).
male(phill).
male(joe).
male(manny).
male(cameron).
male(pameron).
male(dylan).
male(alex).
male(luke).
male(rexford).
male(calhoun).
male(george).

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(mitchell).
female(bo).
female(haley).
female(lily).
female(poppy).

parent(grace, phill).
parent(frank, phill).
parent(dede, claire).
parent(jay, claire).
parent(dede, mitchell).
parent(jay, mitchell).
parent(jay, joe).
parent(gloria, joe).
parent(gloria, manny).
parent(javier, manny).
parent(barb, cameron).
parent(merle, cameron).
parent(barb, pameron).
parent(merle, pameron).
parent(phill, haley).
parent(claire, haley).
parent(phill, alex).
parent(claire, alex).
parent(phill, luke).
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

% netos : parent(jay, X), parent(X, Y).

father(X,Y):- parent(X,Y), male(X).
mother(X, Y) :- parent(X,Y), female(X).
grandfather(X, Y):- father(X, Z), parent(Z, Y). 
siblings(X, Y) :- father(Z, X), father(Z,Y), mother(A,X), mother(A,Y).
halfSiblings(Q,P):- ( father(X,Q),father(X,P);mother(Y,Q),mother(Y,P) ), \+ siblings(Q,P).

%ficha 2
ancestor(X, Y) :- parent(X,Y).
ancestor(X, Y) :- 
                parent(X,A),
                ancestor(A,Y).
    
descendant(X, Y):- parent(Y,X). %x é descendant se y for pai
descendant(X, Y):- 
                parent(Y,Z),    %x é descendant se y for pai de Z
                descendant(X,Z).    % e z pai de X


%ficha 3
children(Person, Children) :-
    findall(Child, parent(Person, Child), Children).

children1(Person, Children) :-
    bagof(Child, parent(Person, Child), Children).

children_of(ListOfPeople, ListOfPairs) :-
    bagof(Child, parent(Person, Child), Children),
    ListOfPairs = Person-Children.


%ficha 4
add_person :-
    write('male or female?\n'),
    read(Sex),
    write('name of the person:\n'),
    read(Person),
    (Sex == male
        ->assertz(male(Person))
        ;assertz(female(Person))
    ).
        
