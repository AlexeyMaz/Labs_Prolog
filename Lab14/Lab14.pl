read_str(A, N) :- read_str(A, N, 0).
read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

read_list_str(List) :- read_str(A,_,Flag), read_list_str([A],List,Flag).
read_list_str(List,List,1) :- !.
read_list_str(Cur_list,List,0) :- read_str(A,_,Flag), (not(A = []), append(Cur_list,[A],C_l), read_list_str(C_l,List,Flag); 
                                  read_list_str(Cur_list,List,Flag)), !.

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

in_list([], _) :- fail.
in_list([X|_], X).
in_list([_|T] ,X) :- in_list(T, X).

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

% 2.2 Дан файл. Определить, сколько в файле строк, не содержащих пробелы.
count_no_spaces([], Result, Result) :- !.
count_no_spaces([H|T], CurCnt, Result) :- count_symbols(H, ' ', SC), SC = 0, NewCnt is CurCnt + 1, count_no_spaces(T, NewCnt, Result), !.
count_no_spaces([_|T], CurCnt, Result) :- count_no_spaces(T, CurCnt, Result), !.
count_no_spaces(Strings, Result) :- count_no_spaces(Strings, 0, Result), !.

task2_2 :- see('Labs_Prolog/Lab14/file1.txt'), read_list_str(StrList), seen, count_no_spaces(StrList, Cnt), write('Strings with no spaces: '), write(Cnt), nl.

% 2.3 Дан файл, найти и вывести на экран только те строки, в которых букв А больше, чем в среднем на строку.
cnt_sym_in_list([], _, Result, Result) :- !.
cnt_sym_in_list([H|T], Sym, CurCnt, Result) :- count_symbols(H, Sym, Cnt), NewCnt is CurCnt + Cnt, cnt_sym_in_list(T, Sym, NewCnt, Result), !.
cnt_sym_in_list(List, Sym, Result) :- cnt_sym_in_list(List, Sym, 0, Result), !.

write_many_a([], _) :- !.
write_many_a([H|T], Avg) :- count_symbols(H, 'a', Cnt1), count_symbols(H, "A", Cnt2), Cnt is Cnt1 + Cnt2, Cnt > Avg, write_str(H), nl, write_many_a(T, Avg), !.
write_many_a([_|T], Avg) :- write_many_a(T, Avg), !.

task2_3 :- 
    see('Labs_Prolog/Lab14/file1.txt'), read_list_str(StrList), seen, len(StrList, Len), cnt_sym_in_list(StrList, 'a', Cnt1), cnt_sym_in_list(StrList, "A", Cnt2), 
    CntA is Cnt1 + Cnt2, Avg is CntA / Len, write('Avg A per str: '), write(Avg), nl, write_many_a(StrList, Avg).

% 2.4 Дан файл, вывести самое частое слово.
str_list_to_words_list([], Result, Result) :- !.
str_list_to_words_list([H|T], CurList, Result) :- split_str(H, ' ', StrWords), concatStr(CurList, StrWords, NewList), str_list_to_words_list(T, NewList, Result), !.
str_list_to_words_list(StrList, Result) :- str_list_to_words_list(StrList, [], Result).

most_freq_word_in_list(Words, Result) :- most_freq_word(Words, Words, 0, [], Result).

task2_4 :- see('Labs_Prolog/Lab14/file2.txt'), read_list_str(StrList), seen, str_list_to_words_list(StrList, WordsList), most_freq_word_in_list(WordsList, MF), write_str(MF).

% 2.5 Дан файл, вывести в отдельный файл строки, состоящие из слов, не повторяющихся в исходном файле.
get_repeating_words([], _, Result, Result) :- !.
get_repeating_words([H|T], PrevWords, CurList, Result) :- in_list(PrevWords, H), concatStr(CurList, [H], NewList), concatStr(PrevWords, [H], NewWords), get_repeating_words(T, NewWords, NewList, Result), !.
get_repeating_words([H|T], PrevWords, CurList, Result) :- concatStr(PrevWords, [H], NewWords), get_repeating_words(T, NewWords, CurList, Result), !.
get_repeating_words(Words, Result) :- get_repeating_words(Words, [], [], Result).

% Содержится ли в List хотя бы один элемент второго списка
contains(_, []) :- fail.
contains(List, [X|_]) :- in_list(List, X), !.
contains(List, [_|XT]) :- contains(List, XT).

write_no_rep_words([], _) :- !.
write_no_rep_words([H|T], RepWords) :- split_str(H, ' ', StrWords), not(contains(RepWords, StrWords)), write_str(H), nl, write_no_rep_words(T, RepWords), !.
write_no_rep_words([_|T], RepWords) :- write_no_rep_words(T, RepWords), !.

task2_5 :- 
    see('Labs_Prolog/Lab14/file3.txt'), read_list_str(StrList), seen, str_list_to_words_list(StrList, Words), get_repeating_words(Words, RepWords), 
    tell('Labs_Prolog/Lab14/out_2_5.txt'), write_no_rep_words(StrList, RepWords), told.