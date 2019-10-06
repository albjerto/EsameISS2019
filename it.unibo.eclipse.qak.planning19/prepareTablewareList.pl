%% fatto da noi
%% tableware da porre sul tavolo col comando prepare
%% modificare solo le quantità (l'ultimo campo)
%% lasciarlo a 0 se non si vuol prendere il tableware dalla pantry
%% ma NON cancellare la rule
%% quantità disponibile di ogni tableware visibile in pantryInit.pl

tablewareTable(piattoPiani,5)
tablewareTable(piattoFondi,5)
tablewareTable(bicchiere,5)
tablewareTable(forchetta,5)
tablewareTable(coltello,5)
tablewareTable(cucchiaio,5)

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

%% consuma randomicamente una certa quantità di ogni tableware
%% rand_int genera un random tra 0 e N-1 inclusi
randomTablewareConsumption :- tablewareTable(T,N), rand_int(N,R), R1 is R + 1, 
						 	  retract(tablewareTable(T,N)), N1 is N - R1, 
						 	  assert(tablewareTable(T,N1)), fail.
randomTablewareConsumption.

%% da provare dopo averla aggiornata con rand_int
%%randomTablewareConsumption :- forall(tablewareTable(T,N),doRandomTablewareConsumption(T,N)).
%%doRandomTablewareConsumption(T,N) :- tablewareTable(T,N), random_between(0,N,R), retract(tablewareTable(T,N)), N1 is N - R, assert(tablewareTable(T,N1)).
