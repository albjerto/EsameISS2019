%% fatto da noi
%% set di piatti, bicchieri e posate inizialmente disponibili nella pantry

tableware(piattoPiano,20)
tableware(ciotola,20)
tableware(bicchiere,20)
tableware(forchetta,20)
tableware(coltello,20)
tableare(cucchiaio,20)

%% print dello stato (stampa anche tableware terminati)
showPantryState :- tableware(T,N), outputTableware(T,N), fail.
showPantryState.			
outputTableware(T,N) :- stdout <- print(T), stdout <- print(' '), stdout <- println(N).

%% genera la lista contenente lo stato della pantry (comprende eventuali tableware terminati) (da parsare lato kotlin)
getPantryState(L) :- findall(tableware(T,N), tableware(T,N), L).

%% controllo presenza tableware con nome T
isThereTableware(T) :- tableware(T,N), N > 0.

%% rimozione dalla pantry dei tableware specificati nella lista passata come argomento (per la prepare)
removeTablewareList([]).
removeTablewareList([tableware(T,N)]) :- !, getTableware(T,N).
removeTablewareList([tableware(T,N)|T1]) :- getTableware(T,N), removeTablewareList(T1).

%% ritiro di una quantità N del tableware T
getTableware(T,N) :- tableware(T,N1), N1 >= N, retract(tableware(T,N1)), N2 is N1 - N, assert(tableware(T,N2)).

%% aggiunta alla pantry dei tableware specificati nella lista passata come argomento (per la clear)
addTablewareList([]).
addTablewareList([tableware(T,N)]) :- !, putTableware(T,N).
addTablewareList([tableware(T,N)|T1]) :- putTableware(T,N), addTablewareList(T1).

%% aggiunta di una quantità N del tableware T
putTableware(T,N) :- tableware(T,N1), retract(tableware(T,N1)), N2 is N1 + N, assert(tableware(T,N2)).
