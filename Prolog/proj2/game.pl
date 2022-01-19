:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').
:- use_module(library(system)).


%color to int
%player_index(b, 0).
%player_index(w, 1).

start_game(Level):- 
    starting_board(Board),
    game_loop(Board, w, 0, 0, Level).


game_loop(Board,_,2,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop(Board,_,_,2,_) :-
    write('Black player won!').
game_loop(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == w 

        %white player
        -> write_board(Board), 
        get_move(Board, NewBoard, w),!,
        %write_board(NewBoard),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        game_loop(CapturedBoard, b, NewWCapture , NewBCapture, Level)

        %black player(AI)
        ; write_board(Board), 
        ai_play(Board, NewBoard, b),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        game_loop(NewBoard, w, NewWCapture , NewBCapture, Level)
    ).



start_game_2(Level):- 
    starting_board(Board),
    game_loop2(Board, w, 0, 0, Level).

game_loop2(Board,_,2,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop2(Board,_,_,2,_) :-
    write('Black player won!').
game_loop2(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == w 

        %white player
        -> write_board(Board), 
        get_move(Board, NewBoard, w),!,
        %write_board(NewBoard),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        game_loop2(CapturedBoard, b, NewWCapture , NewBCapture, Level)

        %black player
        ; write_board(Board), 
        get_move(Board, NewBoard, b),!,
        %write_board(NewBoard),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        game_loop2(CapturedBoard, w, NewWCapture , NewBCapture, Level)
    ).


start_game_3(Level):- 
    starting_board(Board),
    game_loop3(Board, w, 0, 0, Level).

game_loop3(Board,_,2,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop3(Board,_,_,2,_) :-
    write('Black player won!').
game_loop3(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == w 

        %white player(AI)
        -> write_board(Board), 
        ai_play(Board, NewBoard, w),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        sleep(1),
        game_loop3(NewBoard, b, NewWCapture , NewBCapture, Level)

        %black player(AI)
        ; write_board(Board), 
        ai_play(Board, NewBoard, b),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        sleep(1),
        game_loop3(NewBoard, w, NewWCapture , NewBCapture, Level)
    ).



start_game_4(Level):- 
    starting_board(Board),
    game_loop4(Board, w, 0, 0, Level).


game_loop4(Board,_,2,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop4(Board,_,_,2,_) :-
    write('Black player won!').
game_loop4(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == b 

        %black player
        -> write_board(Board), 
        get_move(Board, NewBoard, b),!,
        %write_board(NewBoard),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        game_loop4(CapturedBoard, w, NewWCapture , NewBCapture, Level)

        %white player(AI)
        ; write_board(Board), 
        ai_play(Board, NewBoard, w),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        %nl, nl, write(NewWCapture), nl,nl,
        nl,nl,nl,
        game_loop4(NewBoard, b, NewWCapture , NewBCapture, Level)
    ).



    
