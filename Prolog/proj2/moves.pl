:- use_module(library(lists)).
:- use_module(library(random)).
:- consult('ruleset.pl').

get_move(Board, NewBoard) :-
    write('Your turn to play\n'),
    write('Choose a piece to move\n'),
    write('Column\n'),
    %read(Column),
    checkInputColumn(IsValidC, Column),
    write('Row\n'),
    %read(Row),
    checkInputRow(IsValidR, Row),
    write('Choose where to move it\n'),
    write('Column\n'),
    checkInputColumn(IsValidC, FinalColumn),
    write('Row\n'),
    checkInputRow(IsValidR, FinalRow),
    %checkLegalMove(Board, Column, Row, FinalColumn, FinalRow, ReturnBooleanValue),
    % (ReturnBooleanValue
    % -> move(Board, Column, Row, FinalColumn, FinalRow, NewBoard); 
    % write('Invalid move!')
    % ).
    move(Board, Column, Row, FinalColumn, FinalRow, NewBoard).


%NOTA: usar halt. para terminar execuçao de programa
move(Board, Column, Row, FinalColumn, FinalRow, NewBoard) :-
    %falta aqui dois nth0 para ver se o local de destino esta 'clear'
    %determine diretion of movement
    (Row =:= FinalRow -> 
        (Column =:= FinalColumn -> 
            diagonalMove(Board, Column, Row, FinalColumn, FinalRow, NewBoard);
                horizontalMove(Board, Row, Column, FinalColumn, NewBoard));
                    verticalMove(Board, Column, Row, FinalRow, NewBoard)).    



diagonalMove(Board, Column, Row, FinalColumn, FinalRow, NewBoard) :-
    write('diagonal\n'),
    write('Invalid Move!\n').

horizontalMove(Board, Row, Column, FinalColumn, NewBoard) :-
    nth0(Row, Board, RowList),
    %get element to move
    nth0(Column, RowList, Element),
    %clear old position
    replace(RowList, Column, clear, NewRowList),
    %put piece in new position
    replace(NewRowList, FinalColumn, Element, FinalRowList),
    %replace the old row with the new one
    replace(Board, Row, FinalRowList, NewBoard),
    write('horizontal\n').


verticalMove(Board, Column, Row, FinalRow, NewBoard) :-
    nth0(Row, Board, RowList),
    %get element to move
    nth0(Column, RowList, Element),

    %clear old position
    replace(RowList, Column, clear, NewRowList),
    replace(Board, Row, NewRowList, IntermediateBoard),

    %put piece in new position
    nth0(FinalRow, Board, FinalRowList),
    replace(FinalRowList, Column, Element, NewFinalRowList),
    %replace the old row with the new one
    replace(IntermediateBoard, FinalRow, NewFinalRowList, NewBoard),
    write('vertical\n').



% lista inicial, indice, elemento, lista depois
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- 
    I > -1,
    NI is I-1,
    replace(T, NI, X, R), !.
replace(L, _, _, L).


% insert element at n-th position on list, 3º argument is new element position after insert
insert(El, L, 0, [El | L]).
insert(El, [G | R], P, [G | Res]):-
	P1 is P - 1,
	insert(El, R, P1, Res).

% % check if it's the last element of list
% last'(X,[X]).
% last'(X,[_|Z]) :- last(X,Z).


ai_play(Board, NewBoard) :-
    %findall(Move, checkLegalMove(Board, OriginColumn, OriginRow, DestinationColumn, DestinationRow, Move), Moves),
    black_pieces(Board, 0, 0, List, BlackList),
    empty_places(Board, 0, 0, List1, ClearList),
    %get initial position
    random_member(Initial, BlackList),
    nth0(0, Initial, Row),
    nth0(1, Initial, Column),
    %get final position
    random_member(Final, ClearList),
    nth0(0, Final, FinalRow),
    nth0(1, Final, FinalColumn),
    %check if move is valid 
    %TO-DO
    %move
    move(Board, Column, Row, FinalColumn, FinalRow, NewBoard).
    %random_member(X, Moves).

%add element to the end of the list.
% element, list, list after insert
add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):-add_tail(T,X,L).

%list of lists with black pieces and it's position
black_pieces(_, 8, _, List, FinalList):- copy(List,FinalList).   %final row
black_pieces(Board, Row, 12, List, FinalList):-
    NewRow is Row+1,
    black_pieces(Board, NewRow, 0, List, FinalList).    %next row
black_pieces(Board, Row, Column, List, FinalList) :- %row and column starts at 0,0
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Element),
    (Element == b 
        -> add_tail(List,[Row, Column], NewList), NewColumn is Column+1, black_pieces(Board, Row, NewColumn, NewList, FinalList)
        ; NewColumn is Column+1, black_pieces(Board, Row, NewColumn, List, FinalList)
    ).

%list of lists with black pieces and it's position
empty_places(_, 8, _, List, FinalList):- copy(List,FinalList).   %final row
empty_places(Board, Row, 12, List, FinalList):-
    NewRow is Row+1,
    empty_places(Board, NewRow, 0, List, FinalList).    %next row
empty_places(Board, Row, Column, List, FinalList) :- %row and column starts at 0,0
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Element),
    (Element == clear 
        -> add_tail(List,[Row, Column], NewList), NewColumn is Column+1, empty_places(Board, Row, NewColumn, NewList, FinalList)
        ; NewColumn is Column+1, empty_places(Board, Row, NewColumn, List, FinalList)
    ).






    
