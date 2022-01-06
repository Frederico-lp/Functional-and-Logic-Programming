:- use_module(library(lists)).

get_move(Board, NewBoard) :-
    write('Your turn to play\n'),
    write('Choose a piece to move\n'),
    write('Column\n'),
    read(Column),
    write('Row\n'),
    read(Row),
    write('Choose where to move it\n'),
    write('Column\n'),
    read(FinalColumn),
    write('Row\n'),
    read(FinalRow),
    %FALTA: check for valid move
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
