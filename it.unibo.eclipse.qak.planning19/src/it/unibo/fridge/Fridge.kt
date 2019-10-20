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
						println("&&&  fridge starting, initial state as follows")
						solve("showFridgeState","") //set resVar	
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("waitCmd") { //this:State
					action { //it:State
						println("&&&  fridge waiting for command")
					}
					 transition(edgeName="t06",targetState="prepareTask",cond=whenDispatch("prepare"))
					transition(edgeName="t07",targetState="addTask",cond=whenDispatch("add"))
					transition(edgeName="t08",targetState="showTask",cond=whenDispatch("showFridgeState"))
					transition(edgeName="t09",targetState="checkAvailability",cond=whenDispatch("isAvailable"))
				}	 
				state("prepareTask") { //this:State
					action { //it:State
						solve("consult('prepareFoodList.pl')","") //set resVar	
						println("&&&  fridge received prepare, handing over food")
						solve("prepareFood","") //set resVar	
						println("&&&  fridge state modified, now as follows")
						solve("showFridgeState","") //set resVar	
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("addTask") { //this:State
					action { //it:State
						var Code ="" 
						if( checkMsgContent( Term.createTerm("add(ARG)"), Term.createTerm("add(C)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								Code = payloadArg(0)
								solve("get('$Code',1)","") //set resVar	
								if(currentSolution.isSuccess()) { println("Add possibile, fridge informa RBR")
								emit("stateChanged", "stateChanged()" ) 
								forward("modelUpdate", "modelUpdate(fridge,addCompleted)" ,"serverproxy" ) 
								 }
								else
								{ println("Add impossibile, quantita' insufficiente nel frigo")
								forward("modelUpdate", "modelUpdate(fridge,addImpossibleWarning)" ,"serverproxy" ) 
								 }
						}
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("showTask") { //this:State
					action { //it:State
						println("&&&  fridge received showFridgeState, executing")
						solve("showFridgeState","") //set resVar	
						solve("getFridgeState(L)","") //set resVar	
						if(currentSolution.isSuccess()) { 
								val str1 = getCurSol("L").toString()
								val str2 = str1.replace("],[","@")
								val str3 = str2.replace("[","'")
								val str4 = str3.replace("]","'")
								val FridgeStateString = str4.substring(1,str4.length-1)
						println("fridgeStateString = \n$FridgeStateString")
						forward("modelUpdate", "modelUpdate(fridge,$FridgeStateString)" ,"serverproxy" ) 
						 }
						else
						{ println("getFridgeState FAIL")
						 }
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("checkAvailability") { //this:State
					action { //it:State
						println("&&&  fridge received availability check, executing")
						var code = "" 
						if( checkMsgContent( Term.createTerm("isAvalaible(CODE)"), Term.createTerm("isAvailable(CODE)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								code = payloadArg(0)
								solve("isThereFood('$code')","") //set resVar	
								if(currentSolution.isSuccess()) { println("Food available")
								forward("modelUpdate", "modelUpdate(fridge,foodAvailable)" ,"serverproxy" ) 
								 }
								else
								{ println("Food not found")
								forward("modelUpdate", "modelUpdate(fridge,foodNotFound)" ,"serverproxy" ) 
								 }
						}
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
			}
		}
}
