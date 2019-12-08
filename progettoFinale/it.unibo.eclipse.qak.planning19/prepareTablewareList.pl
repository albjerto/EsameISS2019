%% fatto da noi
%% tableware da porre sul tavolo col comando prepare
%% nome, quantità disponibile di ogni cibo visibile in pantryInit.pl
%% (al momento presenti tutti i tableware, non in massima quantità)
%% consigliabile modificare solo le quantità lasciando a 0 ciò che non si vuole prendere

toPrepare(tableware(piattoPiano,5)).
toPrepare(tableware(ciotola,5)).
toPrepare(tableware(bicchiere,5)).
toPrepare(tableware(forchetta,5)).
toPrepare(tableware(coltello,5)).
toPrepare(tableware(cucchiaio,5)).

%% print dei tableware nella prepareTablewareList (NON stampa eventuali tableware che non si vogliono prendere)
showPrepareTablewareList :- tableware(T,N), N > 0, outputTableware(T,N), fail.
showPrepareTableware.
outputTableware(T,N) :- stdout <- print(T), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente la lista dei tableware richiesti (NON considera tableware che non si vogliono prendere) (da parsare lato kotlin)
getPrepareTablewareList(L) :- findall(tableware(T,N), multipleGoal(T,N), L).
multipleGoal(T,N) :- tableware(T,N), N > 0.
