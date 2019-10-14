%% fatto da noi
%% tableware da porre sul tavolo col comando prepare
%% modificare solo le quantità (l'ultimo campo) di tablewareTable
%% lasciarlo a 0 se non si vuol prendere il tableware dalla pantry
%% ma NON cancellare la rule
%% quantità disponibile di ogni tableware visibile in pantryInit.pl

tablewareTable(piattoPiano,5).
tablewareTable(ciotola,5).
tablewareTable(bicchiere,5).
tablewareTable(forchetta,5).
tablewareTable(coltello,5).
tablewareTable(cucchiaio,5).

%% ty albi
corresponding(b01,[bicchiere]).
corresponding(b02,[bicchiere]).
corresponding(b03,[bicchiere]).
corresponding(b04,[bicchiere]).
corresponding(f01,[ciotola,coltello]).
corresponding(f02,[ciotola,coltello]).
corresponding(f03,[ciotola,coltello]).
corresponding(v01,[ciotola,coltello]).
corresponding(v02,[ciotola,coltello]).
corresponding(v03,[ciotola,coltello]).
corresponding(a01,[piattoPiano,forchetta]).
corresponding(a02,[piattoPiano,forchetta]).
corresponding(a03,[piattoPiano,forchetta]).
corresponding(a04,[piattoPiano,forchetta]).
corresponding(s01,[piattoPiano,forchetta]).
corresponding(s02,[piattoPiano,forchetta]).
corresponding(s03,[piattoPiano,forchetta]).
corresponding(d01,[piattoPiano,cucchiaio]).
corresponding(d02,[piattoPiano,cucchiaio]).
corresponding(d03,[piattoPiano,cucchiaio]).

%% print dello stato, restituisce i tableware presenti solo se è prima stata 
%% invocata la prepare, dato che con essa è stata fatta l'assert di enabled(true)
%% tolto check N > 0, mostro anche i tableware terminati per chiarezza
showTablewareTableState :- enabled(true), tablewareTable(T,N), 
						   outputTablewareTable(tablewareTable(T,N)), fail.
showTablewareTableState.			
outputTablewareTable(tablewareTable(T,N)) :- stdout <- print(T), 
											 stdout <- print(' '), 
											 stdout <- println(N).
											 
%% genera la stringa contenente lo stato del tablewareTable (da parsare lato kotlin)
getTablewareTableState(L) :- findall([T,N],multipleTablewareGoal(T,N),L).
multipleTablewareGoal(T,N) :- enabled(true),tablewareTable(T,N).

%% aggiorna stato del tavolo dopo una add tableware avvenuta con successo
%% implementata in caso si voglia effettuare il comportamento descritto nel
%% commento nello state addTable del centralstateserver
addTablewareTable(T,N) :- tablewareTable(T,N1), retract(tablewareTable(T,N1)), 
						  N2 is N1 + N, assert(tablewareTable(T,N2)).

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

%% non utilizzata, fa tutto randomConsumption in prepareFoodList.pl
%% consuma randomicamente una certa quantità di ogni tableware
%% rand_int genera un random tra 0 e N-1 inclusi
%%randomTablewareConsumption :- tablewareTable(T,N), N1 is N + 1, rand_int(N1,R), 
%%						 	  retract(tablewareTable(T,N)), N2 is N - R, 
%%						 	  assert(tablewareTable(T,N2)), fail.
%%randomTablewareConsumption.

%% per consumare i tableware corrispondenti al food appena consumato dalla
%% randomFoodConsumption
correspondingTablewareConsumption(C,N) :- corresponding(C,[H|T]), 
										  listConsumption([H|T],N).

%% per consumare ogni elemento della lista associata ad un particolare cibo 
%% dal predicato corresponding
listConsumption([],N).
listConsumption([H],N) :- !, removeTablewareTable(H,N).
listConsumption([H|T],N) :- removeTablewareTable(H,N), listConsumption(T,N).

%% da provare dopo averla aggiornata con rand_int
%%randomTablewareConsumption :- forall(tablewareTable(T,N),doRandomTablewareConsumption(T,N)).
%%doRandomTablewareConsumption(T,N) :- tablewareTable(T,N), random_between(0,N,R), retract(tablewareTable(T,N)), N1 is N - R, assert(tablewareTable(T,N1)).
