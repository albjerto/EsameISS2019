%% fatto da noi
%% cibi inizialmente nel frigo
%% cibo reso come food(nome, foodCode, quantità)

%% bevande
food(succoBuono,b01,5).
food(birraBella,b02,5).
food(acquaGelidaImbevibile,b03,5).
food(punchNeiDenti,b04,5).

%% frutta
food(meloneVerdeImmaturo,f01,5).
food(peschePescate,f02,5).
food(meleMlem,f03,5).

%% verdura
food(pomodoriComePatatine,v01,5).
food(caroteCheSuccedeAmico,v02,5).
food(ravanelliXtraSpicy,v03,5).

%% affettato
food(salameGrassissimo,a01,5).
food(prosciuttoTroppoCostoso,a02,5).
food(coppaDeiCampioni,a03,5).
food(mortazzaDelVanish,a04,5).

%% salato
food(pizzetteCompleanno,s01,5).
food(quelleRobePastaSfogliaEWurstel,s02,5).
food(piadaDelParco,s03,5).

%% dolci
food(pannaCottaPoco,d01,5).
food(mascarponeDaMontagna,d02,5).
food(cheeseCakeHoFame,d03,5).

%% print dello stato
showFridgeState :- food(F,C,N), N > 0, outputFridge(food(F,C,N)), fail.
showFridgeState.			
outputFridge(food(F,C,N)) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente lo stato del frigo (da parsare lato kotlin)
getFridgeState(L) :- findall([F,N],food(F,_,N),L).

%% per non dimenticare
%%getFridgeStateString(S) :- food(F,C,N), N > 0, atom_concat(F,' ',I1), 
%%							number_codes(N,C1), atom_codes(A,C1), atom_concat(I1,A,I2), 
%%							atom_concat(I2,' | ',I3), retract(food(F,C,N)), 
%%							getFridgeStateString(S1), atom_concat(I3,S1,S), 
%%							assertz(food(F,C,N)).
%%getFridgeStateString(S) :- loopEnder(S).
%%loopEnder('|'). %% altrimenti l'ultimo S1 non è un atomo

%% controllo presenza cibo con code C
isThere(C) :- food(_,C,N), N > 0.

%% ritiro di una quantità N del cibo con code C
get(C,N) :- food(F,C,N1), N1 >= N, retract(food(F,C,N1)), N2 is N1 - N, assert(food(F,C,N2)).

%% aggiunta di una quantità N del cibo con code C
put(C,N) :- food(F,C,N1), retract(food(F,C,N1)), N2 is N1 + N, assert(food(F,C,N2))

%% prepare, pone sul tavolo i cibi specificati in prepareFoodList.pl
prepare :- foodTable(_,C,N), get(C,N), fail.
prepare.
