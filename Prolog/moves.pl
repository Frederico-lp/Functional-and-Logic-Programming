get_move(board) :-
    write("Your turn to play"),
    write("Choose a piece to move: ")
    read(piece),
    write("Choose where to move it"),
    read(location),
    %check for valid move
    move(input, location, board).

move(board, input, location, newBoard) :-
    %escolher linha
    nth0(input, board, Row),
    nth0(input, Row, Element),

    %n sei fazer o resto para ja

%nth0 (indice, lista, valor)


% lista inicial, indice, elemento, lista depois
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- 
    I > -1,
    NI is I-1,
    replace(T, NI, X, R), !.
replace(L, _, _, L).
