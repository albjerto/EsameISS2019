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
food(ravanelliSpicyAf,v03,5).

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
showState :- food(F,C,N), N > 0, output(food(F,C,N)), fail.
showState.			
output(food(F,C,N)) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% controllo presenza cibo con code C
isThere(C) :- food(_,C,N), N > 0.

%% ritiro di una quantità N del cibo con code C
get(C,N) :- food(F,C,N1), N1 >= N, retract(food(F,C,N1)), N2 is N1 - N, assert(food(F,C,N2)).

%% aggiunta di una quantità N del cibo con code C
put(C,N) :- food(F,C,N1), retract(food(F,C,N1)), N2 is N1 + N, assert(food(F,C,N2))

%% prepare, pone sul tavolo i cibi specificati in prepareFoodList.pl
prepare :- foodTable(C,N), get(C,N), fail.
prepare.
