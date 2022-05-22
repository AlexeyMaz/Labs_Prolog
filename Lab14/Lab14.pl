read_str(A, N) :- read_str(A, N, 0).
read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

read_list_str(List) :- read_str(A,_,Flag), read_list_str([A],List,Flag).
read_list_str(List,List,1) :- !.
read_list_str(Cur_list,List,0) :- read_str(A,_,Flag), append(Cur_list,[A],C_l), read_list_str(C_l,List,Flag).

write_str([]):-!.
write_str([H|Tail]):-put(H),write_str(Tail).

concatStr([], B, B) :- !.
concatStr([Head | Tail], X, [Head | T]) :- concatStr(Tail, X, T).

count(List, X, Result) :- count(List, X, 0, Result).
count([], _, Result, Result) :- !.
count([X|T], X, CurCnt, Result) :- NewCnt is CurCnt + 1, count(T, X, NewCnt, Result), !.
count([_|T], X, CurCnt, Result) :- count(T, X, CurCnt, Result), !.

len([], Result, Result) :- !.
len([_|T], CurrentLen, Result) :- NewLen is CurrentLen + 1, len(T, NewLen, Result), !.
len([X|T], Result) :- len([X|T], 0, Result).

% Задание 1
% 1.1 Дана строка. Вывести ее три раза через запятую и показать количество символов в ней.
task1_1 :- write('Input string: '), read_str(Str, Len), write_str(Str), write(', '), write_str(Str), write(', '), write_str(Str), nl, write('Length: '), write(Len).

% 1.2 Дана строка. Найти количество слов.
count_symbols(Str, Search, Result) :- char_code(Search, SCode), count_symbols(Str, SCode, 0, Result).
count_symbols([], _, Result, Result) :- !.
count_symbols([S|T], Search, CurKol, Result) :- S = Search, NewKol is CurKol + 1, count_symbols(T, Search, NewKol, Result), !.
count_symbols([_|T], Search, CurKol, Result) :- count_symbols(T, Search, CurKol, Result), !.

task1_2 :- write('Input string: '), read_str(Str, _), count_symbols(Str, ' ', SpacesKol), WordsKol is SpacesKol + 1, write('Words count: '), write(WordsKol).

% 1.3 Дана строка, определить самое частое слово.
split_str([], _, CurWord, CurWordList, Result) :- concatStr(CurWordList, [CurWord], NewWL), Result = NewWL, !.
split_str([Separator|T], Separator, CurWord, CurWordList, Result) :- concatStr(CurWordList, [CurWord], NewWL), split_str(T, Separator, [], NewWL, Result), !.
split_str([S|T], Separator, CurWord, CurWordList, Result) :- concatStr(CurWord, [S], NewWord), split_str(T, Separator, NewWord, CurWordList, Result), !.
split_str(Str, Separator, Result) :- char_code(Separator, SepCode), split_str(Str, SepCode, [], [], Result).

most_freq_word(Str, Result) :- split_str(Str, ' ', Words), most_freq_word(Words, Words, 0, [], Result).
most_freq_word(Words, [Word|T], CurMaxCnt, _, Result) :- count(Words, Word, Cnt), Cnt > CurMaxCnt, NewMax is Cnt, NewMaxWord = Word, most_freq_word(Words, T, NewMax, NewMaxWord, Result), !.
most_freq_word(Words, [_|T], CurMaxCnt, CurMaxWord, Result) :- most_freq_word(Words, T, CurMaxCnt, CurMaxWord, Result), !.
most_freq_word(_, [], _, Result, Result) :- !.

task1_3 :- write('Input string: '), read_str(Str, _), most_freq_word(Str, X), write('Most frequent word: '), write_str(X).

% 1.4 Вывести первые три символа и последние три символа, если длина строки больше 5. Иначе вывести первый символ столько раз,
% какова длина строки.
slice([H|T], Start, End, Result) :- slice([H|T], Start, End, 0, [], Result).
slice([H|T], Start, End, I, CurList, Result) :- I >= Start, I < End, concatStr(CurList, [H], NewList), I1 is I + 1, slice(T, Start, End, I1, NewList, Result), !.
slice([_|T], Start, End, I, CurList, Result) :- I1 is I + 1, slice(T, Start, End, I1, CurList, Result), !.
slice([], _, _, _, Result, Result) :- !.

write_str_loop(_, 0) :- !. 
write_str_loop(Str, Kol) :- write_str(Str), Kol1 is Kol - 1, write_str_loop(Str, Kol1), !. 

task1_4 :- write('Input string: '), read_str(Str, Len), task1_4(Str, Len).
task1_4(Str, Len) :- Len > 5, slice(Str, 0, 3, First3), L3 is Len - 3, slice(Str, L3, Len, Last3), write_str(First3), write(' '), write_str(Last3).
task1_4([Ch|_], Len) :- write_str_loop([Ch], Len).

% 1.5 Дана строка. Показать номера символов, совпадающих с последним символом строки.
find_indexes(List, X, Result) :- find_indexes(List, X, 0, [], Result).
find_indexes([], _, _, Result, Result) :- !.
find_indexes([X|T], X, I, CurList, Result) :- concatStr(CurList, [I], NewList), I1 is I + 1, find_indexes(T, X, I1, NewList, Result), !.
find_indexes([_|T], X, I, CurList, Result) :- I1 is I + 1, find_indexes(T, X, I1, CurList, Result), !.

task1_5 :- write('Input string: '), read_str(Str, Len), L1 is Len - 1, slice(Str, L1, Len, [LastSym|_]), find_indexes(Str, LastSym, Result), write(Result).


% Задание 2
% 2.1 Дан файл. Прочитать из файла строки и вывести длину наибольшей строки.
max_len_in_list([], Result, Result) :- !.
max_len_in_list([H|T], CurMax, Result) :- len(H, NewMax), NewMax > CurMax, max_len_in_list(T, NewMax, Result), !.
max_len_in_list([_|T], CurMax, Result) :- max_len_in_list(T, CurMax, Result), !.
max_len_in_list(List, Result) :- max_len_in_list(List, 0, Result).

task2_1 :- see('Labs_Prolog/Lab14/file1.txt'), read_list_str(StrList), seen, max_len_in_list(StrList, MaxLen), write('Max str len: '), write(MaxLen), nl.