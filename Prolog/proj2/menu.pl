:- consult('game.pl').

print_menu :-
    print('================================================'), nl,
    print('|                   PETTEIA                    |'), nl,
    print('================================================'), nl,
    print('                                                '), nl,
    print('                  1 - Start                     '), nl,
    print('                  2 - How to play               '), nl,
    print('                  3 - Exit                      '), nl,
    print('                                                '), nl,
    print('================================================'), nl.


menu_options(3).
menu_options(1):- enemy_menu.
menu_options(2):- print_htp_menu.



print_game_menu:-
    nl,
    print('================================================'), nl,
    print('|                    GAME                      |'), nl,
    print('================================================'), nl,
    print('                                                '), nl,
    print('                1 - Player vs AI                '), nl,
    print('                2 - Player vs Player            '), nl,
    print('                3 - AI vs AI                    '), nl,
    print('                4 - AI vs Player                '), nl,
    print('                5 - Back                        '), nl,
    print('                                                '), nl,
    print('================================================'), nl.

enemy_options(5) :- play.
enemy_options(1) :- start_game(1).
enemy_options(2) :- start_game_2(1).
enemy_options(3) :- start_game_3(1).
enemy_options(4) :- start_game_4(1).

print_ai_menu:-
    nl,
    print('================================================'), nl,
    print('|                  AI Level                    |'), nl,
    print('================================================'), nl,
    print('                                                '), nl,
    print('                1 - Level 1                     '), nl,
    print('                2 - Level 2                     '), nl,
    print('                3 - Exit                        '), nl,
    print('                                                '), nl,
    print('================================================'), nl.

ai_options(3).
ai_options(1) :- start_game(1).
ai_options(2) :- start_game(2).

print_htp_menu:-
    nl,
    print('================================================'), nl,
    print('|                How to Play                   |'), nl,
    print('================================================'), nl,
    print('                                                '), nl,
    print(' You play as white (w);                         '), nl,
    print('                                                '), nl,
    print(' Pick your piece by choosing the column and the '), nl,
    print(' row its at                                     '), nl,
    print('                                                '), nl,
    print(' Pick the place you wish to put your piece by   '), nl,
    print(' selecting its column and row                   '), nl,
    print('                                                '), nl,
    print(' Pieces can not "jump" above other pieces       '), nl,
    print('                                                '), nl,
    print(' Capture a piece by trapping it between two of  '), nl,
    print(' of your pieces                                 '), nl,
    print('                                                '), nl,
    print(' Pieces ONLY move horizontally or vertically'    ), nl,
    print('                                                '), nl,
    print(' Win by capturing 7 pieces                      '), nl,
    print('                                                '), nl,
    print(' If no legal moves exists, player with most     '), nl,
    print(' captured pieces win                            '), nl,
    print('                                                '), nl,
    print('================================================'), nl,
    print_menu,
    read(Input),
    menu_options(Input).


play :-
    print_menu,
    read(Input),
    menu_options(Input).

ai_menu :-
    print_ai_menu,
    read(Input),
    ai_options(Input).

enemy_menu :-
    print_game_menu,
    read(Input),
    enemy_options(Input).