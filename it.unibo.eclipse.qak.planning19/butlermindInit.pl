showFoodState(F) :- findall(food(T,N),food(T,N),F).
showTablewareState(F) :- findall(tableware(T,N),tableware(T,N),F).


%% aggiunta nel frigo dei cibi specificati nella lista passata come argomento (per la clear)
addFoodList([]).
addFoodList([A]) :- !, assert(A).
addFoodList([H|T]) :- assert(H), addFoodList(T).


getPrepareFood(F) :- findall(food(T,N),toPrepare(food(T,C,N)),F).


getFood(F) :- findall(food(T,N),food(T,N),F),remove(F).
getTableware(F) :- findall(tableware(T,N),tableware(T,N),F), remove(F).

remove([]).
remove([H]) :- !,retract(H) .
remove([H|L]) :- retract(H), remove(L).


getPrepareTableware(F) :- findall(tableware(T,N),toPrepare(tableware(T,N)),F).


consumeMessage(A,B,C) :- msg(A,B,C), clause(msg(_,_,_),BODY), handleBody(BODY).
handleBody(true) :- retract(msg(_,_,_)).
handleBody(BODY) :- retract(msg(_,_,_):- BODY).



prepare	 :- 	getPrepareFood(F), assert(msg(fridge,get, get(F))),
    			assert(msg(table,put, put(F))),
    			getPrepareTableware(T) , assert(msg(pantry,get, get(T))),
    			assert(msg(table,put, put(T))),
				assert(msg(butlermind,waitCommand,waitCommand(ok))).
    
add(C)	:- 		pair(F,C),
				assert(msg(fridge,get,get([food(F,1)]))),
    			assert(msg(table,put,put([food(F,1)]))),
				assert(msg(butlermind,waitCommand,waitCommand(ok))).
    
clear	:-		assert(msg(table,clear,clear([]))),
    		   	assert(msg(fridge,put, put(F)):- getFood(F)),
    			assert(msg(dishwasher,put, put(T)):- getTableware(T)),
				assert(msg(butlermind,end,end(ok))).
