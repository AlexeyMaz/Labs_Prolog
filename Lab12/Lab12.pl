% readList(+N, -List)
readList(0, []) :- !.
readList(N, [ Head | Tail ]) :- read(Head), !, New_N is N - 1, readList(New_N, Tail).

writeList([]) :- !.
writeList([ Head | Tail ]) :- write(Head), nl, writeList(Tail).

nod(A, 0, A) :- !.
nod(A, B, X) :- C is A mod B, nod(B, C, X).

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

% 12 Найти количество чисел, не являющихся делителями исходного числа,
% не взамнопростых с ним и взаимно простых с суммой простых цифр этого числа.
ssd(0, 0) :- !. % сумма простых цифр числа
ssd(X, Res) :- X1 is X div 10, ssd(X1, Res1), Dig is X mod 10, (is_Simple(Dig), Res is Res1 + Dig; Res is Res1), !.

task12(X, Kol) :- task12(X, X, Kol).
task12(_, 2, 0) :- !.
task12(X, I, Kol) :- I1 is I - 1, task12(X, I1, Kol1), ssd(X, Sum), nod(X, I, Res1), nod(Sum, I, Res2), (0 =\= (X mod I), 1 =\= Res1, 1 =:= Res2, Kol is Kol1 + 1; Kol is Kol1), !.
