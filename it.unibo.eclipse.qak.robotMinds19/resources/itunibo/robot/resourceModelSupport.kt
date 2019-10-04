package itunibo.robot

import it.unibo.kactor.ActorBasic
import kotlinx.coroutines.launch
import itunibo.coap.modelResourceCoap

object resourceModelSupport{
lateinit var resourcecoap : modelResourceCoap
	
	fun setCoapResource( rescoap : modelResourceCoap ){
		resourcecoap = rescoap
	}
	
	fun updateRobotModel( actor: ActorBasic, content: String ){
 			actor.solve(  "action(robot, move($content) )" ) //change the robot state model
			actor.solve(  "model( A, robot, STATE )" )
			val RobotState = actor.getCurSol("STATE")
			println("			resourceModelSupport updateModel RobotState=$RobotState")
			actor.scope.launch{
 				actor.emit( "modelChanged" , "modelChanged(  robot,  $content)" )  //for the robotmind
				actor.emit( "modelContent" , "content( robot( $RobotState ) )" )
				resourcecoap.updateState( "robot( $RobotState )" )
  			}	
	}	
	fun updateSonarRobotModel( actor: ActorBasic, content: String ){
 			actor.solve( "action( sonarRobot,  $content )" ) //change the robot state model
			actor.solve( "model( A, sonarRobot, STATE )" )
			val SonarState = actor.getCurSol("STATE")
			println("			resourceModelSupport updateSonarRobotModel SonarState=$SonarState")
			actor.scope.launch{
 				actor.emit( "modelContent" , "content( sonarRobot( $SonarState ) )" )
				resourcecoap.updateState( "sonarRobot( $SonarState )" )
 			}	
	}
	
	fun updateRoomMapModel( actor: ActorBasic, content: String ){
		println("			resourceModelSupport updateRoomMapModel content=$content")
			actor.scope.launch{
				actor.emit( "modelContent" , "content( roomMap( state( '$content' ) ) )" )
 				resourcecoap.updateState( "roomMap( '$content' )" )
 			}	
	}
	
	/*
 	 * Comunicazione dal frigo al frontend
 	 * La resourcecoap.updateState  manda solo il messaggio al rettangolino verde, si intende
 	 * questo dicendo che il frigo deve poter rispondere alle richieste tramite coap? In caso
 	 * contrario, il tipo di comunicazione verso il frontend tramite mqtt qui implementato
 	 * (invio messaggio sul topic dentro la emit) non va bene?
 	 */
	fun updateFridgeModel( actor: ActorBasic, content: String ){
		println("			resourceModelSupport updateFridgeModel content=$content")
			actor.scope.launch{
				actor.emit( "modelContent" , "content( fridge( state( '$content' ) ) )" )
 				resourcecoap.updateState( "fridge( '$content' )" )
 			}	
	}
	
	/*
 	 * Comunicazione dal table al frontend riguardo il cibo
	 * Dovremo probabilmente prevedere anche un updateTablewareTableModel, in caso modificare
 	 * anche questo metodo accordingly
	 */
 	fun updateFoodTableModel( actor: ActorBasic, content: String ){
		println("			resourceModelSupport updateFoodTableModel content=$content")
			actor.scope.launch{
				actor.emit( "modelContent" , "content( table( state( '$content' ) ) )" )
 				resourcecoap.updateState( "table( '$content' )" )
 			}	
	}
	
}

