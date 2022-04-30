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
minDigit_Up(X) :- minDigit_Up(X,9).
minDigit_Up(0,9) :- !.
minDigit_Up(X,Digit) :- X1 is X div 10, minDigit_Up(X1,Dig1), Dig2 is X mod 10, (Dig1 < Dig2, Digit is Dig1; Digit is Dig2), !.

min_d_up(0, 9) :- !.
min_d_up(X, Dig) :- X1 is X div 10, min_d_up(X1, D1), D2 is X mod 10, (D1<D2, Dig is D1; Dig is D2),!.

%15
minU(0,9):-!.
minU(X,M):-
	X1 is X div 10,
	minU(X1,M1),
	M2 is X mod 10,
	(M2<M1, M is M2;M is M1).