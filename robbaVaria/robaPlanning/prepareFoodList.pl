%% cibo da porre sul tavolo col comando prepare
%% i cibi vanno indicati come foodTable(codice,quantità)

%% bevande
foodTable(b01,2).
foodTable(b02,2).
foodTable(b03,2).
foodTable(b04,2).

%% frutta
foodTable(f01,2).
foodTable(f02,2).
foodTable(f03,2).

%% verdura
foodTable(v01,2).
foodTable(v02,2).
foodTable(v03,2).

%% affettato
foodTable(a01,2).
foodTable(a02,2).
foodTable(a03,2).
foodTable(a04,2).

%% salato
foodTable(s01,2).
foodTable(s02,2).
foodTable(s03,2).

%% dolci
foodTable(d01,2).
foodTable(d02,2).
foodTable(d03,2).

%% print dello stato, suppongo di aver fatto la consult anche di fridgeInit.pl per
%% poter ricavare il nome del cibo dal codice
%% NB senza aver fatto la consult di fridgeInit.pl, il comando non stampa nulla, sfrutto
%% la cosa per mettere tale consult solo nello stato raggiunto dopo il messaggio relativo
%% alla prepare avvenuta, così se viene richiesto lo stato del tavolo prima della prepare
%% il risultato è il vuoto, come dovrebbe essere
showTableState :- foodTable(C,N), food(F,C,N1), N > 0, outputTable(food(F,C,N)), fail.
showTableState.			
outputTable(food(F,C,N)) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).

%% aggiorna stato del tavolo dopo una add avvenuta con successo
%% se aggiungo del cibo già presente unifico con la prima regola e basta,
%% altrimenti la prima fallisce perciò il cibo non è presente sul tavolo -> lo
%% aggiungo
addTable(C,N) :- foodTable(C,N1), retract(foodTable(C,N1)), N2 is N1 + N, assert(foodTable(C,N2)).
addTable(C,N) :- assert(foodTable(C,N)).

%% consuma randomicamente una certa quantità di ogni cibo
%% prego ganesh che il prolog non aggiorni i punti di scelta del backtracking dopo la assert o non va un cazzo
randomConsume :- foodTable(C,N), random_between(0,N,R), retract(foodTable(C,N)), N1 is N - R, assert(foodTable(C,N1)), fail.
randomConsume.
