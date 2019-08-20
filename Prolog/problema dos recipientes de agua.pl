/*Evandro Fernandes Barreto*/
/* RA: 151025411*/
/* UNESP-BAURU*/

/*Problema dos recipientes de água Considere  dois  recipientes  de  água.  
Um  com  capacidade  para  7  litros e  o  outro  com  capacidade  para  5 litros.  
Inicialmente  ambos  estão  vazios.  Em  qualquer  momento,  
os  recipientes  podem  ser  cheios  com água  de  uma  fonte  externa  ou  esvaziados  jogando  fora  o  seu  conteúdo.
A  água pode  também  ser transferida  de  um  recipiente  para  outro,
até  que  o  primeiro  ou  o  segundo  esteja  vazio  ou  até  que  o primeiro ou o segundo esteja cheio. 
O problema consiste em encontrar uma sequencia de ações de forma a  encher  o  recipiente  maior    com  exatamente  4  litros.  
O  volume  que sobrar  no  recipiente  menor  não importa.*/


resolva:-
        estado_inicial(E),
	busca([[ramo(raiz,E)]],Solucao),
	imprima(Solucao).


busca([Solucao|_],Solucao):- atinge_meta(Solucao),!.

busca([T|Pilha],Solucao):- 
       ache_todos(Extensao,estende_ate_filho(T,Extensao),Extensoes),
       concatena(Extensoes,Pilha,Pilha_ext),
       busca(Pilha_ext,Solucao).

atinge_meta([ramo(_,M)|_]):-meta(M).

ache_todos(X,Y,Z):-findall(X,Y,Z),!.
ache_todos(_,_,[]).

estende_ate_filho([ramo(Ramo,N)|Trajetoria],
                  [ramo(Op,Filho),ramo(Ramo,N)|Trajetoria]):-
        transforma(N,Filho,Op),
        nao_produz_ciclos(Filho,Trajetoria).

nao_produz_ciclos(Estado,Trajetoria):-
        not(pertence(ramo(_,Estado),Trajetoria)).
        
pertence(X,[X|_]):-!.
pertence(X,[_|Y]):- pertence(X,Y).

concatena([],X,X):-!.
concatena([X|Y],Z,[X|W]):-concatena(Y,Z,W).
      
imprima([ramo(raiz,Raiz)]):- !, write('Estado inicial: '),write(Raiz),write('.').
imprima([ramo(Ramo,Nodo)|R]):-
	imprima(R),nl,write(Nodo),write(Ramo),write('.').


estado_inicial([0,0]).
meta([4,0]).

/* Esvaziamento */
/*Esvaziando o recipiente de 5*/
transforma([7,5],[7,0],esvazia).
transforma([0,5],[0,0],esvazia).
transforma([4,5],[4,0],esvazia).
/*Esvaziando o recipiente de 7*/
transforma([7,5],[0,5],esvazia).
transforma([7,5],[0,5],esvazia).

/*situações intermediarias*/
transforma([2,5],[0,5],esvazia).
transforma([2,5],[2,0],esvazia).
transforma([2,0],[0,0],esvazia).
transforma([0,2],[0,0],esvazia).
transforma([5,2],[5,0],esvazia).
transforma([5,2],[0,2],esvazia).


/*enchimento*/
transforma([0,0],[7,0],enche).
transforma([0,0],[0,5],enche).
transforma([0,2],[0,5],enche).
transforma([0,2],[7,2],enche).
transforma([0,5],[7,5],enche).
transforma([2,0],[7,0],enche).
transforma([2,0],[2,5],enche).
transforma([2,5],[7,5],enche).
transforma([2,5],[7,5],enche).
transforma([5,0],[7,0],enche).
transforma([7,0],[7,5],enche).
transforma([0,5],[7,5],enche).

transforma([0,2],[7,2],enche).
transforma([7,2],[7,5],enche).

transforma([5,0],[5,5],enche).
transforma([5,2],[5,5],enche).
transforma([5,5],[7,5],enche).
transforma([5,0],[7,0],enche).
transforma([5,0],[5,5],enche).
transforma([5,5],[7,5],enche).
transforma([7,0],[7,5],enche).
transforma([7,2],[7,5],enche).



/*transferencia*/
transforma([0,2],[2,0],transfere).
transforma([0,5],[5,0],transfere).
transforma([2,0],[0,2],transfere).
transforma([2,5],[7,0],transfere).
transforma([5,0],[0,5],transfere).
transforma([7,0],[2,5],transfere).
transforma([7,2],[4,5],transfere).