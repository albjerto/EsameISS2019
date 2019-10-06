%% fatto da noi
%% set di piatti, bicchieri e posate inizialmente disponibili nella pantry

tableware(piattoPiano,20)
tableware(piattoFondo,20)
tableware(bicchiere,20)
tableware(forchetta,20)
tableware(coltello,20)
tableare(cucchiaio,20)

%% controllo presenza tableware con nome T
isThereTableware(T) :- tableware(T,N), N > 0.

%% ritiro di una quantità N del tableware T
getTableware(T,N) :- tableware(T,N1), N1 >= N, retract(tableware(T,N1)), N2 is N1 - N, assert(tableware(T,N2)).

%% aggiunta di una quantità N del tableware T
putTableware(T,N) :- tableware(T,N1), retract(tableware(T,N1)), N2 is N1 + N, assert(tableware(T,N2)).

%% pone sul tavolo il tableware specificato in prepareTablewareList.pl
prepareTableware :- tablewareTable(T,N), getTableware(T,N), fail.
prepareTableware.

%% ripulisce il tavolo dai tableware e li ripone nella pantry
%% retract non necessaria, avendo già fatto quella di enabled(true)
%% direttamente nel codice
clearTableware :- tablewareTable(T,N), putTableware(T,N), 
				  retract(tablewareTable(T,N)), fail.
clearTableware.