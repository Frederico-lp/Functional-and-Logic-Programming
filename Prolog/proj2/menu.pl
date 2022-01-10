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
menu_options(1):- ai_menu.
menu_options(2):- write('to do').


/*
print_game_menu:-
    nl,
    print('================================================'), nl,
    print('|                    GAME                      |'), nl,
    print('================================================'), nl,
    print('                                                '), nl,
    print('                1 - Player vs Player            '), nl,
    print('                2 - Player vs AI                '), nl,
    print('                4 - Back                        '), nl,
    print('                                                '), nl,
    print('================================================'), nl.
*/

print_ai_menu:-
    nl,
    print('================================================'), nl,
    print('|                    GAME                      |'), nl,
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


start :-
    print_menu,
    read(Input),
    menu_options(Input).

ai_menu :-
    print_ai_menu,
    read(Input),
    ai_options(Input).
