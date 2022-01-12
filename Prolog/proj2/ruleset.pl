:- use_module(library(random)).

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
    ; write('Invalid Row\n'), IsValid = 'False', fail
    ).

% ---------------------------------------------------------------

% Working

checkInputColumn(IsValid, Column):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7,8,9,10,11])
    -> IsValid = 'True',Column = Number, !, true
    ; write('Invalid Column'), nl, IsValid = 'False', fail
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
            ;  loop(Board, S, ColumnNumber, Column, C_Test, FinalColumn)
           ).

getColumn(Board, ColumnNumber, FinalColumn) :-
    loopRows(Board, 0, ColumnNumber, [], ReturningColumn, FinalColumn).

% ---------------------------------------------------------------

% Working 

checkPieceOnDestination(RowOrColumn, Destination, ReturnBooleanValue) :-
    nth0(Destination, RowOrColumn, Piece),
    (
        Piece == clear

    ->  ReturnBooleanValue = 'True', !, true

    ; ReturnBooleanValue = 'False', !, false, fail
    ).
    
% ---------------------------------------------------------------

% NEEDS TESTING 

% If CheckInFront equals true it will check positions in front, otherwhise will check positions behind

loopBetween(ListToIterate, StartingPos, DestPosition, CheckInFront, Ret) :-
    Counter is StartingPos,
    (
        Front_Back                                                                      % se for posicao acima

    ->  (
            Counter == DestinationPosition                                               % verifica se está na posicao de destino
            
        ->  (
                checkPieceOnDestination(ListToIterate, DestinationPosition, ReturnBooleanValue)
            ->  Ret = 'False', !, false, fail
            ;   Ret = 'True', !, true
            )

        ;   Counter is StartingPos+1,                                                      % incrementar a posicao por um - verificar se se pode redifinir Counter
            nth0(Counter, ListToIterate, RetElem),                                           % vai buscar o elemento do contador 
            (
                RetElem == clear
            ->  Ret = 'True'
            ;   Ret = 'False', !, false, fail
            ),
            loopBetween(ListToIterate, Counter, DestinationPosition, CheckInFront, Ret)
        )

    ;   (
            Counter == DestinationPosition
            
        ->  (
                checkPieceOnDestination(ListToIterate, DestinationPosition, ReturnBooleanValue)
            ->  Ret = 'False', !, false, fail
            ;   Ret = 'True', !, true
            )
        ;   Counter is StartingPos-1,
            nth0(Counter, ListToIterate, RetElem),                                           % vai buscar o elemento do contador 
            (
                RetElem == clear
            ->  Ret = 'True'
            ;   Ret = 'False', !, false, fail
            ),
            loopBetween(ListToIterate, Counter, DestinationPosition, CheckInFront, Ret)
        )
    ).

checkPieceBetween(ListToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnBooleanValue) :-
    loopBetween(ListToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnValue),
    (
        ReturnValue = 'True' % n há peças entre
    ->  ReturnBooleanValue = 'True', !, true
    ; ReturnBooleanValue = 'False', !, false, fail
    ).

% ---------------------------------------------------------------

% NEEDS TESTING

checkLegalMove(Board, OriginColumn, OriginRow, DestinationColumn, DestinationRow, ReturnBooleanValue) :-
    (
        checkHorizontalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow, RetHorizontal)

    ->  (
            DestinationRow > OriginRow
        ->  CheckInFront = true
        ;   CheckInFront = false
        ),
        getRow(Board, OriginRow, ReturningRow),
        (
            checkPieceOnDestination(ReturningRow, DestinationColumn)

        ->  ReturnBooleanValue = 'False', !, false, fail

        ;   (
                checkPieceBetween(ReturningRow, OriginRow, DestinationColumn, CheckInFront, ReturnBooleanValue)
            ->  ReturnBooleanValue = 'True', !, true
            ;   ReturnBooleanValue = 'False', !, false, fail
            )
        )

    ;   (
            checkVerticalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow)

        ->  (
                DestinationColumn > OriginColumn
            ->  CheckInFront = true
            ;   CheckInFront = false
            ),
            getColumn(Board, OriginColumn, FinalColumn),
            (
                checkPieceOnDestination(FinalColumn, DestinationRow)

            ->  ReturnBooleanValue = 'False', !, false, fail

            ;   (
                    checkPieceBetween(ReturningRow, OriginColumn, DestinationRow, CheckInFront, ReturnBooleanValue)
                ->  ReturnBooleanValue = 'True', !, true
                ;   ReturnBooleanValue = 'False', !, false, fail
                )
            )

        ;   ReturnBooleanValue = 'False', !, false, fail
        )
    ).