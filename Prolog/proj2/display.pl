

% printBoard([], _).
% printBoard([H|T], N) :-
%     M is N + 1,
%     makeFormat(H,'~d- |',  H1, Format),  % make format starting with '~d- |'
%     format(Format, [M|H1]),              % write out the list with prefix
%     printBoard(T, M).

printBoard(Board) :-
    write(Board).
    %format('~6w', Board).