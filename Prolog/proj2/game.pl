:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').


%color to int
%player_index(b, 0).
%player_index(w, 1).

start_game(Level):- 
    starting_board(Board),
    game_loop(Board, w, 0, 0, Level).


game_loop(Board,_,1,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop(Board,_,_,1,_) :-
    write('Black player won!').
game_loop(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == w 

        %white player
        -> write_board(Board), 
        get_move(Board, NewBoard),!,
        write_board(NewBoard),!,
        check_captures(NewBoard,CapturedBoard, WCapture),
        write(WCapture),nl,
        % NewWCapture is WCapture + WhiteCaptures,
        % NewBCapture is BCapture + BlackCaptures,
        game_loop(CapturedBoard, b, WCapture , 0, Level)

        %black player(AI)
        ; write_board(Board), 
        ai_play(Board, NewBoard),
        %check_captures(Board, WCapture, BCapture),
        % NewWCapture is WCapture + WhiteCaptures,
        % NewBCapture is BCapture + BlackCaptures,
        game_loop(NewBoard, w, 0 , 0, Level)
    ).

    
