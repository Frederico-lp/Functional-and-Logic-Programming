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


move(Board, Column, Row, FinalColumn, FinalRow, NewBoard) :-
    %determine diretion of movement
    (Row =:= FinalRow -> 
        (Column =:= FinalColumn -> 
            diagonalMove(Board, Column, Row, FinalColumn, FinalRow, NewBoard);
                horizontalMove(Board, Row, Column, FinalColumn, NewBoard));
                    verticalMove(Board, Column, Row, FinalRow, NewBoard)).
    %nth0(Row, Board, ColumnList),
    


% nth0(?Index, ?List, ?Elem)

%este ainda n funciona na coisa antes
diagonalMove(Board, Column, Row, FinalColumn, FinalRow, NewBoard) :-
    nth0(Column, Board, RowList),
    write('diagonal\n').

horizontalMove(Board, Row, Column, FinalColumn, NewBoard) :-
    nth0(Row, Board, ColumnList),
    insert(vazio, ColumnList, Column, NewColumnList),
    %replace the old row with the new one
    replace(Board, Row, NewColumnList, NewBoard),
    write('horizontal\n').

verticalMove(Board, Column, Row, FinalRow, NewBoard) :-
    nth0(Column, Board, RowList),
    insert(vazio, RowList, Row, NewRowList),
    %replace the old column with the new one
    replace(Board, Column, NewRowList, NewBoard),
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
