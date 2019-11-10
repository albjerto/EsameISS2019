%% fatto da noi
%% comprende le funzionalità della dishwasher

%% print dello stato
showDishwasherState :- tableware(T,N), outputTableware(T,N), fail.
showDishwasherState.			
outputTableware(T,N) :- stdout <- print(T), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente lo stato della dishwasher (da parsare lato kotlin)
getDishwasherState(L) :- findall(tableware(T,N), tableware(T,N), L).

%% aggiunta alla dishwasher dei tableware specificati nella lista passata come argomento (per la clear)
addTablewareList([]).
addTablewareList([tableware(T,N)]) :- !, putTableware(T,N).
addTablewareList([tableware(T,N)|T1]) :- putTableware(T,N), addTablewareList(T1).

%% aggiunta di una quantità N del tableware T
%% la prima put commentata non dovrebbe servire dato che l'aggiunta di tableware alla dishwasher è 
%% una sola ed il suo stato è inizialmente vuoto
%%putTableware(T,N) :- tableware(T,N1), !, retract(tableware(T,N1)), N2 is N1 + N, assert(tableware(T,N2)).
putTableware(T,N) :- assert(tableware(T,N)).

%% non dovrebbe servire alcuna operazione di removeTableware
