readList(0, []) :- !.
readList(N, [Head | Tail]) :- read(Head), !, New_N is N - 1, readList(New_N, Tail).

writeList([]) :- !.
writeList([Head | Tail]) :- write(Head), nl, writeList(Tail).

%concatList(+A, +B, -C) :- присоединение списка B к списку A
concatList([], B, B) :- !.
concatList([Head | Tail], X, [Head | T]) :- concatList(Tail, X, T).

% 11_42 Найти все элементы, которые меньше среднего арифметического элементов массива.
sr_ar(List, Res) :- sr_ar(List, 0, 0, Res).
sr_ar([], Kol, Sum, Res) :- Res is Sum div Kol.
sr_ar([Head | Tail], CurKol, CurSum, Res) :- NewKol is CurKol + 1, NewSum is CurSum + Head, sr_ar(Tail, NewKol, NewSum, Res), !.

less_thanX(List, X, Res) :- less_thanX(List, X, [], Res).
less_thanX([], _, Res, Res) :- !.
less_thanX([Head | Tail], X, CurList, Res) :- (Head < X, concatList(CurList, [Head], NewList); NewList = CurList), less_thanX(Tail, X, NewList, Res), !.

task11 :- 
    write('Input list length: '), read(N), write('Input list: '), nl, readList(N, List), 
    write('sr_ar = '), sr_ar(List, Res), write(Res), nl, write('Elements < sr_ar: '), nl, less_thanX(List, Res, ResList), writeList(ResList).