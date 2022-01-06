:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').


%color to int
player_index(b, 0).
player_index(w, 1).

start_game(_):- 
    starting_board(Board),
    game_loop(Board, 'w', 0, 0).


% game_loop(_,_,1,_) :-
%     write("White player won!").
% game_loop(_,_,_,1) :-
%     write("Black player won!").
game_loop(Board, Player, WhiteWon, BlackWon) :-
    write_board(Board),
    get_move(Board, NewBoard),
    write_board(NewBoard),  %so para teste
    (Player = b -> game_loop(NewBoard, Player, 0 ,0);
    Player = w -> game_loop(NewBoard, Player, 0,0)).
% display Board
