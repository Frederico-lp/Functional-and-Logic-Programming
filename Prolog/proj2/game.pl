:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').


%color to int
%player_index(b, 0).
%player_index(w, 1).

start_game(Level):- 
    starting_board(Board),
    game_loop(Board, w, 0, 0, Level).


% game_loop(_,_,1,_) :-
%     write("White player won!").
% game_loop(_,_,_,1) :-
%     write("Black player won!").
game_loop(Board, Player, WhiteWon, BlackWon, Level) :-
    (Player == w 
        %white player
        -> write_board(Board), get_move(Board, NewBoard), game_loop(NewBoard, b, 0 ,0, Level)
        %black player(AI)
        ; write_board(Board), ai_play(Board, NewBoard), game_loop(NewBoard, w, 0 ,0, Level)).

    
