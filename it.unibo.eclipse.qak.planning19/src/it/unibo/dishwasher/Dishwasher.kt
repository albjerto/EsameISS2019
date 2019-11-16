/* Generated by AN DISI Unibo */ 
package it.unibo.dishwasher

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class Dishwasher ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "s0"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		return { //this:ActionBasciFsm
				state("s0") { //this:State
					action { //it:State
						println("&&& dishwasher STARTED")
						solve("consult('dishwasherSupport.pl')","") //set resVar	
					}
					 transition( edgeName="goto",targetState="showStateTask", cond=doswitch() )
				}	 
				state("waitCmd") { //this:State
					action { //it:State
						println("&&& dishwasher waiting for command")
					}
					 transition(edgeName="t00",targetState="showStateTask",cond=whenDispatch("showState"))
					transition(edgeName="t01",targetState="putTask",cond=whenDispatch("put"))
				}	 
				state("showStateTask") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						solve("getDishwasherState(L)","") //set resVar	
						if(currentSolution.isSuccess()) { 
										val DishwasherState = itunibo.prolog.prologUtils.parseTablewareState(myself, "L")
						emit("modelcontent", "modelcontent(content(dishwasher(state($DishwasherState))))" ) 
						 }
						else
						{ println("getTableware dishwasher FAIL")
						 }
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("putTask") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("put(ARG)"), Term.createTerm("put(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								println("$name in ${currentState.stateName} | $currentMsg")
								 val List = payloadArg(0) 
								solve("addTablewareList($List)","") //set resVar	
								if(currentSolution.isSuccess()) { forward("remove", "remove($List)" ,"butlermind" ) 
								 }
								else
								{ println("dishwasherPut FAIL")
								 }
						}
					}
					 transition( edgeName="goto",targetState="showStateTask", cond=doswitch() )
				}	 
			}
		}
}
