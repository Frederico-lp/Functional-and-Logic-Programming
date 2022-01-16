:- use_module(library(random)).
:- consult('display.pl').

% Working 
% PlayerOne is 1 and PlayerTwo is 3 (because the upperbound is not included in the interval)

choosePlayer(PlayerOne, PlayerTwo, FirstToPlay) :-
    random(PlayerOne, PlayerTwo, FirstToPlay).

% ---------------------------------------------------------------

% Working

changeTurn(CurrentPlayer, NextPlayer) :- 
    (
    CurrentPlayer =:= 1 
    -> NextPlayer = 2
    ; NextPlayer = 1
    ).
    
% ---------------------------------------------------------------

% Working

checkHorizontalMove(Column, Row, FinalColumn, FinalRow, ReturnBooleanValue) :-
    (
        Column \= FinalColumn
    ->  (
            Row =:= FinalRow
        -> ReturnBooleanValue = 'True'
        ; ReturnBooleanValue = 'False'
        )
    ;   ReturnBooleanValue = 'False'
    ).

% ---------------------------------------------------------------

% Working

checkVerticalMove(Column, Row, FinalColumn, FinalRow, ReturnBooleanValue) :-
    (
        Row \= FinalRow
    ->  (
            Column =:= FinalColumn
        -> ReturnBooleanValue = 'True'
        ; ReturnBooleanValue = 'False'
        )
    ;   ReturnBooleanValue = 'False'
    ).

% ---------------------------------------------------------------

% Working

checkInputRow(IsValid, Row):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7])
    -> IsValid = 'True', Row = Number, !, true
    ; write('Invalid Row\n'), IsValid = 'False'
    ).

% ---------------------------------------------------------------

% Working

checkInputColumn(IsValid, Column):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7,8,9,10,11])
    -> IsValid = 'True',Column = Number, !, true
    ; write('Invalid Column'), nl, IsValid = 'False'
    ).

% ---------------------------------------------------------------

% Working

getRow(Board, RowNumber, ReturningRow) :-
    nth0(RowNumber, Board, ReturningRow).

% ---------------------------------------------------------------

% Working

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

% Working 

checkPieceOnDestination(RowOrColumn, Destination, ReturnBooleanValue) :-
    nth0(Destination, RowOrColumn, Piece),
    (
        Piece == clear

    ->  ReturnBooleanValue = 'False', !

    ; ReturnBooleanValue = 'True', ! 
    ).
    
% ---------------------------------------------------------------

% Working

list_length(Xs, L) :- list_length(Xs, 0, L).
list_length([], L, L).
list_length([_|Xs], T, L) :-
  T1 is T+1,
  list_length(Xs, T1, L).

loopBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnValue) :-
    list_length(RowOrColumnToIterate, Len),
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
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
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
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
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
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
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
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
                ;   ReturnBooleanValue = 'True', !
                )
            )
        )
    ).
    
checkPieceBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnBooleanValue):-
    loopBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnValue),
    (
        ReturnValue = 'False'
    ->  ReturnBooleanValue = 'False', !
    ;   ReturnBooleanValue = 'True', !
    ).

% ---------------------------------------------------------------

% Working

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
                    ReturnPB == 'False'
                ->  ReturnBooleanValue = 'True', !
                ;   ReturnBooleanValue = 'False', !
                )
            )
        ;   ReturnBooleanValue = 'False', !
        )
    ).

% ---------------------------------------------------------------

% consult('/Users/pjpacheco/Desktop/FEUP/3Ano/PFL/project/PFL/Prolog/proj2/game.pl'). %cccv



check_captures(Board, NewBoard, WCapture) :-
    check_horizontal_captures(Board, NewBoard, 0, WCapture).
    %check_vertical_captures(Board, 0, BCapture, WCapture).


check_horizontal_captures(Board, NewBoard, 8, WCapture).
check_horizontal_captures(Board, NewBoard, RowNumber, WCapture) :-
    nth0(RowNumber, Board, ReturningRow),
    %write(ReturningRow),
    white_capture(Board, TempBoard, RowNumber, ReturningRow, TempWCapture, 0),
    %black_capture(Board, NewBoard, RowNumber, ReturningRow, BCapture, 0, Position),
    NewRowNumber is RowNumber + 1,
    (TempWCapture == 0
        %no pieces captured in that iteration
        -> (NewRowNumber == 8
            %last iteration
            ->append(TempBoard, [], NewBoard),
            WCapture = TempWCapture,
            check_horizontal_captures(Board, TempBoard, 8, WCapture)
            %every other iteration
            ; check_horizontal_captures(Board, NewBoard, NewRowNumber, WCapture)
        )
        %piece captured, force finish of function
        ;append(TempBoard, [], NewBoard),
        WCapture = TempWCapture,
        check_horizontal_captures(Board, TempBoard, 8, WCapture),!
        
    ).
    %write('3\n'),



check_vertical_captures(Board, Column, BCapture, WCapture) :-
    getColumn(Board, Column, FinalColumn).


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

    ((Element1 == w, Element2 == b, Element3 == w)
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
            ;WCapture = 0,
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

