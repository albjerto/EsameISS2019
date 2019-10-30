/* Generated by AN DISI Unibo */ 
package it.unibo.fridge

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class Fridge ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "s0"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		return { //this:ActionBasciFsm
				state("s0") { //this:State
					action { //it:State
						solve("consult('fridgeInit.pl')","") //set resVar	
						println("&&&  fridge STARTED")
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("waitCmd") { //this:State
					action { //it:State
						println("&&&  fridge waiting for command")
					}
					 transition(edgeName="t07",targetState="putTask",cond=whenDispatch("put"))
					transition(edgeName="t08",targetState="showStateTask",cond=whenDispatch("showState"))
					transition(edgeName="t09",targetState="getTask",cond=whenDispatch("get"))
					transition(edgeName="t010",targetState="checkTask",cond=whenDispatch("isAvailable"))
				}	 
				state("showStateTask") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						solve("showFoodState(L)","") //set resVar	
						if(currentSolution.isSuccess()) { 
										val FridgeStateString = getCurSol("L").toString()
						emit("modelcontent", "modelcontent(content(fridge(state($FridgeStateString))))" ) 
						 }
						else
						{ println("getFridgeState FAIL")
						 }
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("getTask") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						if( checkMsgContent( Term.createTerm("get(ARG)"), Term.createTerm("get(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								 
												val Food=payloadArg(0)
								solve("getFood($Food)","") //set resVar	
								if(currentSolution.isSuccess()) { forward("put", "put($Food)" ,"butlermind" ) 
								 }
								else
								{ println("fridgeGet FAIL")
								 }
						}
					}
					 transition( edgeName="goto",targetState="showStateTask", cond=doswitch() )
				}	 
				state("putTask") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("put(ARG)"), Term.createTerm("put(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								println("$name in ${currentState.stateName} | $currentMsg")
								 val food = payloadArg(0) 
								solve("put('$food')","") //set resVar	
								if(currentSolution.isSuccess()) {  replyToCaller("remove", "remove($food)") 
								 }
								else
								{ println("fridgePut FAIL")
								 }
						}
					}
					 transition( edgeName="goto",targetState="showStateTask", cond=doswitch() )
				}	 
				state("checkTask") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("isAvailable(ARG)"), Term.createTerm("isAvailable(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								println("$name in ${currentState.stateName} | $currentMsg")
								 val foodCode = payloadArg(0) 
								solve("isAvailable('$foodCode')","") //set resVar	
								if(currentSolution.isSuccess()) {  replyToCaller("yes", "yes") 
								 }
								else
								{  replyToCaller("no", "no") 
								 }
						}
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
			}
		}
}
