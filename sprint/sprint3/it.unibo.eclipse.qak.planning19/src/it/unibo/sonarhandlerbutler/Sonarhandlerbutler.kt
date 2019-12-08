/* Generated by AN DISI Unibo */ 
package it.unibo.sonarhandlerbutler

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class Sonarhandlerbutler ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "init"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		
		var LastDistance = 0
		return { //this:ActionBasciFsm
				state("init") { //this:State
					action { //it:State
						println("sonarhandlerbutler STARTS ... ")
					}
					 transition( edgeName="goto",targetState="waitForEvents", cond=doswitch() )
				}	 
				state("waitForEvents") { //this:State
					action { //it:State
					}
					 transition(edgeName="t05",targetState="handleSonar",cond=whenEvent("sonarRobot"))
				}	 
				state("handleSonar") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("sonar(DISTANCE)"), Term.createTerm("sonar(DISTANCE)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								val Distance = Integer.parseInt( payloadArg(0) ); 
											  if( Math.abs( Distance - LastDistance ) > 1 ){println(Distance) ; LastDistance = Distance}
								              val foundObstacle = (Distance<13) 
								if(foundObstacle)emit("obstacle", "obstacle(10)" ) 
						}
					}
					 transition( edgeName="goto",targetState="waitForEvents", cond=doswitch() )
				}	 
			}
		}
}
