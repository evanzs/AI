pertence(Element,[Element|Tail],Tail).
pertence(Element,[X|TAIL],Tail1):-pertence(Element,Tail,Tail1).
