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
    in_list(Hair, [belokurov, _]),
    in_list(Hair,[chernov, _]),
    in_list(Hair,[rizhov, _]),
    in_list(Hair,[_, redhead]),
    in_list(Hair,[_, blond]),
    in_list(Hair,[_, brunette]),
    not(in_list(Hair,[belokurov, blond])),
    not(in_list(Hair,[belokurov, brunette])),
    not(in_list(Hair,[chernov, brunette])),
    not(in_list(Hair,[rizhov, redhead])),
    write(Hair), !.

% 15 [имя, платье, туфли]
task15 :-
    Dress = [_, _, _],
    in_list(Dress, [anya, _, _]),
    in_list(Dress, [valya, _, _]),
    in_list(Dress, [natasha, _, _]),
    in_list(Dress, [_, white, _]),
    in_list(Dress, [_, blue, _]),
    in_list(Dress, [_, green, _]),
    in_list(Dress, [_, _, white]),
    in_list(Dress, [_, _, blue]),
    in_list(Dress, [_, _, green]),
    not(in_list(Dress, [valya, W, W])),
    in_list(Dress, [natasha, _, green]),
    not(in_list(Dress, [valya, white, green])),
    not(in_list(Dress, [anya, _, green])),
    not(in_list(Dress, [valya, _, green])),
    not(in_list(Dress, [natasha, G, G])),
    write(Dress), !.

% 16 [фамилия, профессия, siblings_count, возраст]
task16 :- 
    Factory = [_, _, _, _],
    in_list(Factory, [borisov, _, 1, _]),
    in_list(Factory, [ivanov, _, _, _]),
    in_list(Factory, [semenov, _, _, 2]),
    in_list(Factory, [_, slesar, 0, 0]),
    in_list(Factory, [_, tokar, _, 1]),
    in_list(Factory, [_, svarshik, _, _]),
    in_list(Factory, [Friend1, slesar, _, _]),
    in_list(Factory, [Friend2, tokar, _, _]),
    in_list(Factory, [Friend3, svarshik, _, _]),
    write('slesar is '), write(Friend1), nl, write('tokar is '), write(Friend2), nl, write('svarshick is '), write(Friend3), !.

% 17 

% B справа от A в списке
right_next(_, _, [_]) :- fail.
right_next(A, B, [A | [B | _]]).
right_next(A, B, [ _ | List]) :- right_next(A, B, List).

% B слева от A в списке
left_next(_, _, [_]) :- fail.
left_next(A, B, [B | [A | _]]).
left_next(A, B, [ _ | List]) :- left_next(A, B, List).

% B около A в списке
next_to(A, B, List) :- right_next(A, B, List).
next_to(A, B, List) :- left_next(A, B, List).

% X между A и B в списке
between(X, A, B, List) :- left_next(X, A, List), right_next(X, B, List).
between(X, A, B, List) :- left_next(X, B, List), right_next(X, A, List).

% [емкость, жидкость]
task17 :- 
    Drinks = [_, _, _, _],
    in_list(Drinks, [bottle, _]),
    in_list(Drinks, [glass, _]),
    in_list(Drinks, [jug, _]),
    in_list(Drinks, [can, _]),
    in_list(Drinks, [_, milk]),
    in_list(Drinks, [_, limonade]),
    in_list(Drinks, [_, kvas]),
    in_list(Drinks, [_, water]),
    not(in_list(Drinks, [bottle, water])),
    not(in_list(Drinks, [bottle, milk])),
    between([_, limonade], [jug, _], [_, kvas], Drinks),
    not(in_list(Drinks, [can, limonade])),
    not(in_list(Drinks, [can, water])),
    next_to([glass, _], [can, _], Drinks),
    next_to([glass, _], [_, milk], Drinks),
    write(Drinks), !.

% 18 
task18 :- 
    Professions = [_, _, _, _],
    in_list(Professions, [voronov, _]),
    in_list(Professions, [pavlov, _]),
    in_list(Professions, [levizkiy, _]),
    in_list(Professions, [saharov, _]),
    in_list(Professions, [_, dancer]),
    in_list(Professions, [_, painter]),
    in_list(Professions, [_, singer]),
    in_list(Professions, [_, writer]),
    not(in_list(Professions, [voronov, singer])),
    not(in_list(Professions, [levizkiy, singer])),
    not(in_list(Professions, [pavlov, painter])),
    not(in_list(Professions, [pavlov, writer])),
    not(in_list(Professions, [saharov, writer])),
    not(in_list(Professions, [voronov, writer])),
    write(Professions), !.