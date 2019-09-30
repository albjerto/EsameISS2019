/* Generated by AN DISI Unibo */ 
package it.unibo.g521reader

import it.unibo.kactor.*
import alice.tuprolog.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
	
class G521reader ( name: String, scope: CoroutineScope ) : ActorBasicFsm( name, scope){
 	
	override fun getInitialState() : String{
		return "init"
	}
		
	override fun getBody() : (ActorBasicFsm.() -> Unit){
		return { //this:ActionBasciFsm
				state("init") { //this:State
					action { //it:State
						println("g521reader STARTS ... ")
						delay(1000) 
						println("SENDING r ")
						emit("rotationCmd", "rotationCmd(r)" ) 
					}
				}	 
				state("waitForEvents") { //this:State
					action { //it:State
					}
					 transition(edgeName="t07",targetState="tuneRotate",cond=whenEvent("robotCmd"))
				}	 
				state("tuneRotate") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("robotCmd(CMD)"), Term.createTerm("robotCmd(x)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								forward("tuneRot", "tuneRot(r)" ,"g521reader" ) 
						}
						if( checkMsgContent( Term.createTerm("robotCmd(CMD)"), Term.createTerm("robotCmd(z)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								forward("tuneRot", "tuneRot(l)" ,"g521reader" ) 
						}
					}
					 transition(edgeName="t08",targetState="tuneRotation",cond=whenDispatch("tuneRot"))
				}	 
				state("tuneRotation") { //this:State
					action { //it:State
						println("$name in ${currentState.stateName} | $currentMsg")
					}
					 transition( edgeName="goto",targetState="waitForEvents", cond=doswitch() )
				}	 
				state("tuneRotationRight") { //this:State
					action { //it:State
					}
				}	 
				state("tuneRotLeft") { //this:State
					action { //it:State
					}
				}	 
				state("handleg521") { //this:State
					action { //it:State
						if( checkMsgContent( Term.createTerm("g521(TYPE,X,Y,Z)"), Term.createTerm("g521(gyro,X,Y,Z)"), 
						                        currentMsg.msgContent()) ) { //set msgArgList
								println(payloadArg(3))
						}
					}
					 transition( edgeName="goto",targetState="waitForEvents", cond=doswitch() )
				}	 
			}
		}
}
