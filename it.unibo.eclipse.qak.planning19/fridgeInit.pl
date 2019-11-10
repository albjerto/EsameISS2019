%% fatto da noi
%% cibi inizialmente nel frigo
%% cibo reso come food(nome, foodCode, quantità)

%% bevande
food(succoBuono,b01,5).
%% food(birraBella,b02,5).
food(acquaGelidaImbevibile,b03,5).
%% food(punchNeiDenti,b04,5).

%% frutta
%% food(meloneVerdeImmaturo,f01,5).
food(peschePescate,f02,5).
food(meleMlem,f03,5).

%% verdura
food(pomodoriComePatatine,v01,5).
food(caroteCheSuccedeAmico,v02,5).
%% food(ravanelliXtraSpicy,v03,5).

%% affettato
%% food(salameGrassissimo,a01,5).
%% food(prosciuttoTroppoCostoso,a02,5).
food(coppaDeiCampioni,a03,5).
food(mortazzaDelVanish,a04,5).

%% salato
%% food(pizzetteCompleanno,s01,5).
food(quelleRobePastaSfogliaEWurstel,s02,5).
food(piadaDelParco,s03,5).

%% dolci
food(pannaCottaPoco,d01,5).
%% food(mascarponeDaMontagna,d02,5).
food(cheeseCakeHoFame,d03,5).

%% print dello stato (stampa anche cibi terminati)
showFridgeState :- food(F,C,N), outputFood(F,N), fail.
showFridgeState.
outputFood(F,N) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% genera la lista contenente lo stato del frigo (comprende eventuali cibi terminati) (da parsare lato kotlin)
getFridgeState(L) :- findall(food(F,N), food(F,_,N), L).

%% controllo presenza cibo con nome F
isThereFoodByName(F) :- food(F,_,N), N > 0.
%% controllo presenza cibo con code C
isThereFoodByCode(C) :- food(_,C,N), N > 0.

%% rimozione dal frigo dei cibi specificati nella lista passata come argomento (per la prepare)
removeFoodList([]).
removeFoodList([food(F,N)]) :- !, getFoodByName(F,N).
removeFoodList([food(F,N)|T]) :- getFoodByName(F,N), removeFoodList(T).

%% ritiro di una quantità N del cibo con nome F
getFoodByName(F,N) :- food(F,C,N1), N1 >= N, retract(food(F,C,N1)), N2 is N1 - N, assert(food(F,C,N2)).
%% ritiro di una quantità N del cibo con code C
getFoodByCode(C,N) :- food(F,C,N1), N1 >= N, retract(food(F,C,N1)), N2 is N1 - N, assert(food(F,C,N2)).

%% aggiunta nel frigo dei cibi specificati nella lista passata come argomento (per la clear)
addFoodList([]).
addFoodList([food(F,N)]) :- !, putFoodByName(F,N).
addFoodList([food(F,N)|T]) :- putFoodByName(F,N), addFoodList(T).

%% aggiunta di una quantità N del cibo con code C
putFoodByName(F,N) :- food(F,C,N1), retract(food(F,C,N1)), N2 is N1 + N, assert(food(F,C,N2)).
%% aggiunta di una quantità N del cibo con code C
putFoodByCode(C,N) :- food(F,C,N1), retract(food(F,C,N1)), N2 is N1 + N, assert(food(F,C,N2)).
