readList(0, []) :- !.
readList(N, [Head | Tail]) :- read(Head), !, New_N is N - 1, readList(New_N, Tail).

writeList([]) :- !.
writeList([Head | Tail]) :- write(Head), nl, writeList(Tail).

%concatList(+A, +B, -C) :- присоединение списка B к списку A
concatList([], B, B) :- !.
concatList([Head | Tail], X, [Head | T]) :- concatList(Tail, X, T).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

% 11_42 Найти все элементы, которые меньше среднего арифметического элементов массива.

sr_ar(List, Res) :- sr_ar(List, 0, 0, Res).
sr_ar([], Kol, Sum, Res) :- Res is Sum div Kol.
sr_ar([Head | Tail], CurKol, CurSum, Res) :- NewKol is CurKol + 1, NewSum is CurSum + Head, sr_ar(Tail, NewKol, NewSum, Res), !.

% возвращает список элементов, меньших X
less_thanX(List, X, Res) :- less_thanX(List, X, [], Res).
less_thanX([], _, Res, Res) :- !.
less_thanX([Head | Tail], X, CurList, Res) :- (Head < X, concatList(CurList, [Head], NewList); NewList = CurList), less_thanX(Tail, X, NewList, Res), !.

task11 :- 
    write('Input list length: '), read(N), write('Input list: '), nl, readList(N, List), 
    write('sr_ar = '), sr_ar(List, Res), write(Res), nl, write('Elements < sr_ar: '), nl, less_thanX(List, Res, ResList), writeList(ResList).

% 12_48 Построить список с номерами элемента, который повторяется наибольшее число раз.

% сколько раз элемент X встречается в списке
elemFreq(List, X, Res) :- elemFreq(List, X, 0, Res).
elemFreq([], _, Res, Res) :- !. 
elemFreq([Head | Tail], Head, CurKol, Res) :- NewKol is CurKol + 1, elemFreq(Tail, Head, NewKol, Res), !. 
elemFreq([ _ | Tail], X, CurKol, Res) :- elemFreq(Tail, X, CurKol, Res), !. 

% самый частый элемент списка
most_freqElem([Head | Tail], Res) :- mfe([Head | Tail], Head, 1, Res).
mfe([], Res, _, Res) :- !.
mfe([Head | Tail], CurMaxEl, CurMaxFreq, Res) :- elemFreq([Head | Tail], Head, Freq), (Freq > CurMaxFreq, NewMaxEl is Head, NewMaxFreq is Freq; 
                                                      NewMaxEl is CurMaxEl, NewMaxFreq is CurMaxFreq), mfe(Tail, NewMaxEl, NewMaxFreq, Res), !.

% список с индексами элемента X в списке
find_X_indexes(List, X, Res) :- f_Xi(List, X, 0, [], Res).
f_Xi([], _, _, Res, Res) :- !. 
f_Xi([Head | Tail], X, I, CurList, Res) :- (Head is X, concatList(CurList, [I], NewList); NewList = CurList), 
                                               I1 is I + 1, f_Xi(Tail, X, I1, NewList, Res), !. 

task12 :- 
    write('Input list length: '), read(N), write('Input list: '), nl, readList(N, List), 
    most_freqElem(List, MF), find_X_indexes(List, MF, ResList), write('Most frequent element = '), write(MF), nl, write('Result list: '), nl, writeList(ResList).

% 13_54 Построить список из элементов, встречающихся в исходном более трех раз.

% список элементов, встречающихся более Freq раз
filterByFreq(List, Freq, Res) :- fbf(List, Freq, [], Res).
fbf(List, Freq, [], _) :- most_freqElem(List, MF), elemFreq(List, MF, GreatFreq), GreatFreq =< Freq, !, fail.
fbf([], _, Res, Res) :- !.
fbf([Head | Tail], Freq, CurList, Res) :- elemFreq([Head | Tail], Head, CurElemFreq), (CurElemFreq > Freq, concatList(CurList, [Head], NewList);
                                          NewList = CurList), fbf(Tail, Freq, NewList, Res), !. 

task13:- 
    write('Input list length: '), read(N), write('Input list: '), nl, readList(N, List), 
    filterByFreq(List, 3, ResList), write('Result list: '), nl, writeList(ResList).

% 14 [фамилия, цвет волос]
task14 :- 
    Hair = [_, _, _],
    in_list(Hair,[belokurov,_]),
    in_list(Hair,[chernov,_]),
    in_list(Hair,[rizhov,_]),
    in_list(Hair,[_,redhead]),
    in_list(Hair,[_,blond]),
    in_list(Hair,[_,brunette]),
    not(in_list(Hair,[belokurov,blond])),
    not(in_list(Hair,[belokurov,brunette])),
    not(in_list(Hair,[chernov,brunette])),
    not(in_list(Hair,[rizhov,redhead])),
    write(Hair), !.