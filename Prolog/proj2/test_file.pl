:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').
:- consult('ruleset.pl').

/*
para verificar se o movimento é legal:
    - verificar tipo de movimento
    - se n for ilegal
        - pegar coluna/fila correspondente ao movimento
        - verificar se há peça no destino
        - verificar se há peças entre a origem e o destino
        - se sim
            - movimento n é legal, retorna ilegal move
        - mover
    - se for ilegal retorna ilegal move
*/

/*
checkLegalMove(_, OriginColumn, OriginRow, DestinationColumn, DestinationRow, ReturnBooleanValue) :-
    starting_board(Board),
    (
        checkHorizontalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow)

    ->  getRow(Board, OriginRow, ReturningRow),
        (
            checkPieceOnDestination(ReturningRow, DestinationColumn)

        ->  ReturnBooleanValue = 'False', !, false, fail

        ;   %check between
        )

    ;   (
            checkVerticalMove(OriginColumn, OriginRow, DestinationColumn, DestinationRow)

        ->  getColumn(Board, OriginColumn, FinalColumn),
            (
                checkPieceOnDestination(FinalColumn, DestinationRow)

            ->  ReturnBooleanValue = 'False', !, false, fail

            ; %check between
            )

        ;   ReturnBooleanValue = 'False', !, false, fail
        )
    ).
*/

/*
checkPieceBetween(_, RowOrColumn, OriginalPosition, DestinationPosition) :-
    % RC vai ser uma lista do tipo [b,clear,clear,...,w]
*/

