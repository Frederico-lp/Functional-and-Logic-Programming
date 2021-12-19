:- consult('board.pl').
:- consult('moves.pl').

start_game() :-
    starting_board(board),
    game_loop(board, 'w').


game_loop(_,_,1,_) :-
    write("White player won!").
game_loop(_,_,_,1) :-
    write("Black player won!").
game_loop(board, player, whiteWon, BlackWon) :-
% display board
    get move(),
    (Player = 'b' -> game_loop(newBoard, player, 0 ,0);
    Player = 'w' -> game_loop(newBoard, player, 0,0)).
