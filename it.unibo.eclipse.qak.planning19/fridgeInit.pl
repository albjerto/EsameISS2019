%% fatto da noi
%% comprende le funzionalità del tavolo

%%%%%%%%%%%%%%%%%%%%%%%%%% roba generica %%%%%%%%%%%%%%%%%%%%%%%%%%

%% rimuove dal tavolo tutti gli item specificati, che siano food o tableware
removeGenericList([]).
removeGenericList([food(F,N)]) :- !, getFood(F,N).
removeGenericList([tableware(T,N)]) :- !, getTableware(T,N).
removeGenericList([food(F,N)|T]) :- !, getFood(F,N), removeGenericList(T).
removeGenericList([tableware(T,N)|T1]) :- getTableware(T,N), removeGenericList(T1).

%% più elegante ma not sure che vada per il verso così
%%removeGenericList([]).
%%removeGenericList([H]) :- removeFoodList(H).
%%removeGenericList([H]) :- removeTablewareList(H).
%%removeGenericList([H|T]) :- removeFoodList(H), !, removeGenericList(T).
%%removeGenericList([H|T]) :- removeTablewareList(H), removeGenericList(T).

%% aggiunge al tavolo tutti gli item specificati, che siano food o tableware
addGenericList([]).
addGenericList([food(F,N)]) :- !, putFood(F,N).
addGenericList([tableware(T,N)]) :- !, putTableware(T,N).
addGenericList([food(F,N)|T]) :- !, putFood(F,N), addGenericList(T).
addGenericList([tableware(T,N)|T1]) :- putTableware(T,N), addGenericList(T1).

%% più elegante ma not sure che vada per il verso così
%%addGenericList([]).
%%addGenericList([H]) :- addFoodList(H).
%%addGenericList([H]) :- addTablewareList(H).
%%addGenericList([H|T]) :- addFoodList(H), !, addGenericList(T).
%%addGenericList([H|T]) :- addTablewareList(H), addGenericList(T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% roba relativa ai cibi %%%%%%%%%%%%%%%%%%%%%%%%

%% print dei cibi sul tavolo (stampa anche eventuali cibi terminati)
showFoodTableState :- food(F,N), outputFood(F,N), fail.
showFoodTableState.			
outputFood(F,N) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente lo stato dei cibi sul tavolo (comprende anche eventuali cibi terminati) (da parsare lato kotlin)
getFoodTableState(L) :- findall([F,N], food(F,N), L).

%% rimozione dal tavolo dei cibi specificati nella lista passata come argomento (per il consumo random?)
removeFoodList([]).
removeFoodList([food(F,N)]) :- !, getFood(F,N).
removeFoodList([food(F,N)|T]) :- getFood(F,N), removeFoodList(T).

%% rimozione di una quantità N del cibo F
getFood(F,N) :- food(F,N1), retract(food(F,N1)), N2 is N1 - N, assert(food(F,N2)).

%% aggiunta sul tavolo dei cibi specificati nella lista passata come argomento (per la prepare)
addFoodList([]).
addFoodList([food(F,N)]) :- !, putFood(F,N).
addFoodList([food(F,N)|T]) :- putFood(F,N), addFoodList(T).

%% aggiunta di una quantità N del cibo F 
%% (previste due regole per supportare il caso di una aggiunta di cibo non presente al momento, caso possibile solo se l'utente decide
%% di cancellare elementi dalla prepareFoodList anzichè aggiornare solo le quantità)
putFood(F,N) :- food(F,N1), !, retract(food(F,N1)), N2 is N1 + N, assert(food(F,N2)).
putFood(F,N) :- assert(food(F,N)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% roba relativa ai tableware %%%%%%%%%%%%%%%%%%%%%

%% print dei tableware sul tavolo (stampa anche eventuali tableware terminati)
showTablewareTableState :- tableware(T,N), outputTableware(T,N), fail.
showTablewareTableState.			
outputTableware(T,N) :- stdout <- print(T), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente lo stato dei tableware sul tavolo (comprende eventuali tableware terminati) (da parsare lato kotlin)
getTablewareTableState(L) :- findall(tableware(T,N), tableware(T,N), L).

%% rimozione dal tavolo dei tableware specificati nella lista passata come argomento (per il consumo random?)
removeTablewareList([]).
removeTablewareList([tableware(T,N)]) :- !, getTableware(T,N).
removeTablewareList([tableware(T,N)|T1]) :- getTableware(T,N), removeTablewareList(T1).

%% rimozione di una quantità N del tableware T
getTableware(T,N) :- tableware(T,N1), retract(tableware(T,N1)), N2 is N1 - N, assert(tableware(T,N2)).

%% aggiunta sul tavolo dei tableware specificati nella lista passata come argomento (per la prepare)
addTablewareList([]).
addTablewareList([tableware(T,N)]) :- !, putTableware(T,N).
addTablewareList([tableware(T,N)|T]) :- putTableware(T,N), addTablewareList(T).

%% aggiunta di una quantità N del tableware T 
%% (previste due regole per supportare il caso di una aggiunta di tableware non presente al momento, caso possibile solo se l'utente decide
%% di cancellare elementi dalla prepareTablewareList anzichè aggiornare solo le quantità)
putTableware(T,N) :- tableware(T,N1), !, retract(tableware(T,N1)), N2 is N1 + N, assert(tableware(T,N2)).
putTableware(T,N) :- assert(tableware(T,N)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%% roba randomConsumption %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tutta roba che non so se dovrà essere utilizzata (also al momento errata), per ora la smollo qui

corresponding(succoBuono,[bicchiere]).
corresponding(birraBella,[bicchiere]).
corresponding(acquaGelidaImbevibile,[bicchiere]).
corresponding(punchNeiDenti,[bicchiere]).
corresponding(meloneVerdeImmaturo,[ciotola,coltello]).
corresponding(peschePescate,[ciotola,coltello]).
corresponding(meleMlem,[ciotola,coltello]).
corresponding(pomodoriComePatatine,[ciotola,coltello]).
corresponding(caroteCheSuccedeAmico,[ciotola,coltello]).
corresponding(ravanelliXtraSpicy,[ciotola,coltello]).
corresponding(salameGrassissimo,[piattoPiano,forchetta]).
corresponding(prosciuttoTroppoCostoso,[piattoPiano,forchetta]).
corresponding(coppaDeiCampioni,[piattoPiano,forchetta]).
corresponding(mortazzaDelVanish,[piattoPiano,forchetta]).
corresponding(pizzetteCompleanno,[piattoPiano,forchetta]).
corresponding(quelleRobePastaSfogliaEWurstel,[piattoPiano,forchetta]).
corresponding(piadaDelParco,[piattoPiano,forchetta]).
corresponding(pannaCottaPoco,[piattoPiano,cucchiaio]).
corresponding(mascarponeDaMontagna,[piattoPiano,cucchiaio]).
corresponding(cheeseCakeHoFame,[piattoPiano,cucchiaio]).

%% consuma randomicamente una certa quantità di ogni cibo e dei relativi
%% tableware, vedi correspondingTablewareConsumption
%% rand_int genera un random tra 0 e N-1 inclusi
randomConsumption :- foodTable(F,C,N), N1 is N + 1, rand_int(N1,R), 
						 retract(foodTable(F,C,N)), N2 is N - R, 
						 assert(foodTable(F,C,N2)), 
						 correspondingTablewareConsumption(C,R), fail.
randomConsumption.

%% da provare dopo averla aggiornata con rand_int
%%randomFoodConsumption :- forall(foodTable(F,C,N),doRandomFoodConsumption(F,C,N)).
%%doRandomFoodConsumption(F,C,N) :- foodTable(F,C,N), random_between(0,N,R), retract(foodTable(F,C,N)), N1 is N - R, assert(foodTable(F,C,N1)).

%% per consumare i tableware corrispondenti al food appena consumato dalla
%% randomFoodConsumption
correspondingTablewareConsumption(C,N) :- corresponding(C,[H|T]), 
										  listConsumption([H|T],N).

%% per consumare ogni elemento della lista associata ad un particolare cibo 
%% dal predicato corresponding
listConsumption([],N).
listConsumption([H],N) :- !, removeTablewareTable(H,N).
listConsumption([H|T],N) :- removeTablewareTable(H,N), listConsumption(T,N).

%% usata nella correspondingTablewareConsumption
%% NB i tableware consumati sono quelli che finiranno nella dishwasher quindi
%% già da ora gestisco anche i tablewareDishwasher in modo che alla clear io
%% abbia già lo stato della dishwasher creato e debba solo renderlo visibile
%% tramite una assert(dishwasherEnabled(true))
%% addTablewareDishwasher in dishwasherSupport.pl
removeTablewareTable(T,N) :- tablewareTable(T,N1), N1 >= N, 
							 retract(tablewareTable(T,N1)), N2 is N1 - N, 
							 assert(tablewareTable(T,N2)),
							 addTablewareDishwasher(T,N).

%% non utilizzata, fa tutto randomConsumption
%% consuma randomicamente una certa quantità di ogni tableware
%% rand_int genera un random tra 0 e N-1 inclusi
%%randomTablewareConsumption :- tablewareTable(T,N), N1 is N + 1, rand_int(N1,R), 
%%						 	  retract(tablewareTable(T,N)), N2 is N - R, 
%%						 	  assert(tablewareTable(T,N2)), fail.
%%randomTablewareConsumption.

%% da provare dopo averla aggiornata con rand_int
%%randomTablewareConsumption :- forall(tablewareTable(T,N),doRandomTablewareConsumption(T,N)).
%%doRandomTablewareConsumption(T,N) :- tablewareTable(T,N), random_between(0,N,R), retract(tablewareTable(T,N)), N1 is N - R, assert(tablewareTable(T,N1)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
