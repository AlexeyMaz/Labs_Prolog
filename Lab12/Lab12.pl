% readList(+N, -List)
readList(0, []) :- !.
readList(N, [ Head | Tail ]) :- read(Head), !, New_N is N - 1, readList(New_N, Tail).

writeList([]) :- !.
writeList([ Head | Tail ]) :- write(Head), nl, writeList(Tail).

is_Simple(1) :- !, fail.
is_Simple(X) :- is_Simple(X, 2).
is_Simple(X, X) :- !.
is_Simple(X, I) :- 0 =:= (X mod I), !, fail;
                 I1 is I + 1, is_Simple(X, I1), !.

% 11 Найти сумму непростых делителей числа (рекурсия вверх)
notSimDelSum_Up(X, Res) :- nsds(X, X, Res).
nsds(_, 2, 1) :- !.
nsds(X, I, Res) :- I1 is I - 1, nsds(X, I1, Res1), (not(is_Simple(I)), 0 =:= (X mod I), Res is Res1 + I; Res is Res1), !.

% 11 Найти сумму непростых делителей числа (рекурсия вниз)
notSimDelSum_Down(X, Res) :- nsds_(X, X, 1, Res).
nsds_(_, 2, Res, Res) :- !.
nsds_(X, I, CurSum, Res) :- I1 is I - 1, (not(is_Simple(I)), 0 =:= (X mod I), !), NewSum is CurSum + I, nsds_(X, I1, NewSum, Res);
                         I2 is I - 1, nsds_(X, I2, CurSum, Res).