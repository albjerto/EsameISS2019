/* Generated by AN DISI Unibo */ 
package it.unibo.butlerplanexecutor

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class Butlerplanexecutor ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "s0"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		
		var PlanCompleted = false
		var CurTarget     = "home"
		var CurDirection  = "south"
		var globalAction = ""
		return { //this:ActionBasciFsm
				state("s0") { //this:State
					action { //it:State
						solve("consult('butlerplansapriori.pl')","") //set resVar	
					}
					 transition( edgeName="goto",targetState="doWork", cond=doswitch() )
				}	 
				state("doWork") { //this:State
					action { //it:State
						println("&&&  butlerplanexecutor doWork")
					}
					 transition(edgeName="t05",targetState="doButlerPlan",cond=whenDispatch("execButlerPlan"))
				}	 
				state("doButlerPlan") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("execButlerPlan(ACTION)"), Term.createTerm("execButlerPlan(ACTION)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								globalAction = payloadArg(0)
								println("&&&  butlerplanexecutor execButlerPlan $globalAction ")
								solve("storePlan('$globalAction')","") //set resVar	
						}
					}
					 transition( edgeName="goto",targetState="execButlerPlan", cond=doswitch() )
				}	 
				state("execButlerPlan") { //this:State
					action { //it:State
						solve("consume(A,X,Y,D)","") //set resVar	
						if(currentSolution.isSuccess()) { 
						CurTarget    = getCurSol("A").toString()
						CurDirection = getCurSol("D").toString()
						val Target = "Target=" + CurTarget +  " X=" + getCurSol("X") + " Y=" + getCurSol("Y") + " DIRECTION=" + getCurSol("D")  
						println("consume( $Target )")
						forward("moveButlerTo", "moveButlerTo(${getCurSol("X").toString()},${getCurSol("Y").toString()},${getCurSol("D").toString()})" ,"workerinroom" ) 
						 }
						else
						{ PlanCompleted = true
						 }
					}
					 transition( edgeName="goto",targetState="planExecuted", cond=doswitchGuarded({PlanCompleted}) )
					transition( edgeName="goto",targetState="waitEndOfButlerPlanMove", cond=doswitchGuarded({! PlanCompleted}) )
				}	 
				state("waitEndOfButlerPlanMove") { //this:State
					action { //it:State
					}
					 transition(edgeName="t06",targetState="doTheButlerJob",cond=whenDispatch("goalReached"))
				}	 
				state("doTheButlerJob") { //this:State
					action { //it:State
						
								val ButlerDirection = itunibo.planner.moveUtils.getDirection(myself)
								var lastTarget = "" // per gestire bene roba nel commento sotto
						println("butlerplanexecutor has reached $CurTarget/direction=$CurDirection, ButlerDirection=$ButlerDirection")
						if(CurTarget=="table"){ println("butlerplanexecutor works on the table ")
						 }
						if(globalAction == "prepare" && CurTarget == "fridge"){ forward("prepare", "prepare()" ,"fridge" ) 
						 }
						if(globalAction == "prepare" && CurTarget == "table" && lastTarget == "pantry"){ forward("prepare", "prepare()" ,"centralstateserver" ) 
						 }
						lastTarget = CurTarget
						itunibo.applUtil.applUtil.changeDirection(myself ,CurDirection )
						forward("targetReached", "targetReached(ok)" ,"butlermind" ) 
						itunibo.planner.moveUtils.showCurrentRobotState(  )
						delay(2000) 
					}
					 transition( edgeName="goto",targetState="execButlerPlan", cond=doswitch() )
				}	 
				state("planExecuted") { //this:State
					action { //it:State
						PlanCompleted = false
					}
					 transition( edgeName="goto",targetState="doWork", cond=doswitch() )
				}	 
			}
		}
}
