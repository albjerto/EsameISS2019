%% fatto da noi
%% cibo da porre sul tavolo col comando prepare
%% nome, codice, quantità disponibile di ogni cibo visibile in fridgeInit.pl
%% (al momento presenti tutti i cibi, non in massima quantità)
%% consigliabile modificare solo le quantità lasciando a 0 ciò che non si vuole prendere

%% bevande
foodPrepare(succoBuono,b01,3).
foodPrepare(birraBella,b02,3).
foodPrepare(acquaGelidaImbevibile,b03,3).
foodPrepare(punchNeiDenti,b04,3).

%% frutta
foodPrepare(meloneVerdeImmaturo,f01,3).
foodPrepare(peschePescate,f02,3).
foodPrepare(meleMlem,f03,3).

%% verdura
foodPrepare(pomodoriComePatatine,v01,3).
foodPrepare(caroteCheSuccedeAmico,v02,3).
foodPrepare(ravanelliXtraSpicy,v03,3).

%% affettato
foodPrepare(salameGrassissimo,a01,3).
foodPrepare(prosciuttoTroppoCostoso,a02,3).
foodPrepare(coppaDeiCampioni,a03,3).
foodPrepare(mortazzaDelVanish,a04,3).

%% salato
foodPrepare(pizzetteCompleanno,s01,3).
foodPrepare(quelleRobePastaSfogliaEWurstel,s02,3).
foodPrepare(piadaDelParco,s03,3).

%% dolci
foodPrepare(pannaCottaPoco,d01,3).
foodPrepare(mascarponeDaMontagna,d02,3).
foodPrepare(cheeseCakeHoFame,d03,3).

%% print dei cibi nella prepareFoodList (NON stampa eventuali cibi che non si vogliono prendere)
showPrepareFoodList :- foodPrepare(F,C,N), N > 0, outputFoodPrepare(F,N), fail.
showPrepareFoodList.			
outputFoodPrepare(F,N) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% genera la lista con elementi [nome, quantità] dei cibi richiesti 
%% (NON considera cibi che non si vogliono prendere) (da parsare lato kotlin)
getPrepareFoodListByName(L) :- findall([F,N], multipleNameGoal(F,N), L).
multipleNameGoal(F,N) :- foodPrepare(F,_,N), N > 0.

%% genera la lista con elementi [codice, quantità] dei cibi richiesti 
%% (NON considera cibi che non si vogliono prendere) (da parsare lato kotlin)
getPrepareFoodListByCode(L) :- findall([C,N], multipleCodeGoal(C,N), L).
multipleCodeGoal(C,N) :- foodPrepare(_,C,N), N > 0.

%% genera la lista con elementi [nome, codice, quantità] dei cibi richiesti 
%% (NON considera cibi che non si vogliono prendere) (da parsare lato kotlin)
getPrepareFoodListByName(L) :- findall([F,C,N], multipleNameAndCodeGoal(F,C,N), L).
multipleNameAndCodeGoal(F,C,N) :- foodPrepare(F,C,N), N > 0.
