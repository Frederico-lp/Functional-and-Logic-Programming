last(X,[X]).
last(X,[_|Z]) :- last(X,Z).