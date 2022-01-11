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


