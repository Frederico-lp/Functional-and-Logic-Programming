get_move(Board, NewBoard) :-
    write('Your turn to play'),
    write('Choose a piece to move \n'),
    write('Column \n'),
    read(Column),
    write('Row'),
    read(Row),
    write('Choose where to move it \n'),
    write('Column \n'),
    read(FinalColumn),
    write('Row'),
    read(FinalRow),
    %check for valid move
    move(Board, Column, Row, FinalColumn, FinalRow, Board).


move(Board, Column, Row, FinalColumn, FinalRow, NewBoard) :-
    % escolher linha
    % nth0(?Index, ?List, ?Elem)
    nth0(Input, Board, Row),
    nth0(Input, Row, Element),

    % n sei fazer o resto para ja

% nth0 (indice, lista, valor)


% lista inicial, indice, elemento, lista depois
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- 
    I > -1,
    NI is I-1,
    replace(T, NI, X, R), !.
replace(L, _, _, L).
