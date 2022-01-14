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
        ->  Counter = OriginalPosition+1,
            (
                Counter == DestinationPosition+1 
            ->  ReturnBooleanValue = 'True', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
                ;   ReturnBooleanValue = 'False', !
                )
            )
        ;   Counter = OriginalPosition-1,
            (
                Counter == DestinationPosition-1
            ->  ReturnBooleanValue = 'True', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
                ;   ReturnBooleanValue = 'False', !
                )
            )
        )
    ;   (
            CheckInFront == 'True'
        ->  Counter = OriginalPosition-1,
            (
                Counter == DestinationPosition-1
            ->  ReturnBooleanValue = 'True', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
                ;   ReturnBooleanValue = 'False', !
                )
            )
        ;   Counter = OriginalPosition+1,
            (
                Counter == DestinationPosition+1
            ->  ReturnBooleanValue = 'True', !
            ;   nth0(Counter, RowOrColumnToIterate, Element),
                (
                    Element == clear
                ->  loopBetween(RowOrColumnToIterate, Counter, DestinationPosition, CheckInFront, Ret)
                ;   ReturnBooleanValue = 'False', !
                )
            )
        )
    ).
    
checkPieceBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnBooleanValue):-
    loopBetween(RowOrColumnToIterate, OriginalPosition, DestinationPosition, CheckInFront, ReturnValue),
    (
        ReturnValue = 'True'
    ->  ReturnBooleanValue = 'True', !
    ;   ReturnBooleanValue = 'False', !
    ).
