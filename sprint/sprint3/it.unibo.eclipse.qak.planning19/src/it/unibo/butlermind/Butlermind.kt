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
					}
					 transition(edgeName="t00",targetState="doprepare",cond=whenDispatch("prepare"))
				}	 
				state("doprepare") { //this:State
					action { //it:State
						println("&&&  butlermind doprepare")
						forward("execButlerPlan", "execButlerPlan(prepare)" ,"butlerplanexecutor" ) 
					}
					 transition(edgeName="t01",targetState="afterPrepare",cond=whenDispatch("targetReached"))
				}	 
				state("afterPrepare") { //this:State
					action { //it:State
						println("&&&  butlermind afterPrepare")
					}
					 transition(edgeName="t02",targetState="doclear",cond=whenDispatch("clear"))
					transition(edgeName="t03",targetState="doadd",cond=whenDispatch("add"))
				}	 
				state("doadd") { //this:State
					action { //it:State
						println("&&&  butlermind doadd")
						forward("execButlerPlan", "execButlerPlan(add)" ,"butlerplanexecutor" ) 
					}
					 transition(edgeName="t04",targetState="afterPrepare",cond=whenDispatch("targetReached"))
				}	 
				state("doclear") { //this:State
					action { //it:State
						println("&&&  butlermind doclear")
						forward("execButlerPlan", "execButlerPlan(clearnofood)" ,"butlerplanexecutor" ) 
					}
					 transition( edgeName="goto",targetState="s0", cond=doswitch() )
				}	 
			}
		}
}
