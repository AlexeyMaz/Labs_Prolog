man(arseniy).
man(artem).
man(egor).
man(daniil).
man(sultan).
man(valentin).
man(alexey).
man(artur).
man(kirill).
man(ivan).
man(anton).
man(andrey).
man(valera).

woman(olga).
woman(dasha).
woman(kristina).
woman(katya).
woman(valentina).
woman(svetlana).
woman(rita).
woman(eleonora).
woman(polina).
woman(tatyana).
woman(anna).
woman(nastya).
woman(natasha).
woman(veronika).

%parent(родитель, ребенок)
parent(artem,egor).
parent(artem,daniil).
parent(artem,sultan).
parent(artem,valentin).

parent(kristina,egor).
parent(kristina,daniil).
parent(kristina,sultan).
parent(kristina,valentin).

parent(alexey,kirill).
parent(alexey,tatyana).
parent(eleonora,kirill).
parent(eleonora,tatyana).

parent(ivan,anton).
parent(ivan,polina).
parent(anna,anton).
parent(anna,polina).

parent(andrey,rita).
parent(andrey,ivan).
parent(andrey,svetlana).
parent(katya,rita).
parent(katya,svetlana).
parent(katya,ivan).

parent(arseniy,nastya).
parent(arseniy,valera).
parent(arseniy,dasha).
parent(natasha,nastya).
parent(natasha,valera).
parent(natasha,dasha).

man :- man(X),print(X),nl,fail.
woman :- woman(X),print(X),nl,fail.

% 11 Является ли X дочерью Y
daughter(X, Y) :- woman(X), parent(Y, X).
% 11 Вывести всех дочерей X
daughter(X) :- woman(Y), parent(X, Y), write(Y), nl, fail.

% 12 Является ли X мужем Y
husband(X,Y) :- man(X), woman(Y), parent(X,Child), parent(Y,Child).
% 12 Выводит мужа X
husband(X) :- woman(X), man(Y), parent(X,Child), parent(Y,Child), !, print(Y), nl, fail.

% 13 Является ли X внуком Y
grand_son(X,Y) :- man(X), parent(Y,Z), parent(Z,X).
% 13 Вывести всех внуков X
grand_sons(X) :- parent(X,Y), parent(Y,Z), man(Z), write(Z), nl, fail.

% 14 Являются ли X и Y бабушкой и внучкой или внучкой и бабушкой
grand_ma_and_da(X,Y) :-
    woman(X), woman(Y), parent(X, Z), parent(Z, Y),!;
    woman(Y), woman(X), parent(Y, Z), parent(Z, X),!.

% 15 Найти минимальную цифру числа с помощью рекурсии вверх
minDigit_Up(0,9) :- !.
minDigit_Up(X,Digit) :- X1 is X div 10, minDigit_Up(X1,Dig1), Dig2 is X mod 10, (Dig1 < Dig2, Digit is Dig1; Digit is Dig2), !.

% 16 Найти минимальную цифру числа с помощью рекурсии вниз
minDigit_Down(N, X) :- minDigit_Down(N, 9, X).
minDigit_Down(0, X, X) :- !.
minDigit_Down(N, Digit, X) :- N1 is N div 10, Dig is N mod 10, Dig < Digit, !, minDigit_Down(N1, Dig, X); 
N2 is N div 10, minDigit_Down(N2, Digit, X).

% 17 Найти количество цифр числа, меньших 3 с помощью рекурсии вверх
kolvoD_Up(0, 0) :- !.
kolvoD_Up(N, Kol) :- N1 is N div 10, kolvoD_Up(N1, Kol1), Digit is N mod 10, (Digit < 3, Kol is Kol1 + 1; Kol is Kol1), !.

% 18 Найти количество цифр числа, меньших 3 с помощью рекурсии вниз
kolvoD_Down(N, X) :- kolvoD_Down(N, 0, X).
kolvoD_Down(0, X, X) :- !.
kolvoD_Down(N, Kol, X) :- N1 is N div 10, Dig is N mod 10, Dig < 3, !, Kol1 is Kol + 1, kolvoD_Down(N1, Kol1, X);
N2 is N div 10, kolvoD_Down(N2, Kol, X).