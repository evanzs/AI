%2.Dado um banco de conhecimento com informa��es geogr�ficas definindo os seguintes fatos 



oceano(pacifico).
ocenano(atlantico).

%Paises random

%EU
pais(espanha).
pais(italia).
pais(fran�a).


%SA
pais(brasil).
pais(chile).
pais(peru).


%CONTINENTES
continente(europa).
continente(america_sul).



%Demarcando fronteiras
fronteira(brasil,atlantico).
fronteira(brasil,peru).
fronteira(espanha,fran�a).
fronteira(fran�a,italia).
fronteira(italia,atlantico).



loc(espanha,europa).
loc(italia,europa).
loc(fran�a,europa).

loc(brasil,america_sul).
loc(chile,america_sul).
loc(peru,america_sul).

eu_fronteira(Lista):-findall(X,(fronteira(X,atlantico),loc(X,europa)),Lista);findall(X,(fronteira(X,pacifico),loc(X,europa)),Lista).

mesmafronteira(Lista):-findall(A,(fronteira(A,Y),fronteira(B,Y)),Lista).
