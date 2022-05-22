read_str(A, N) :- read_str(A, N, 0).
read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1,Flag).

write_str([]):-!.
write_str([H|Tail]):-put(H),write_str(Tail).

concatStr([], B, B) :- !.
concatStr([Head | Tail], X, [Head | T]) :- concatStr(Tail, X, T).

count(List, X, Result) :- count(List, X, 0, Result).
count([], _, Result, Result) :- !.
count([X|T], X, CurCnt, Result) :- NewCnt is CurCnt + 1, count(T, X, NewCnt, Result), !.
count([_|T], X, CurCnt, Result) :- count(T, X, CurCnt, Result), !.

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