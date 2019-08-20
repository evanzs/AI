%1.Retirar todas as ocorrências de um elemento de uma lista:
retirar_ocor(_,[],[]).
retirar_ocor(OC,[OC|T],L):-retirar_ocor(OC,T,L).
retirar_ocor(OC,[Y|T],[Y|T1]):-retirar_ocor(OC,T,T1).

%2.Retirar elementos repitidos de uma lista:


%3.Concatenar duas listas quaisquer:
concatenar([],List,List1).
concatenar([Head|Tail],List,[Head|Tail1]):-concatenar(Tail,List, Tail1).


%4.Encontrar o maior elemento de uma lista numérica:menor(Lista, Elemento ).
menor([],Element).
menor([Element,Element1|Tail],Element1):-Element >= Element1,menor(Tail,Element).
menor([Element,Element1|Tail],Element).

%5.Encontrar o menor elemento de uma lista numérica:Maior (Lista, Elemento ).
maior([],Element).
maior([Element,Element1|Tail],Element):-Element > Element1,maior(Tail,Element).
maior([Element,Element1|Tail],Element1).

%6.Pegar elementos de uma lista dada a lista de suas posições:pegar (Lista_posições, Lista, Lista_resultante)


%7.Inserir elemento na primeira posição de uma lista: inserir_cabeça ( E, Lista. Lista_resultante).
inserir_cabeça(Element, List,[Element|List]).


%8.Inserir elemento na última posição de uma lista: inserir_ultimo ( Elemento, Lista. Lista_resultante )
inserir_ultimo(Element,[], [Element]).
insererir_ultimo(Element, [Head|Tail],[Head|Tail1]):-inserir_ultimo(Element,Tail,Tail1).

%9. Inserir elemento numa posição N da lista: inserir_N (Elemento, N, Lista, Lista_resultante)
insere_N(Element,N,List,[Element|List1]).
insere_N(Element,N,[Tail|List1],[Tail|Tail1]):-N1 is N-1, insere_N(Element,N1,List,Tail1)

%10.Inverter uma lista: inverter (Lista, Lista_resultante).
inverter([],[]).
inverter([Element],[Element]).
inverter([Head|List],List1):-inverter(List,List1),concatenar(List1,[Head],List1).

%11.Substituir um elemento de uma lista por outro elemento: substitui (X, Y, Lista, Lista_resultante)
substitui(_,_,[],[]).
substitui(Element,Element1,[Element|List],[Element1|List1]):-substitui(Element,Element1,List,List1).
substitui(Element,Element1,[Element2|List],[Element2|List1]):-substitui(Element,Element1,List,List1).

%12.Duplicar um elemento de uma lista: duplicar_um (Elemento, Lista, Lista_resultante)
duplica_um(Element,[],List).
duplica_um([Element,Element1|Tail],List,[Element,Elemenet,Tail]):-Element == Element1.
duplica_um([Element,Element1|Tail],List,List2).


%13 Duplicar elementos de uma lista: duplicar_todos (Lista, Lista_resultante)
duplica_todos([],[]).
duplica_todos([Element|Element1],[Element,Element|Element2]) :- duplica_todos(Element1,Element2).

