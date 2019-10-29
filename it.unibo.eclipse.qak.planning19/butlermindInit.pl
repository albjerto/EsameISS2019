food(succoBuono,5).
food(birraBella,5).
food(acquaGelidaImbevibile,5).
food(punchNeiDenti,5).
tableware(piattoPiano,5).
tableware(ciotola,5).
tableware(bicchiere,5).
tableware(forchetta,5).
tableware(coltello,5).
tableware(cucchiaio,5).


showFoodState(F) :- findall(food(T,N),food(T,N),F).
showTableWareState(F) :- findall(tableware(T,N),tableware(T,N),F).
put([A|B]) :- assert(A), put(B).
put([]).
getPrepareFood(F) :- findall(food(T,N),toPrepare(food(T,N)),F).


getFood(F) :- findall(food(T,N),food(T,N),F),remove(F).
getTableware(F) :- findall(tableware(T,N),tableware(T,N),F), remove(F).
remove([H|L]) :- retract(H), remove(L).
remove([]).

getPrepareTableware(F) :- findall([tableware(T,N)],toPrepare(tableware(T,N)),F).


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
    
    
    
    
    
    