:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').
:- consult('ruleset.pl').


/*
iterar por filas

board[i] = row nr i
board[i][j] = row nr i coluna nr j

verificar os moves dentro da mesma coluna e da mesma fila

*/

iterColumnFront(Board, OriginalRow, ColumnPosition, RowPosition, AuxList, ReturningList, ListOfValidMoves) :-
    CurrentPosition is RowPosition+1,
    Test_list = ReturningList,
    (
        CurrentPosition \= 8
    ->  checkLegalMove(Board, ColumnPosition, OriginalRow, ColumnPosition, CurrentPosition, ReturnValue),
        (
            ReturnValue == 'True'
        ->  append(AuxList, [['From:', OriginalRow, ColumnPosition, 'To:', CurrentPosition, ColumnPosition]], ListaAppend),
            Lista_Test = ListaAppend,
            iterColumnFront(Board, OriginalRow, ColumnPosition, CurrentPosition, ListaAppend, Lista_Test, ListOfValidMoves)
        ;   iterColumnFront(Board, OriginalRow, ColumnPosition, CurrentPosition, AuxList, ReturningList, ListOfValidMoves)
        )
    ;  copy(Test_list, ListOfValidMoves), !
    ).

iterColumnBack(Board, OriginalRow, ColumnPosition, RowPosition, AuxList, ReturningList, ListOfValidMoves) :-
    CurrentPosition is RowPosition-1,
    Test_list_imdone = ReturningList,
    (
        CurrentPosition \= -1
    ->  checkLegalMove(Board, ColumnPosition, OriginalRow, ColumnPosition, CurrentPosition, ReturnValue),
        (
            ReturnValue == 'True'
        ->  append(AuxList, [['From:', OriginalRow, ColumnPosition, 'To:', CurrentPosition, ColumnPosition]], ListaAppend),
            Lista_Test = ListaAppend,
            iterColumnBack(Board, OriginalRow, ColumnPosition, CurrentPosition, ListaAppend, Lista_Test, ListOfValidMoves)
        ;   iterColumnBack(Board, OriginalRow, ColumnPosition, CurrentPosition, AuxList, ReturningList, ListOfValidMoves)
        )
    ;  copy(Test_list_imdone, ListOfValidMoves), !
    ).

iterRowBack(Board, OriginalRow, OriginalColumn, ColumnPosition, AuxList, ReturningList, ListOfValidMoves) :-
    CurrentPosition is ColumnPosition-1,
    Test_list = ReturningList,
    (
        CurrentPosition \= -1
    ->  checkLegalMove(Board, OriginalColumn, OriginalRow, CurrentPosition, OriginalRow, ReturnValue),
        (
            ReturnValue == 'True'
        ->  append(AuxList, [['From:', OriginalRow, OriginalColumn, 'To:', OriginalRow, CurrentPosition]], ListaAppend),
            Lista_Test = ListaAppend,
            iterRowBack(Board, OriginalRow, OriginalColumn, CurrentPosition, ListaAppend, Lista_Test, ListOfValidMoves)
        ;   iterRowBack(Board, OriginalRow, OriginalColumn, CurrentPosition, AuxList, ReturningList, ListOfValidMoves)
        )
    ;  copy(Test_list, ListOfValidMoves), !
    ).

iterRowFront(Board, OriginalRow, OriginalColumn, ColumnPosition, AuxList, ReturningList, ListOfValidMoves) :-
    CurrentPosition is ColumnPosition+1,
    Test_list = ReturningList,
    (
        CurrentPosition \= 12
    ->  checkLegalMove(Board, OriginalColumn, OriginalRow, CurrentPosition, OriginalRow, ReturnValue),
        (
            ReturnValue == 'True'
        ->  append(AuxList, [['From:', OriginalRow, OriginalColumn, 'To:', OriginalRow, CurrentPosition]], ListaAppend),
            Lista_Test = ListaAppend,
            iterRowFront(Board, OriginalRow, OriginalColumn, CurrentPosition, ListaAppend, Lista_Test, ListOfValidMoves)
        ;   iterRowFront(Board, OriginalRow, OriginalColumn, CurrentPosition, AuxList, ReturningList, ListOfValidMoves)
        )
    ;  copy(Test_list, ListOfValidMoves), !
    ).

getPieceCoords([H|T], PieceColumn, PieceRow):-
    nth0(0, T, R),
    PieceRow = H, PieceColumn = R.

getPieceOnList(Index, List, Piece) :-
    nth0(Index, List, Piece).

checkValidMovesForPiece(Board, Piece, ListOfValidMoves) :-
    getPieceCoords(Piece, PieceColumn, PieceRow),
    iterRowFront(Board, PieceRow, PieceColumn, PieceRow, [], ReturningList, ValidListRF),
    iterRowBack(Board, PieceRow, PieceColumn, PieceRow, [], ReturningList, ValidListRB),
    iterColumnFront(Board, PieceRow, PieceColumn, PieceRow, [], ReturningList, ValidListCF),
    iterColumnBack(Board, PieceRow, PieceColumn, PieceRow, [], ReturningList, ValidListCB),
    append(ValidListCB, ValidListCF, ValidListColumn),
    append(ValidListRB, ValidListRF, ValidListRow),
    append(ValidListRow, ValidListColumn, ValidMoves),
    ListOfValidMoves = ValidMoves.


% X = Board
% valid_moves(Board, ListOfValidMoves) :-

valid_moves :- 
    starting_board(Board),
    black_pieces(Board, 0, 0, List, BlackList),
    getPieceOnList(11, BlackList, Piece),
    checkValidMovesForPiece(Board, Piece, ValidList),
    write(ValidList).
    
% consult('/Users/pjpacheco/Desktop/FEUP/3Ano/PFL/project/PFL/Prolog/proj2/test_file.pl').