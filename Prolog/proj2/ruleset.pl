:- use_module(library(random)).
:- use_module(library(lists)).
:- consult('board.pl').

% Choose a randomly start player 
% PlayerOne is 1 and PlayerTwo is 3 (because the upperbound is not included in the interval)

choosePlayer(PlayerOne, PlayerTwo, FirstToPlay) :-
    random(PlayerOne, PlayerTwo, FirstToPlay).

% ---------------------------------------------------------------

% Changes players turns

changeTurn(CurrentPlayer, NextPlayer) :- 
    (
    CurrentPlayer =:= 1 
    -> NextPlayer = 2
    ; NextPlayer = 1
    ).
    
% ---------------------------------------------------------------

% Checks if it is an horizontal move

checkHorizontalMove(Column, Row, FinalColumn, FinalRow, ReturnBooleanValue) :-
    (
        Column \= FinalColumn
    ->  (
            Row == FinalRow
        -> ReturnBooleanValue = 'True'
        ; ReturnBooleanValue = 'False'
        )
    ;   ReturnBooleanValue = 'False'
    ).

% ---------------------------------------------------------------

% Checks if it is a vertical move

checkVerticalMove(Column, Row, FinalColumn, FinalRow, ReturnBooleanValue) :-
    (
        Row \= FinalRow
    ->  (
            Column == FinalColumn
        -> ReturnBooleanValue = 'True'
        ; ReturnBooleanValue = 'False'
        )
    ;   ReturnBooleanValue = 'False'
    ).

% ---------------------------------------------------------------

% Checks if the row is valid

checkInputRow(IsValid, Row):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7])
    -> IsValid = 'True', Row = Number, !, true
    ; write('Invalid Row\n'), IsValid = 'False'
    ).

% ---------------------------------------------------------------

% Checks if the column is valid

checkInputColumn(IsValid, Column):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7,8,9,10,11])
    -> IsValid = 'True',Column = Number, !, true
    ; write('Invalid Column'), nl, IsValid = 'False'
    ).

% ---------------------------------------------------------------

% Returns a Row

getRow(Board, RowNumber, ReturningRow) :-
    nth0(RowNumber, Board, ReturningRow).

% ---------------------------------------------------------------

% Returns a column

accCp([],[]).
accCp([H|T1],[H|T2]) :- accCp(T1,T2).
copy(L,R) :- accCp(L,R).

loopRows(Board, Rows, ColumnNumber, EL, ReturningColumn, FinalColumn) :- 
    nth0(Rows, Board, ReturningRow),
    nth0(ColumnNumber, ReturningRow, ReturnColumnElement),
    append(EL, [ReturnColumnElement], Column),
    C_Test = Column,
    S is Rows+1, 
    (
        S == 8
    -> copy(Column, FinalColumn), !
    ;  loopRows(Board, S, ColumnNumber, Column, C_Test, FinalColumn)
    ).

getColumn(Board, ColumnNumber, FinalColumn) :-
    loopRows(Board, 0, ColumnNumber, [], ReturningColumn, FinalColumn).

% ---------------------------------------------------------------

% Checks if there is a piece at the destination position

checkPieceOnDestination(RowOrColumn, Destination, ReturnBooleanValue) :-
    nth0(Destination, RowOrColumn, Piece),
    (
        Piece == clear

    ->  ReturnBooleanValue = 'False', !

    ; ReturnBooleanValue = 'True', ! 
    ).
    
% ---------------------------------------------------------------

% Checks if there is a piece between the original position and the destination position

list_length(Xs, L) :- list_length(Xs, 0, L).
list_length([], L, L).
list_length([_|Xs], T, L) :-
  T1 is T+1,
  list_length(Xs, T1, L).

loopBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, Len, ReturnBooleanValue) :-
    (
        Len == 12 %se for uma row
    ->  (
            CheckInFront == 'True'
        ->  Counter is OriginalPosition+1,
            Counter_Check is DestinationPosition+1,
            (
                Counter == Counter_Check 
            ->  ReturnBooleanValue = 'False', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Len, ReturnBooleanValue)
                ;   ReturnBooleanValue = 'True', !
                )
            )
        ;   Counter is OriginalPosition-1,
            Counter_Check is DestinationPosition-1,
            (
                Counter == Counter_Check
            ->  ReturnBooleanValue = 'False', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Len, ReturnBooleanValue)
                ;   ReturnBooleanValue = 'True', !
                )
            )
        )
    ;   (
            CheckInFront == 'True'
        ->  Counter is OriginalPosition-1,
            Counter_Check is DestinationPosition-1,
            (
                Counter == Counter_Check
            ->  ReturnBooleanValue = 'False', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Len, ReturnBooleanValue)
                ;   ReturnBooleanValue = 'True', !
                )
            )
        ;   Counter is OriginalPosition+1,
            Counter_Check is DestinationPosition+1,
            (
                Counter == Counter_Check
            ->  ReturnBooleanValue = 'False', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Len, ReturnBooleanValue)
                ;   ReturnBooleanValue = 'True', !
                )
            )
        )
    ).
    
checkPieceBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnBooleanValue):-
    list_length(RowOrColumnToIterate, Len),
    loopBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, Len, ReturnValue),
    (
        ReturnValue == 'True'
    ->  ReturnBooleanValue = 'True', !
    ;   ReturnBooleanValue = 'False', !
    ).

% ---------------------------------------------------------------

% Checks if the move is legal

checkLegalMove(Board, OriginColumn, OriginRow, DestinationColumn, DestinationRow, ReturnBooleanValue) :-
    checkHorizontalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow, RetHorizontal),
    (
        RetHorizontal == 'True'
    ->  (
            DestinationColumn > OriginColumn
        ->  CheckInFront = 'True'
        ;   CheckInFront = 'False' 
        ),
        getRow(Board, OriginRow, ReturningRow),
        checkPieceOnDestination(ReturningRow, DestinationColumn, RetDestination),
        (
            RetDestination == 'True'
        ->  ReturnBooleanValue = 'False', !
        ;   checkPieceBetween(ReturningRow, OriginColumn, DestinationColumn, CheckInFront, ReturnPB),
            (
                ReturnPB == 'False'
            ->  ReturnBooleanValue = 'True', !
            ;   ReturnBooleanValue = 'False', !
            )
        )
    ;   checkVerticalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow, RetVertical),
        (
            RetVertical == 'True'
        ->  (
                DestinationRow < OriginRow
            ->  CheckInFront = 'True'
            ;   CheckInFront = 'False'
            ),
            getColumn(Board, OriginColumn, ReturningColumn),
            checkPieceOnDestination(ReturningColumn, DestinationRow, RetDestination),
            (
                RetDestination == 'True'
            ->  ReturnBooleanValue = 'False', !
            ;   checkPieceBetween(ReturningColumn, OriginRow, DestinationRow, CheckInFront, ReturnPB),
                (
                    ReturnPB == 'True'
                ->  ReturnBooleanValue = 'False', !
                ;   ReturnBooleanValue = 'True', !
                )
            )
        ;   ReturnBooleanValue = 'False', !
        )
    ).

% ---------------------------------------------------------------

% Auxiliar functions used on the valid_moves(Board, ListOfValidMoves) function, in the end there is valid_moves(Board, ListOfValidMoves) function.

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
    
iterRowForPieces(Board, Row, RowNumber, ColumnPosition, TempList, ValidMovesList) :-
    (
        ColumnPosition == 12
    ->  copy(TempList, ValidMovesList), !
    ;   nth0(ColumnPosition, Row, Element), 
        (
            Element == clear
        ->  C_Test is ColumnPosition+1, 
            iterRowForPieces(Board, Row, RowNumber, C_Test, TempList, ValidMovesList)
        ;   checkValidMovesForPiece(Board, [RowNumber, ColumnPosition], MovesList),
            append(MovesList, TempList, TempList2),
            C_Test is ColumnPosition+1,
            iterRowForPieces(Board, Row, RowNumber, C_Test, TempList2, ValidMovesList)
        )
    ).

iterBoardFinal(Board, StartingRow, StartingColumn, AuxList, FinalList):-
    (
        StartingRow == 8
    ->  copy(AuxList, FinalList), !
    ;   getRow(Board, StartingRow, RetRow),
        iterRowForPieces(Board, RetRow, StartingRow, StartingColumn, [], ValidList),
        append(AuxList, ValidList, AuxList2),
        CurrentPosition is StartingRow+1,
        iterBoardFinal(Board, CurrentPosition, StartingColumn, AuxList2, FinalList)
    ).

valid_moves(Board, ListOfValidMoves) :-
    iterBoardFinal(Board, 0, 0, [], ListOfValidMoves).

% ---------------------------------------------------------------



check_captures(Board, NewBoard, WCapture, BCapture) :-
    check_horizontal_captures(Board, TempBoard, 0, HWCapture, HBCapture),
    check_vertical_captures(TempBoard, NewBoard, 0, VWCapture, VBCapture),
    % WCapture is VWCapture,
    % BCapture is (VBCapture + 1).
    WCapture is (HWCapture + VWCapture),
    %WCapture is WTemp,
    BCapture is (HBCapture + VBCapture).
    %BCapture is BTemp.



check_horizontal_captures(Board, NewBoard, 8, WCapture, BCapture).
check_horizontal_captures(Board, NewBoard, RowNumber, WCapture, BCapture) :-
    nth0(RowNumber, Board, ReturningRow),
    %write(ReturningRow),
    white_capture(Board, TempWBoard, RowNumber, ReturningRow, TempWCapture, 0),
    black_capture(Board, TempBBoard, RowNumber, ReturningRow, TempBCapture, 0),
    %black_capture(Board, NewBoard, RowNumber, ReturningRow, BCapture, 0, Position),
    NewRowNumber is RowNumber + 1,
    ( (TempWCapture == 0 , TempBCapture == 0)
        %no pieces captured in that iteration
        -> (NewRowNumber == 8
            %last iteration
            ->append(TempWBoard, [], NewBoard),
            WCapture = TempWCapture,
            BCapture = TempBCapture,
            %write(WCapture),nl,write(BCapture),nl,
            check_horizontal_captures(Board, TempWBoard, 8, WCapture, BCapture)
            %every other iteration
            ; check_horizontal_captures(Board, NewBoard, NewRowNumber, WCapture, BCapture)
        )
        %piece captured, force finish of function
        ;(TempWCapture == 1
            %white piece captured
            ->append(TempWBoard, [], NewBoard),
            WCapture = TempWCapture,
            BCapture = 0,
            check_horizontal_captures(Board, TempWBoard, 8, WCapture, BCapture),!
            %black piece captured
            ;append(TempBBoard, [], NewBoard),
            WCapture = 0,
            BCapture = TempBCapture,
            check_horizontal_captures(Board, TempBBoard, 8, WCapture, BCapture),!
        )
        
    ).
    %write('3\n'),

% white_capture(Board, NewBoard, _, _, _, 10, Position).
%     %Position = 99, !.
white_capture(Board, NewBoard, ListNumber, List, WCapture, CurrentPosition) :-
    Second is CurrentPosition + 1,
    Third is CurrentPosition + 2,
    %get the 3 elements
    nth0(CurrentPosition, List, Element1),
    nth0(Second, List, Element2),
    nth0(Third, List, Element3),

    ((Element1 == w, Element2 == b, Element3 == w)
        ->WCapture is 1,
        %write(List)
        replace(List, Second, clear, NewList),
        replace(Board, ListNumber, NewList, NewBoard),
        !,true

        %append(TestBoard, [], NewBoard),
        %write_board(NewBoard), halt
        

        ;NewPosition is CurrentPosition+1,
        (NewPosition \== 10 
            ->white_capture(Board, NewBoard, ListNumber, List, WCapture, NewPosition),!
            ;WCapture = 0,
            append(Board, [], NewBoard),!,true
        )
    ).


black_capture(Board, NewBoard, ListNumber, List, BCapture, CurrentPosition) :-
    Second is CurrentPosition + 1,
    Third is CurrentPosition + 2,
    %get the 3 elements
    nth0(CurrentPosition, List, Element1),
    nth0(Second, List, Element2),
    nth0(Third, List, Element3),

    ((Element1 == b, Element2 == w, Element3 == b)
        ->BCapture is 1,
        %write(List)
        replace(List, Second, clear, NewList),
        replace(Board, ListNumber, NewList, NewBoard),
        !,true

        %append(TestBoard, [], NewBoard),
        %write_board(NewBoard), halt
        

        ;NewPosition is CurrentPosition+1,
        (NewPosition \== 10 
            ->black_capture(Board, NewBoard, ListNumber, List, BCapture, NewPosition),!
            ;BCapture = 0,
            append(Board, [], NewBoard),!,true
        )
    ).



% lista inicial, indice, elemento, lista depois
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- 
    I > -1,
    NI is I-1,
    replace(T, NI, X, R), !.
replace(L, _, _, L).





check_vertical_captures(Board, NewBoard, 12, WCapture, BCapture).
check_vertical_captures(Board, NewBoard, ColumnNumber, WCapture, BCapture) :-
    getColumn(Board, ColumnNumber, ReturningColumn),
    %write(ReturningRow),
    white_capture_vertical(Board, TempWBoard, ColumnNumber, ReturningColumn, TempWCapture, 0),
    black_capture_vertical(Board, TempBBoard, ColumnNumber, ReturningColumn, TempBCapture, 0),
    %black_capture(Board, NewBoard, RowNumber, ReturningRow, BCapture, 0, Position),
    NewColumnNumber is ColumnNumber + 1,
    ( (TempWCapture == 0 , TempBCapture == 0)
        %no pieces captured in that iteration
        -> (NewColumnNumber == 12
            %last iteration
            ->append(TempWBoard, [], NewBoard),
            WCapture = TempWCapture,
            BCapture = TempBCapture,
            %write(WCapture),nl,write(BCapture),nl,
            check_vertical_captures(Board, TempWBoard, 12, WCapture, BCapture)
            %every other iteration
            ; check_vertical_captures(Board, NewBoard, NewColumnNumber, WCapture, BCapture)
        )
        %piece captured, force finish of function
        ;(TempWCapture == 1
            %white piece captured
            ->append(TempWBoard, [], NewBoard),
            WCapture = TempWCapture,
            BCapture = 0,
            check_vertical_captures(Board, TempWBoard, 12, WCapture, BCapture),!
            %black piece captured
            ;append(TempBBoard, [], NewBoard),
            WCapture = 0,
            BCapture = TempBCapture,
            check_vertical_captures(Board, TempBBoard, 12, WCapture, BCapture),!
        )
        
    ).


white_capture_vertical(Board, NewBoard, ListNumber, List, WCapture, CurrentPosition) :-
    Second is CurrentPosition + 1,
    Third is CurrentPosition + 2,
    %get the 3 elements
    nth0(CurrentPosition, List, Element1),
    nth0(Second, List, Element2),
    nth0(Third, List, Element3),

    ((Element1 == w, Element2 == b, Element3 == w)
        ->WCapture is 1,
        %write(List)
        %replace(List, Second, clear, NewList),
        %nth0(ListNumber, ReturningRow, NewList),
        nth0(Second, Board, ReturningRow),
        replace(ReturningRow, ListNumber, clear, NewList),
        replace(Board, Second, NewList, NewBoard),
        !,true

        %append(TestBoard, [], NewBoard),
        %write_board(NewBoard), halt
        

        ;NewPosition is CurrentPosition+1,
        (NewPosition \== 6 
            ->white_capture_vertical(Board, NewBoard, ListNumber, List, WCapture, NewPosition),!
            ;WCapture = 0,
            append(Board, [], NewBoard),!,true
        )
    ).


black_capture_vertical(Board, NewBoard, ListNumber, List, WCapture, CurrentPosition) :-
    Second is CurrentPosition + 1,
    Third is CurrentPosition + 2,
    %get the 3 elements
    nth0(CurrentPosition, List, Element1),
    nth0(Second, List, Element2),
    nth0(Third, List, Element3),

    ((Element1 == b, Element2 == w, Element3 == b)
        ->WCapture is 1,
        %write(List)
        %replace(List, Second, clear, NewList),
        nth0(Second, Board, ReturningRow),
        replace(ReturningRow, ListNumber, clear, NewList),
        replace(Board, Second, NewList, NewBoard),
        !,true

        %append(TestBoard, [], NewBoard),
        %write_board(NewBoard), halt
        

        ;NewPosition is CurrentPosition+1,
        (NewPosition \== 6 
            ->black_capture_vertical(Board, NewBoard, ListNumber, List, WCapture, NewPosition),!
            ;WCapture = 0,
            append(Board, [], NewBoard),!,true
        )
    ).
