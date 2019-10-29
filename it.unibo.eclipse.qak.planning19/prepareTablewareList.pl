%% fatto da noi
%% tableware da porre sul tavolo col comando prepare
%% nome, quantità disponibile di ogni cibo visibile in pantryInit.pl
%% (al momento presenti tutti i tableware, non in massima quantità)
%% consigliabile modificare solo le quantità lasciando a 0 ciò che non si vuole prendere

tablewarePrepare(piattoPiano,5).
tablewarePrepare(ciotola,5).
tablewarePrepare(bicchiere,5).
tablewarePrepare(forchetta,5).
tablewarePrepare(coltello,5).
tablewarePrepare(cucchiaio,5).

%% print dei tableware nella prepareTablewareList (NON stampa eventuali tableware che non si vogliono prendere)
showPrepareTablewareList :- tablewarePrepare(T,N), N > 0, outputTablewarePrepare(T,N), fail.
showPrepareTableware.
outputTablewarePrepare(T,N) :- stdout <- print(T), stdout <- print(' '), stdout <- println(N).

%% genera la stringa contenente la lista dei tableware richiesti (NON considera tableware che non si vogliono prendere) (da parsare lato kotlin)
getPrepareTablewareList(L) :- findall([T,N], multipleGoal(T,N), L).
multipleGoal(T,N) :- tablewarePrepare(T,N), N > 0.
