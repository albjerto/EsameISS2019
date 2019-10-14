%% fatto da noi
%% funzioni di support alla gestione dishwasher

%% stato della dishwasher iniziale, ovviamente tutto azzerato
%% lo stato è aggiornato ad ogni randomConsumption dalla removeTablewareTable
%% (seguire le chiamate dalla correspondingTablewareConsumption) 
%% stato da NON editare manualmente
tablewareDishwasher(piattoPiano,0).
tablewareDishwasher(ciotola,0).
tablewareDishwasher(bicchiere,0).
tablewareDishwasher(forchetta,0).
tablewareDishwasher(coltello,0).
tablewareDishwasher(cucchiaio,0).

%% aggiorna stato del tavolo dopo una add tableware avvenuta con successo
%% implementata in caso si voglia effettuare il comportamento descritto nel
%% commento nello state addTable del centralstateserver
addTablewareDishwasher(T,N) :- tablewareDishwasher(T,N1), 
							   retract(tablewareDishwasher(T,N1)), 
						  	   N2 is N1 + N, assert(tablewareDishwasher(T,N2)).

%% print dello stato, restituisce i tableware presenti nella dishwasher solo se 
%% è prima stata invocata la clear, dato che con essa è stata fatta l'assert di 
%% dishwasherEnabled(true)
showDishwasherState :- dishwasherEnabled(true), tablewareDishwasher(T,N), 
					  outputDishwasher(tablewareDishwasher(T,N)), fail.
showDishwasherState.			
outputDishwasher(tablewareDishwasher(T,N)) :- stdout <- print(T), 
											  stdout <- print(' '), 
								 			  stdout <- println(N).

%% genera la stringa contenente lo stato della dishwasher (da parsare lato kotlin)
getDishwasherState(L) :- findall([T,N],multipleDishwasherGoal(T,N),L).
multipleDishwasherGoal(T,N) :- dishwasherEnabled(true),tablewareDishwasher(T,N).