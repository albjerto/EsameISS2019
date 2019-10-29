food(succoBuono,5).
food(birraBella,5).

%% FUNZIONI TOMMY
put([A|B]) :- assert(A), put(B).
put([]).


getFood([H|L]) :- getFoodByName(H), getFood(L).
getFood([]).
getFoodByName(food(F,N)) :- food(F,N1), N1 >= N, retract(food(F,N1)), N2 is N1 - N, assert(food(F,N2)).

printF(T) :- stdout <- print(T), printFood(T).
printFood([H|L]) :- stdout <- print(H), printFood(L).




showFridgeState :- food(F,N), outputFood(F,N), fail.
showFridgeState.
outputFood(F,N) :- stdout <- print(F), stdout <- print(' '), stdout <- println(N).


getTableware([tableware(N,Q)|L]) :- getTablewareByName(N,Q), getTableware(L).
getTableware([]).
getTablewareByName(F,N) :- tableware(F,N1), N1 >= N, retract(tableware(F,N1)), N2 is N1 - N, assert(tableware(F,N2)).


showFoodState(F) :- findall(food(T,N),food(T,N),F).
showTableWareState(F) :- findall(tableware(T,N),tableware(T,N),F).

