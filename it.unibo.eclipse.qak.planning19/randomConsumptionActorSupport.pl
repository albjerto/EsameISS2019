%% fatto da noi
%% comprende le funzionalità di supporto al randomconsumptionactor
%% per attivare la randomConsumption porre true nella regola sottostante
%% minSeconds e maxSeconds vanno editati con l'estremo inferiore e 
%% superiore per il calcolo del delay
%% random con cui si generano le consumazioni randomiche
%% numFoods va editato col numero dei cibi utilizzati al momento
%% i cibi stessi vanno commentati o decommentati in base all'uso (se
%% necessario aggiornare la numerazione)

%%%%%%%%%%%%%%% config %%%%%%%%%%%%%%%%%%

randomConsumptionEnabled(false).

minSeconds(5).
maxSeconds(60).

numFoods(12).

food(succoBuono,0).
food(acquaGelidaImbevibile,1).
food(peschePescate,2).
food(meleMlem,3).
food(pomodoriComePatatine,4).
food(caroteCheSuccedeAmico,5).
food(coppaDeiCampioni,6).
food(mortazzaDelVanish,7).
food(quelleRobePastaSfogliaEWurstel,8).
food(piadaDelParco,9).
food(pannaCottaPoco,10).
food(cheeseCakeHoFame,11).
%% food(birraBella,12).
%% food(punchNeiDenti,13).
%% food(meloneVerdeImmaturo,14).
%% food(ravanelliXtraSpicy,15).
%% food(salameGrassissimo,16).
%% food(prosciuttoTroppoCostoso,17).
%% food(pizzetteCompleanno,18).
%% food(mascarponeDaMontagna,19).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% predicati %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% determina il delay random con cui sono inviate le consumazioni
getRandomDelay(R) :- maxSeconds(N), N1 is N + 1, rand_int(N1,R1), 
					 checkMinSecondsCompliance(R1,R).
checkMinSecondsCompliance(R1,R) :- minSeconds(N), R1 < N, !, R is N.
checkMinSecondsCompliance(R1,R) :- R is R1.

%% produce il messaggio di consumazione random, al momento non è
%% randomizzata la quantità (anche per non esagerare con le consumazioni)
produceRandomFoodMessage([food(F,1)]) :- numFoods(N), rand_int(N,R), food(F,R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
