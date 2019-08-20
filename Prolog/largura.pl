/*  BUSCA EM LARGURA */

resolva(Solucao):-
        estado_inicial(E),
	busca([[ramo(raiz,E)]],Solucao).
resolvaim:-
        estado_inicial(E),
	busca([[ramo(raiz,E)]],Solucao),
	imprima(Solucao).

busca([Solucao|_],Solucao):- atinge_meta(Solucao),!.
busca([T|Fila],Solucao):- 
       ache_todos(Extensao,estende_ate_filho(T,Extensao),Extensoes),
       concatena(Fila,Extensoes,Fila_ext),
       busca(Fila_ext,Solucao).

atinge_meta([ramo(_,M)|_]):-meta(M).

ache_todos(X,Y,Z):-findall(X,Y,Z),!.
ache_todos(_,_,[]).

estende_ate_filho([ramo(Ramo,N)|Trajetoria],
                  [ramo(Op,Filho),ramo(Ramo,N)|Trajetoria]):-
        transforma(N,Filho,Op),
        nao_produz_ciclos(Filho,Trajetoria).

nao_produz_ciclos(Estado,Trajetoria):-
        not(pertence(ramo(Op,Estado),Trajetoria)).
        
pertence(X,[X|_]):-!.
pertence(X,[_|Y]):- pertence(X,Y).

concatena([],X,X):-!.
concatena([X|Y],Z,[X|W]):-concatena(Y,Z,W).

imprima([ramo(raiz,Raiz)]):- !, write('Estado inicial: '),write(Raiz),write('.').
imprima([ramo(Ramo,Nodo)|R]):-
	imprima(R),nl,
	write(Ramo),write(' e, portanto, temos: '),nl,
	write(Nodo),write('.').
        
estado_inicial([o,o,i,*,*]).
meta([o,*,*,o,i]).

transforma([i,A,B,C,D],[A,i,B,C,D],deslisa).
transforma([i,A,B,C,D],[B,A,i,C,D],salta).      

transforma([A,i,B,C,D],[A,B,i,C,D],deslisa).
transforma([A,i,B,C,D],[i,A,B,C,D],deslisa).
transforma([A,i,B,C,D],[A,C,B,i,D],salta).

transforma([A,B,i,C,D],[A,i,B,C,D],deslisa).
transforma([A,B,i,C,D],[A,B,C,i,D],deslisa).
transforma([A,B,i,C,D],[i,B,A,C,D],salta).
transforma([A,B,i,C,D],[A,B,D,C,i],salta).

transforma([A,B,C,i,D],[A,B,i,C,D],deslisa).
transforma([A,B,C,i,D],[A,B,C,D,i],deslisa).
transforma([A,B,C,i,D],[A,i,C,B,D],salta).

transforma([A,B,C,D,i],[A,B,C,i,D],deslisa).
transforma([A,B,C,D,i],[A,B,i,D,C],salta).
