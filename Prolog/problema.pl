/*  BUSCA HEURÍSTICA - Exemplo 02*/

resolva:-
        estado_inicial(E),
	calcule_H(E,HN),
	busca([puzzle(HN,0,[ramo(raiz,E)])],Solucao),
	imprima(Solucao).

busca([Solucao|_],Solucao):- atinge_meta(Solucao),!.
busca([T|Fila],Solucao):- 
	ache_todos(Extensao,estende_ate_filho(T,Extensao),Extensoes),
	concatena(Fila,Extensoes,Fila_ext),
	sort(Fila_ext,Fila_heuris),
	busca(Fila_heuris,Solucao).

atinge_meta(puzzle(_,_,[ramo(_,M)|_])):-meta(M).

ache_todos(X,Y,Z):-findall(X,Y,Z),!.
ache_todos(_,_,[]).

nao_produz_ciclos(Estado,Trajetoria):-
        not(pertence(ramo(_,Estado),Trajetoria)).
        
pertence(X,[X|_]):-!.
pertence(X,[_|Y]):- pertence(X,Y).

concatena([],X,X):-!.
concatena([X|Y],Z,[X|W]):-concatena(Y,Z,W).

imprima(puzzle(_,_,T)):- imprima_trajet(T).
imprima_trajet([ramo(raiz,Raiz)]):- !, write('De '),write(Raiz),write('.').
imprima_trajet([ramo(Ramo,Nodo)|R]):-
	imprima_trajet(R),nl,
	write(Ramo),write(' '),
	write(Nodo),write('.').

estende_ate_filho(puzzle(_,G,[ramo(Ramo,Nodo)|Trajetoria]),
                  puzzle(F1,G1,[ramo(Op,Filho),ramo(Ramo,Nodo)|Trajetoria])):-
        transforma(Nodo,Filho,Op),
        nao_produz_ciclos(Filho,Trajetoria),
	calcule_G(Nodo, Filho, CustoG),
	calcule_H(Filho, CustoH),
	G1 is G+CustoG,   
	F1 is G1+CustoH.
calcule_G(Nodo,Filho,CustoG):-
	diferenca(Nodo,Filho,G),
        CustoG is G-1.
calcule_H(Nodo,CustoH):-
      meta(M),
      diferenca(Nodo,M,CustoH).

diferenca([],[],0).
diferenca([A|Cauda],[MA|CaudaM],S):-
	A =\= MA,
	diferenca(Cauda,CaudaM,S1),
	S is S1+1.
diferenca([A|Cauda],[MA|CaudaM],S):-
	A = MA,
	diferenca(Cauda,CaudaM,S).

        
/* ordena de 0 a 8  */
estado_inicial([7,2,4,5,0,6,8,3,1]).
meta([0,1,2,3,4,5,6,7,8]).

/* Posição (1,1) = A */
transforma([A,B,C,D,E,F,G,H,I],[B,A,C,D,E,F,G,H,I],a_direita):- B = 0.
transforma([A,B,C,D,E,F,G,H,I],[D,B,C,A,E,F,G,H,I],para_baixo):- D = 0.

/* Posição (1,2) = B */
transforma([A,B,C,D,E,F,G,H,I],[A,C,B,D,E,F,G,H,I],para_direita):- C = 0.
transforma([A,B,C,D,E,F,G,H,I],[B,A,C,D,E,F,G,H,I],para_esquerda):- A = 0.
transforma([A,B,C,D,E,F,G,H,I],[E,A,C,B,D,F,G,H,I],para_baixo):- E = 0.

/* Posição (1,3) = C */
transforma([A,B,C,D,E,F,G,H,I],[A,C,B,D,E,F,G,H,I],para_esquerda):- B = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,F,D,E,C,G,H,I],para_baixo):- F = 0.

/* Posição (2,1) = D */
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,E,D,F,G,H,I],para_direita):- E = 0.
transforma([A,B,C,D,E,F,G,H,I],[D,B,C,A,E,F,G,H,I],para_cima):- A = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,G,E,F,D,H,I],para_baixo):- G = 0.


/* Posição (2,2) = E */
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,F,E,G,H,I],para_direita):- F = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,E,D,F,G,H,I],para_esquerda):- D = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,E,C,D,B,F,G,H,I],para_cima):- B = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,H,F,G,E,I],para_baixo):- H = 0.

/* Posição (2,3) = F */
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,F,E,G,H,I],para_esquerda):- E = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,F,D,E,C,G,H,I],para_cima):- C = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,E,I,G,H,F],para_baixo):- I = 0.

/* Posição (3,1) = G */
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,E,F,H,G,I],a_direita):- H = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,G,E,F,D,H,I],para_cima):- D = 0.

/* Posição (3,2) = H */
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,E,F,G,I,H],para_direita):- I = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,E,F,H,G,I],para_esquerda):- G = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,H,F,G,E,I],para_cima):- E = 0.

/* Posição (3,3) = I */
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,E,F,G,I,H],para_esquerda):- H = 0.
transforma([A,B,C,D,E,F,G,H,I],[A,B,C,D,E,I,G,H,F],para_cima):- F = 0.

