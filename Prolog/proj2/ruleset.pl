:- use_module(library(random)).

:- consult('board.pl').
:- consult('moves.pl').
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

    ->  ReturnBooleanValue = 'True', !

    ; ReturnBooleanValue = 'False', ! 
    ).
    
% ---------------------------------------------------------------

% Working

% If CheckInFront equals true it will check positions in front, otherwhise will check positions behind

loopBetween(ListToIterate, StartingPos, DestinationPosition, CheckInFront, Ret) :-
    Counter is StartingPos,
    (
        CheckInFront == 'True'                                                                      % se for posicao acima

    ->  (
            Counter == DestinationPosition                                               % verifica se está na posicao de destino
            
        ->  checkPieceOnDestination(ListToIterate, DestinationPosition, ReturnBooleanValue),
            (
                ReturnBooleanValue == 'True'
            ->  RetInside = 'False', !
            ;   RetInside = 'True', !
            )

        ;   Counter_Two is StartingPos+1,                                                      % incrementar a posicao por um - verificar se se pode redifinir Counter
            nth0(Counter_Two, ListToIterate, RetElem),                                           % vai buscar o elemento do contador 
            (
                RetElem == clear
            ->  RetInside = 'True', !
            ;   RetInside = 'False', !
            ),
            loopBetween(ListToIterate, Counter_Two, DestinationPosition, CheckInFront, RetInside)
        )

    ;   (
            Counter == DestinationPosition
            
        ->  checkPieceOnDestination(ListToIterate, DestinationPosition, ReturnBooleanValue),
            (
                ReturnBooleanValue == 'True'
            ->  RetInside = 'False', !
            ;   RetInside = 'True', !
            )
        ;   Counter_Two is StartingPos-1,
            nth0(Counter_Two, ListToIterate, RetElem),                                           % vai buscar o elemento do contador 
            (
                RetElem == clear
            ->  RetInside = 'True', !
            ;   RetInside = 'False', !
            ),
            loopBetween(ListToIterate, Counter_Two, DestinationPosition, CheckInFront, RetInside)
        )
    ).

checkPieceBetween(ListToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnBooleanValue) :-
    loopBetween(ListToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnValue),
    (
        ReturnValue = 'True'
    ->  ReturnBooleanValue = 'True', !
    ; ReturnBooleanValue = 'False', !
    ).

% ---------------------------------------------------------------

% Working

checkLegalMove(_, OriginColumn, OriginRow, DestinationColumn, DestinationRow, ReturnBooleanValue) :-
    starting_board(Board),
    checkHorizontalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow, RetHorizontal),
    (
        RetHorizontal == 'True'
    ->  (
            DestinationColumn > OriginColumn
        ->  CheckInFront = 'True'
        ;   CheckInFront = 'False'
        ),
        getRow(Board, OriginRow, ReturningRow),
        checkPieceOnDestination(ReturningRow, DestinationColumn, RetDestinaton),
        (
            RetDestinaton == 'True'

        ->  ReturnBooleanValue = 'False', !

        ;   checkPieceBetween(ReturningRow, OriginRow, DestinationColumn, CheckInFront, ReturnPB),
            (
                ReturnPB == 'True'
            ->  ReturnBooleanValue = 'True', !
            ;   ReturnBooleanValue = 'False', !
            )
        )

    ;   checkVerticalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow, RetVertical),
    
        (
            RetVertical == 'True'

        ->  (
                DestinationRow > OriginRow
            ->  CheckInFront = 'True'
            ;   CheckInFront = 'False'
            ),
            getColumn(Board, OriginColumn, ReturningColumn),
            checkPieceOnDestination(ReturningColumn, DestinationRow, RetDestinaton),
            (
                RetDestinaton == 'True'
            ->  ReturnBooleanValue = 'False', !

            ;   checkPieceBetween(ReturningColumn, OriginColumn, DestinationRow, CheckInFront, ReturnPB),
                (
                    ReturnPB == 'True'
                ->  ReturnBooleanValue = 'True', !
                ;   ReturnBooleanValue = 'False', !
                )
            )

        ;   ReturnBooleanValue = 'False', !
        )
    ).

% consult('/Users/pjpacheco/Desktop/FEUP/3Ano/PFL/project/PFL/Prolog/proj2/ruleset.pl'). %cccv
% checkLegalMove(X, 0,0, 0,7,R).


% ---------------------------------------------------------------

/*

check_captures(Board, BCapture, WCapture) :-
    check_horizontal_captures(Board, 0, BCapture, WCapture),
    check_vertical_captures(Board, 0, BCapture, WCapture).


check_horizontal_captures(Board, RowNumber, BCapture, WCapture) :-
    getRow(Board, RowNumber, ReturningRow),
    white_capture(Board, NewBoard, RowNumber, ReturningRow, WCapture, 0, Position),
    black_capture(Board, NewBoard, RowNumber, ReturningRow, BCapture, 0, Position).



check_vertical_captures(Board, Column, BCapture, WCapture) :-
    getColumn(Board, Column, FinalColumn).


white_capture(Board, NewBoard, ListNumber, List, WCapture, CurrentPosition, Position) :-
    Second is CurrentPosition + 1,
    Third is CurrentPosition + 2,
    %get the 3 elements
    nth0(CurrentPosition, List, Element1),
    nth0(Second, List, Element2),
    nth0(Third, List, Element3),
    (Element1 == w 
        %w
        ->(Element2 == b
            %wb
            ->(Element3 == w
                %wbw
                -> NewWCapture is WCapture + 1, 
                Position = CurrentPosition,
                replace(List, Second, clear, NewList),
                replace(Board, ListNumber, NewList, NewBoard).

            )
        );
        NewPosition is CurrentPosition + 1,
        white_capture(Board, NewBoard, ListNumber, List, WCapture, CurrentPosition, Position)


    ).


black_capture(Board, NewBoard, ListNumber, List, WCapture, CurrentPosition, Position) :-
    Second is Position + 1,
    Third is Position + 2,
    %get the 3 elements
    nth0(Position, List, Element1),
    nth0(Second, List, Element2),
    nth0(Third, List, Element3),
    (Element1 == b 
        %b
        ->(Element2 == w
            %bw
            ->(Element3 == b
                %bwb
                -> NewWCapture is WCapture + 1, 
                replace(List, Second, clear, NewList),
                replace(Board, ListNumber, NewList, NewBoard).

            ),
        );
        NewPosition is CurrentPosition + 1,
        white_capture(Board, NewBoard, ListNumber, List, WCapture, CurrentPosition, Position)


    ).



% lista inicial, indice, elemento, lista depois
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- 
    I > -1,
    NI is I-1,
    replace(T, NI, X, R), !.
replace(L, _, _, L).


*/