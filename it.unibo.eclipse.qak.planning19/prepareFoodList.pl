%% fatto da noi
%% cibo da porre sul tavolo col comando prepare
%% modificare solo le quantità (l'ultimo campo)
%% lasciarlo a 0 se non si vuol prendere il cibo dal frigo
%% ma NON cancellare la rule
%% quantità disponibile di ogni cibo visibile in fridgeInit.pl

%% bevande
foodTable(succoBuono,b01,3).
foodTable(birraBella,b02,3).
foodTable(acquaGelidaImbevibile,b03,3).
foodTable(punchNeiDenti,b04,3).

%% frutta
foodTable(meloneVerdeImmaturo,f01,3).
foodTable(peschePescate,f02,3).
foodTable(meleMlem,f03,3).

%% verdura
foodTable(pomodoriComePatatine,v01,3).
foodTable(caroteCheSuccedeAmico,v02,3).
foodTable(ravanelliXtraSpicy,v03,3).

%% affettato
foodTable(salameGrassissimo,a01,3).
foodTable(prosciuttoTroppoCostoso,a02,3).
foodTable(coppaDeiCampioni,a03,3).
foodTable(mortazzaDelVanish,a04,3).

%% salato
foodTable(pizzetteCompleanno,s01,3).
foodTable(quelleRobePastaSfogliaEWurstel,s02,3).
foodTable(piadaDelParco,s03,3).

%% dolci
foodTable(pannaCottaPoco,d01,3).
foodTable(mascarponeDaMontagna,d02,3).
foodTable(cheeseCakeHoFame,d03,3).

%% print dello stato, restituisce i cibi presenti solo se è prima stata invocata
%% la prepare, dato che con essa è stata fatta l'assert di enabled(true)
%% tolto check N > 0, mostro anche i cibi terminati per chiarezza
showFoodTableState :- enabled(true), foodTable(F,C,N), outputTable(foodTable(F,C,N)), fail.
showFoodTableState.			
outputTable(foodTable(F,C,N)) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente lo stato del tavolo (da parsare lato kotlin)
getFoodTableState(L) :- findall([F,N],multipleGoal(F,N),L).
multipleGoal(F,N) :- enabled(true),foodTable(F,_,N).

%% aggiorna stato del tavolo dopo una add avvenuta con successo
addTable(C,N) :- foodTable(F,C,N1), retract(foodTable(F,C,N1)), N2 is N1 + N, assert(foodTable(F,C,N2)).

%% consuma randomicamente una certa quantità di ogni cibo
%% rand_int genera un random tra 0 e N-1 inclusi
randomFoodConsumption :- foodTable(F,C,N), rand_int(N,R), R1 is R + 1, 
						 retract(foodTable(F,C,N)), N1 is N - R1, 
						 assert(foodTable(F,C,N1)), fail.
randomFoodConsumption.

%% da provare dopo averla aggiornata con rand_int
%%randomFoodConsumption :- forall(foodTable(F,C,N),doRandomConsume(F,C,N)).
%%doRandomFoodConsumption(F,C,N) :- foodTable(F,C,N), random_between(0,N,R), retract(foodTable(F,C,N)), N1 is N - R, assert(foodTable(F,C,N1)).
