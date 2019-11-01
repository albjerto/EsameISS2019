showFoodState(F) :- findall(food(T,N),food(T,N),F).
showTableWareState(F) :- findall(tableware(T,N),tableware(T,N),F).


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


consumeMessage(A,B,C) :- retract(msg(A,B,C)).



prepare	 :- 	getPrepareFood(F), assert(msg(fridge,get, get(F))),
    			assert(msg(table,put, put(F))),
    			getPrepareTableware(T) , assert(msg(pantry,get, get(T))),
    			assert(msg(table,put, put(T))),
				assert(msg(butlermind,waitcmd,waitcmd(ok))).
    
add(F)	:- 		assert(msg(fridge,get, get(F))),
    			assert(msg(table,put, put(F))),
				assert(msg(butlermind,waitcmd,waitcmd(ok))).
    
clear	:-		assert(msg(table,clear,clear([]))),
    		   	assert(msg(frigo,put, put(F)):- getFood(F)),
    			assert(msg(dishwasher,put, put(T)):- getTableware(T)),
				assert(msg(butlermind,end,end(ok))).
    
    
    
    
    
    