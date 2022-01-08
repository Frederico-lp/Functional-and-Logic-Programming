:- use_module(library(random)).

% Working - PlayerOne is 1 and PlayerTwo is 3 (because the upperbound is not included in the interval)

choosePlayer(PlayerOne, PlayerTwo, FirstToPlay) :-
    random(PlayerOne, PlayerTwo, FirstToPlay).

% ---------------------------------------------------------------

% Working
changeTurn(CurrentPlayer, NextPlayer) :- 
    (
    CurrentPlayer =:= 1 
    -> NextPlayer = 2
    ; NextPlayer = 1
    ).
    
% ( condition -> then_clause ; else_clause )

% ---------------------------------------------------------------
