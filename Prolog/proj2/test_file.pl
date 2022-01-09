:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').

/*
checkLegalMove(X):-
    starting_board(Board),
    nth0(Board, finalRow, returnedRow),
nth0(returnedRow, finalColumn, returnElement),
e agr testas o returnElement
*/

% Working

loop(Board, Rows, ColumnNumber, EL, ReturningColumn) :- 
           % Rows = 0,
           % Column = [],
           nth0(Rows, Board, ReturningRow), % [a,b,c,d]
           write('Row: '), write(ReturningRow),
           nl,
           nth0(ColumnNumber, ReturningRow, ReturnColumnElement),
           write('Column Element: '), write(ReturnColumnElement),
           nl,
           append(EL, [ReturnColumnElement], Column),
           write('Appended Elements List: '), write(Column),
           nl,
           % Aqui copia Column para EL, sendo EL a lista de todos os elementos percorridos da coluna até agora.
           nl,
           S is Rows+1, 
           (
               S =:= 8
            -> !, fail
            ;  loop(Board, S, ColumnNumber, EL)
           ).

getColumn(_, ColumnNumber, ReturningColumn) :-
    starting_board(Board),
    loop(Board, 0, ColumnNumber, [], ReturningColumn).