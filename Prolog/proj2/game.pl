:- consult('board.pl').
:- consult('moves.pl').
:- consult('display.pl').
:- use_module(library(system)).


start_game(Level):- 
    starting_board(Board),
    game_loop(Board, w, 0, 0, Level).


game_loop(Board,_,7,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop(Board,_,_,7,_) :-
    write_board(Board),
    write('Black player won!').
game_loop(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == w 

        %white player
        ->write('white player s turn\n'), nl,
        write_board(Board), 
        get_move(Board, NewBoard, w),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        game_loop(CapturedBoard, b, NewWCapture , NewBCapture, Level)

        %black player(AI)
        ;write('black player s turn\n'),  nl,
        write_board(Board), 
        ai_play(Board, NewBoard, b),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        game_loop(NewBoard, w, NewWCapture , NewBCapture, Level)
    ).



start_game_2(Level):- 
    starting_board(Board),
    game_loop2(Board, w, 0, 0, Level).

game_loop2(Board,_,7,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop2(Board,_,_,7,_) :-
    write_board(Board),
    write('Black player won!').
game_loop2(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == w 

        %white player
        ->write('white player s turn\n'), nl,
        write_board(Board), 
        get_move(Board, NewBoard, w),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        game_loop2(CapturedBoard, b, NewWCapture , NewBCapture, Level)

        %black player
        ; write('black player s turn\n'), nl, 
        write_board(Board), 
        get_move(Board, NewBoard, b),!,
        %write_board(NewBoard),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        game_loop2(CapturedBoard, w, NewWCapture , NewBCapture, Level)
    ).


start_game_3(Level):- 
    starting_board(Board),
    game_loop3(Board, w, 0, 0, Level).

game_loop3(Board,_,7,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop3(Board,_,_,7,_) :-
    write_board(Board),
    write('Black player won!').
game_loop3(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == w 

        %white player(AI)
        -> write('white player s turn\n'), nl, 
        write_board(Board), 
        ai_play(Board, NewBoard, w),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        sleep(1),
        game_loop3(NewBoard, b, NewWCapture , NewBCapture, Level)

        %black player(AI)
        ; write('black player s turn\n'), nl, 
        write_board(Board), 
        ai_play(Board, NewBoard, b),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        sleep(1),
        game_loop3(NewBoard, w, NewWCapture , NewBCapture, Level)
    ).



start_game_4(Level):- 
    starting_board(Board),
    game_loop4(Board, w, 0, 0, Level).


game_loop4(Board,_,7,_,_) :-
    write_board(Board),
    write('White player won!').
game_loop4(Board,_,_,7,_) :-
    write('Black player won!').
game_loop4(Board, Player, WhiteCaptures, BlackCaptures, Level) :-
    ( Player == b 

        %black player
        -> write('black player s turn\n'), nl, 
        write_board(Board), 
        get_move(Board, NewBoard, b),!,
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        game_loop4(CapturedBoard, w, NewWCapture , NewBCapture, Level)

        %white player(AI)
        ; write('white player s turn\n'), nl, 
        write_board(Board), 
        ai_play(Board, NewBoard, w),
        check_captures(NewBoard,CapturedBoard, WCapture, BCapture),
        NewWCapture is WCapture + WhiteCaptures,
        NewBCapture is BCapture + BlackCaptures,
        nl,nl,nl,
        game_loop4(NewBoard, b, NewWCapture , NewBCapture, Level)
    ).



    
