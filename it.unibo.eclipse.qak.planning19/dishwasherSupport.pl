%% FUNZIONI TOMMY
put([A|B]) :- assert(A), put(B).
put([]).
getFood([food(N,Q)|L]) :- getFoodByName(N,Q), getFood(L).
getFood([]).
getFoodByName(F,N) :- food(F,N1), N1 >= N, retract(food(F,N1)), N2 is N1 - N, assert(food(F,N2)).

getTableware([tableware(N,Q)|L]) :- getTablewareByName(N,Q), getTableware(L).
getTableware([]).
getTablewareByName(F,N) :- tableware(F,N1), N1 >= N, retract(tableware(F,N1)), N2 is N1 - N, assert(tableware(F,N2)).
showFoodState(F) :- findall(food(T,N),food(T,N),F).
showTableWareState(F) :- findall(tableware(T,N),tableware(T,N),F).
remove([H|L]) :- retract(H), remove(L).
remove([]).
