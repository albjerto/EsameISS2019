/* Generated by AN DISI Unibo */ 
package it.unibo.butlermind

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class Butlermind ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "s0"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		var ButlerStarted = false
		return { //this:ActionBasciFsm
				state("s0") { //this:State
					action { //it:State
						println("&&&  butlermind STARTED ")
						solve("consult('butlermindInit.pl')","") //set resVar	
						solve("consult('prepareFoodList.pl')","") //set resVar	
						solve("consult('prepareTablewareList.pl')","") //set resVar	
					}
					 transition( edgeName="goto",targetState="waitPrepare", cond=doswitch() )
				}	 
				state("waitPrepare") { //this:State
					action { //it:State
						println("&&&  butlermind wait prepare")
					}
					 transition(edgeName="t00",targetState="doPrepare",cond=whenDispatch("prepare"))
				}	 
				state("doPrepare") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						println("&&&  butlermind doprepare")
						solve("prepare","") //set resVar	
						forward("execButlerPlan", "execButlerPlan(prepare)" ,"butlerplanexecutor" ) 
					}
					 transition(edgeName="t01",targetState="msgHandler",cond=whenDispatch("targetReached"))
				}	 
				state("msgHandler") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						solve("consumeMessage(A,B,C)","") //set resVar	
						if(currentSolution.isSuccess()) { 	val dest = getCurSol("A").toString()   
							    		val id = getCurSol("B").toString()	
							    		val cont = getCurSol("C").toString()	
										println("MESSAGGIO: id:$id dest:$dest cont:$cont ")    	
							    		forward(id, cont ,dest )
						 }
						else
						{ println("&& butlermind error")
						 }
					}
					 transition(edgeName="t02",targetState="updateState",cond=whenDispatch("put"))
					transition(edgeName="t03",targetState="updateState",cond=whenDispatch("remove"))
					transition(edgeName="t04",targetState="msgHandler",cond=whenDispatch("targetReached"))
					transition(edgeName="t05",targetState="waitCommandTask",cond=whenDispatch("waitCommand"))
					transition(edgeName="t06",targetState="waitPrepare",cond=whenDispatch("end"))
				}	 
				state("updateState") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						if( checkMsgContent( Term.createTerm("put(ARG)"), Term.createTerm("put(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								val Arg = payloadArg(0)
								solve("addFoodList($Arg)","") //set resVar	
						}
						if( checkMsgContent( Term.createTerm("remove(ARG)"), Term.createTerm("remove(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								val Arg = payloadArg(0)
								solve("remove($Arg)","") //set resVar	
						}
						solve("showFoodState(F)","") //set resVar	
						if(currentSolution.isSuccess()) { 
										val FoodState = itunibo.prolog.prologUtils.parseFoodState(myself, "F")
						emit("modelcontent", "modelcontent(content(butlerFood(state($FoodState))))" ) 
						println("foodState emitted:$FoodState")
						 }
						else
						{ println("showFoodState FAIL")
						 }
						solve("showTablewareState(T)","") //set resVar	
						if(currentSolution.isSuccess()) { 
										val TablewareState = itunibo.prolog.prologUtils.parseTablewareState(myself, "T")
						emit("modelcontent", "modelcontent(content(butlerTableware(state($TablewareState))))" ) 
						println("tableware emitted:$TablewareState")
						 }
						else
						{ println("showTablewareState FAIL")
						 }
					}
					 transition(edgeName="t07",targetState="msgHandler",cond=whenDispatch("targetReached"))
				}	 
				state("waitCommandTask") { //this:State
					action { //it:State
						println("&& butlermind wait cmd")
					}
					 transition(edgeName="t08",targetState="isAvaliable",cond=whenDispatch("add"))
					transition(edgeName="t09",targetState="doClear",cond=whenDispatch("clear"))
				}	 
				state("isAvaliable") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("add(ARG)"), Term.createTerm("add(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								val code = payloadArg(0)
								println("&&&  butlermind doadd")
								forward("isAvailable", "isAvalaible(code)" ,"butlerplanexecutor" ) 
						}
					}
					 transition(edgeName="t010",targetState="doAdd",cond=whenDispatch("yes"))
					transition(edgeName="t011",targetState="waitCommandTask",cond=whenDispatch("no"))
				}	 
				state("doAdd") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("add(ARG)"), Term.createTerm("add(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								val code = payloadArg(0)
								println("&&&  butlermind doadd")
								solve("add(code)","") //set resVar	
								forward("execButlerPlan", "execButlerPlan(add)" ,"butlerplanexecutor" ) 
						}
					}
					 transition( edgeName="goto",targetState="msgHandler", cond=doswitch() )
				}	 
				state("doClear") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("get(ARG)"), Term.createTerm("get(ARG)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								val state = payloadArg(0)
								println("&&&  butlermind doadd")
								solve("clear","") //set resVar	
								forward("execButlerPlan", "execButlerPlan(clear)" ,"butlerplanexecutor" ) 
						}
					}
					 transition( edgeName="goto",targetState="msgHandler", cond=doswitch() )
				}	 
			}
		}
}
