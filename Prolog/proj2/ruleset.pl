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

checkInputRow(IsValid):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7])
    -> IsValid = 'True', !, true
    ; write('Invalid Row\n'), IsValid = 'False', fail
    ).

% ---------------------------------------------------------------

% Working

checkInputColumn(IsValid):-
    repeat,
    read(Number),
    (
       memberchk(Number,[0,1,2,3,4,5,6,7,8,9,10,11])
    -> IsValid = 'True', !, true
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

loop(Board, Rows, ColumnNumber, EL, ReturningColumn, FinalColumn) :- 
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
    loop(Board, 0, ColumnNumber, [], ReturningColumn, FinalColumn).

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
