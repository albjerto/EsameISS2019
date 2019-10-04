/* Generated by AN DISI Unibo */ 
package it.unibo.robotmindapplication

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class Robotmindapplication ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "s0"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		return { //this:ActionBasciFsm
				state("s0") { //this:State
					action { //it:State
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("waitCmd") { //this:State
					action { //it:State
						println("						&&& robotmindapplication waitCmd ... ")
					}
					 transition(edgeName="t00",targetState="startExplore",cond=whenDispatch("explore"))
				}	 
				state("stopApplication") { //this:State
					action { //it:State
						println("&&& robotmindapplication stopApplication ... ")
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("startExplore") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
						runBlocking { QakContext.createContexts(
						 	        "localhost",this, "roomexplore.pl", "sysRules.pl")}
					}
					 transition( edgeName="goto",targetState="waitCmd", cond=doswitch() )
				}	 
				state("endOfJob") { //this:State
					action { //it:State
						println("Exploration done")
					}
				}	 
			}
		}
}