%% fatto da noi
%% cibo da porre sul tavolo col comando prepare
%% nome, codice, quantità disponibile di ogni cibo visibile in fridgeInit.pl
%% (al momento presenti tutti i cibi, non in massima quantità)
%% consigliabile modificare solo le quantità lasciando a 0 ciò che non si vuole prendere

%% bevande
toPrepare(food(succoBuono,b01,3)).
%% toPrepare(food(birraBella,b02,3)).
toPrepare(food(acquaGelidaImbevibile,b03,3)).
%% toPrepare(food(punchNeiDenti,b04,3)).

%% frutta
%% toPrepare(food(meloneVerdeImmaturo,f01,3)).
toPrepare(food(peschePescate,f02,3)).
toPrepare(food(meleMlem,f03,3)).

%% verdura
toPrepare(food(pomodoriComePatatine,v01,3)).
toPrepare(food(caroteCheSuccedeAmico,v02,3)).
%% toPrepare(food(ravanelliXtraSpicy,v03,3)).

%% affettato
%% toPrepare(food(salameGrassissimo,a01,3)).
%% toPrepare(food(prosciuttoTroppoCostoso,a02,3)).
toPrepare(food(coppaDeiCampioni,a03,3)).
toPrepare(food(mortazzaDelVanish,a04,3)).

%% salato
%% toPrepare(food(pizzetteCompleanno,s01,3)).
toPrepare(food(quelleRobePastaSfogliaEWurstel,s02,3)).
toPrepare(food(piadaDelParco,s03,3)).

%% dolci
toPrepare(food(pannaCottaPoco,d01,3)).
%% toPrepare(food(mascarponeDaMontagna,d02,3)).
toPrepare(food(cheeseCakeHoFame,d03,3)).

%% print dei cibi nella prepareFoodList (NON stampa eventuali cibi che non si vogliono prendere)
showPrepareFoodList :- food(F,C,N), N > 0, outputFood(F,N), fail.
showPrepareFoodList.			
outputFood(F,N) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% genera la lista con elementi food(nome, quantità) dei cibi richiesti 
%% (NON considera cibi che non si vogliono prendere) (da parsare lato kotlin)
getPrepareFoodListByName(L) :- findall(food(F,N), multipleNameGoal(F,N), L).
multipleNameGoal(F,N) :- food(F,_,N), N > 0.

%% genera la lista con elementi food(codice, quantità) dei cibi richiesti 
%% (NON considera cibi che non si vogliono prendere) (da parsare lato kotlin)
getPrepareFoodListByCode(L) :- findall(food(C,N), multipleCodeGoal(C,N), L).
multipleCodeGoal(C,N) :- food(_,C,N), N > 0.

%% genera la lista con elementi food(nome, codice, quantità) dei cibi richiesti 
%% (NON considera cibi che non si vogliono prendere) (da parsare lato kotlin)
getPrepareFoodListByNameAndCode(L) :- findall(food(F,C,N), multipleNameAndCodeGoal(F,C,N), L).
multipleNameAndCodeGoal(F,C,N) :- food(F,C,N), N > 0.
