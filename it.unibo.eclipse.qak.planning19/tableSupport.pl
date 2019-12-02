%% fatto da noi
%% comprende le funzionalità del tavolo

%%%%%%%%%%%%%%%%%%%%%%%%%% roba generica %%%%%%%%%%%%%%%%%%%%%%%%%%

%% rimuove dal tavolo tutti gli item specificati, che siano food o tableware
removeGenericList([]).
removeGenericList([food(F,N)]) :- !, getFood(F,N).
removeGenericList([tableware(T,N)]) :- !, getTableware(T,N).
removeGenericList([food(F,N)|T]) :- getFood(F,N), removeGenericList(T).
removeGenericList([tableware(T,N)|T1]) :- getTableware(T,N), removeGenericList(T1).

%% aggiunge al tavolo tutti gli item specificati, che siano food o tableware
addGenericList([]).
addGenericList([food(F,N)]) :- !, putFood(F,N).
addGenericList([tableware(T,N)]) :- !, putTableware(T,N).
addGenericList([food(F,N)|T]) :- putFood(F,N), addGenericList(T).
addGenericList([tableware(T,N)|T1]) :- putTableware(T,N), addGenericList(T1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% roba relativa ai cibi %%%%%%%%%%%%%%%%%%%%%%%%

%% print dei cibi sul tavolo (stampa anche eventuali cibi terminati)
showFoodTableState :- food(F,N), outputFood(F,N), fail.
showFoodTableState.			
outputFood(F,N) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente lo stato dei cibi sul tavolo (comprende anche eventuali cibi terminati) (da parsare lato kotlin)
getFoodTableState(L) :- findall(food(F,N), food(F,N), L).

%% rimozione dal tavolo dei cibi specificati nella lista passata come argomento (per il consumo random?)
removeFoodList([]).
removeFoodList([food(F,N)]) :- !, getFood(F,N).
removeFoodList([food(F,N)|T]) :- getFood(F,N), removeFoodList(T).

%% rimozione di una quantità N del cibo F
getFood(F,N) :- food(F,N1), N1 >= N, retract(food(F,N1)), N2 is N1 - N, assert(food(F,N2)).

%% aggiunta sul tavolo dei cibi specificati nella lista passata come argomento (per la prepare)
addFoodList([]).
addFoodList([food(F,N)]) :- !, putFood(F,N).
addFoodList([food(F,N)|T]) :- putFood(F,N), addFoodList(T).

%% aggiunta di una quantità N del cibo F 
%% (previste due regole per supportare il caso di una aggiunta di cibo non presente al momento, caso possibile solo se l'utente decide
%% di cancellare elementi dalla prepareFoodList anzichè aggiornare solo le quantità)
putFood(F,N) :- food(F,N1), !, retract(food(F,N1)), N2 is N1 + N, assert(food(F,N2)).
putFood(F,N) :- assert(food(F,N)).

%% rimozione di tutti i cibi dal tavolo e ottenimento loro lista
clearFood(L) :- getFoodTableState(L), retractall(food(_,_)).

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
getTableware(T,N) :- tableware(T,N1), N1 >= N, retract(tableware(T,N1)), N2 is N1 - N, assert(tableware(T,N2)).

%% aggiunta sul tavolo dei tableware specificati nella lista passata come argomento (per la prepare)
addTablewareList([]).
addTablewareList([tableware(T,N)]) :- !, putTableware(T,N).
addTablewareList([tableware(T,N)|T]) :- putTableware(T,N), addTablewareList(T).

%% aggiunta di una quantità N del tableware T 
%% (previste due regole per supportare il caso di una aggiunta di tableware non presente al momento, caso possibile solo se l'utente decide
%% di cancellare elementi dalla prepareTablewareList anzichè aggiornare solo le quantità)
putTableware(T,N) :- tableware(T,N1), !, retract(tableware(T,N1)), N2 is N1 + N, assert(tableware(T,N2)).
putTableware(T,N) :- assert(tableware(T,N)).

%% rimozione di tutti i tableware dal tavolo e ottenimento loro lista
clearTableware(L) :- getTablewareTableState(L), retractall(tableware(_,_)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
