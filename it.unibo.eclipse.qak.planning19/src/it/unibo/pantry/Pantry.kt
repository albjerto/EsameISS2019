/* Generated by AN DISI Unibo */ 
package it.unibo.pantry

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class Pantry ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "s0"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		return { //this:ActionBasciFsm
				state("s0") { //this:State
					action { //it:State
						println("&&& pantry STARTED")
						solve("consult('pantryInit.pl')","") //set resVar	
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("waitCmd") { //this:State
					action { //it:State
						println("&&& pantry waiting for command")
					}
					 transition(edgeName="t02",targetState="showStateTask",cond=whenDispatch("showState"))
					transition(edgeName="t03",targetState="getTask",cond=whenDispatch("get"))
				}	 
				state("showStateTask") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						solve("showTableWareState(L)","") //set resVar	
						if(currentSolution.isSuccess()) { 
										val PantryState = getCurSol("L").toString()
						emit("modelcontent", "modelcontent(content(pantry(state($PantryState))))" ) 
						 }
						else
						{ println("getPantryState FAIL")
						 }
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("getTask") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("get(ARG)"), Term.createTerm("get(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								println("$name in ${currentState.stateName} | $currentMsg")
								val tableware=payloadArg(0)
								solve("getTableware('$tableware')","") //set resVar	
								if(currentSolution.isSuccess()) {  replyToCaller("put", "put($tableware)" )
								 }
								else
								{ println("pantryGet FAIL")
								 }
						}
					}
					 transition( edgeName="goto",targetState="showStateTask", cond=doswitch() )
				}	 
			}
		}
}
