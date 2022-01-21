write_char(clear) :- write('  ').

write_char(w) :- write('W ').
write_char(b) :- write('B ').
write_char(wk) :- write('WK').
write_char(bk) :- write('BK').
write_char(empty) :- write('NN').
write_char(vazio) :- write('00').

% Top Number Row (Numbers correspond to the correspondent ASCII decimal value)
write_char(48) :- write('0 ').
write_char(49) :- write('1 ').
write_char(50) :- write('2 ').
write_char(51) :- write('3 ').
write_char(52) :- write('4 ').
write_char(53) :- write('5 ').
write_char(54) :- write('6 ').
write_char(55) :- write('7 ').
write_char(56) :- write('8 ').
write_char(57) :- write('9 ').
write_char(58) :- write('10').
write_char(59) :- write('11').
write_char(60) :- write('12').

index_line([clear,48,49,50,51,52,53,54,55,56,57,58,59]).

% ---------------------------------------------------------------

write_line([], _).
write_line([Head|Tail], 0) :-
    write_char(Head),
    write('| '),
    write_line(Tail, 0).
write_line(Line, Id) :-
    NumberId is Id + 47,
    write_char(NumberId),
    write('| '),
    write_line(Line, 0).

% write_board(+Board, +IsFirstLine)
write_board(Board) :-
    write_board(Board, 0).

write_board([], _).
write_board(Board, 0) :-
    write('| '),
    index_line(Indexes),
    write_line(Indexes, 0), nl,
    write_board(Board, 1).
write_board([Head|Tail], CurrLine) :-
    write('| '),
    write_line(Head, CurrLine), nl,
    write_board(Tail, CurrLine + 1).

