showFoodState(L) :- findall(food(F,N),food(F,N),L).
showTablewareState(L) :- findall(tableware(T,N),tableware(T,N),L).


%% aggiunta nel frigo dei cibi specificati nella lista passata come argomento (per la clear)
addList([]).
addList([A]) :- !, assert(A).
addList([H|T]) :- assert(H), addList(T).


getPrepareFood(L) :- findall(food(F,N),toPrepare(food(F,C,N)),L).


getFood(L) :- findall(food(F,N),food(F,N),L),remove(L).
getTableware(L) :- findall(tableware(T,N),tableware(T,N),L), remove(L).

remove([]).
remove([H]) :- !,retract(H) .
remove([H|L]) :- retract(H), remove(L).


getPrepareTableware(L) :- findall(tableware(T,N),toPrepare(tableware(T,N)),L).


consumeMessage(A,B,C) :- msg(A,B,C), clause(msg(_,_,_), BODY), handleBody(BODY).
handleBody(true) :- retract( msg(_,_,_) ).
handleBody(BODY) :- retract( msg(_,_,_) :- BODY ).



prepare	 :- 	getPrepareFood(F), assert(msg(fridge,get, get(F))),
    			assert(msg(table,put, put(F))),
    			getPrepareTableware(T) , assert(msg(pantry,get, get(T))),
    			assert(msg(table,put, put(T))),
				assert(msg(butlermind,waitCommand,waitCommand(ok))).
    
add(C)	:- 		pair(F,C),
				assert(msg(fridge,get,get([food(F,1)]))),
    			assert(msg(table,put,put([food(F,1)]))),
				assert(msg(butlermind,waitCommand,waitCommand(ok))).
    
clear	:-		assert(msg(table,clearFood,clearFood(go))),
    		   	assert(msg(fridge,put, put(F)):- getFood(F)),
				assert(msg(table,clearTableware, clearTableware(go))),
    			assert(msg(dishwasher,put, put(T)):- getTableware(T)),
				assert(msg(butlermind,end,end(ok))).
