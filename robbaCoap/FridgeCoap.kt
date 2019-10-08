package itunibo.coap
import org.eclipse.californium.core.coap.CoAP.ResponseCode.BAD_REQUEST
import org.eclipse.californium.core.coap.CoAP.ResponseCode.CHANGED
import org.eclipse.californium.core.CoapResource
import org.eclipse.californium.core.coap.CoAP.ResponseCode
import org.eclipse.californium.core.coap.MediaTypeRegistry
import org.eclipse.californium.core.server.resources.CoapExchange
import it.unibo.kactor.ActorBasic
import it.unibo.kactor.MsgUtil
import org.eclipse.californium.core.CoapServer
import kotlinx.coroutines.launch
import kotlinx.coroutines.delay
import kotlinx.coroutines.GlobalScope
import org.eclipse.californium.core.coap.CoAP.Type
import itunibo.robot.resourceModelSupport

class FridgeCoap (name : String ) : CoapResource(name) {
	
	companion object {
		lateinit var actor : ActorBasic
		var curmodelval = "unknown"
		lateinit var fridgeCoap : FridgeCoap
		
		fun create(name: String){
			val server   = CoapServer(5683);		//COAP SERVER
			fridgeCoap = FridgeCoap(name)
			server.add(fridgeCoap);
			println("--------------------------------------------------")
			println("Coap Server started");	
			println("--------------------------------------------------")
			server.start();
			// resourceModelSupport.setCoapResource(resourceCoap)  //Injects a reference
 		}		
	}
	
	init{ 
		println("--------------------------------------------------")
		println("FridgeCoap init")
		println("--------------------------------------------------")
		setObservable(true) 				// enable observing	!!!!!!!!!!!!!!
		setObserveType(Type.CON)			// configure the notification type to CONs
		//getAttributes().setObservable();	// mark observable in the Link-Format			
	}
	
	/*
	fun updateState( modelitem : String ){
// 		actor.solve("model( actuator, robot, state(STATE) )")
//		curmodelval = actor.getCurSol("STATE").toString()
		curmodelval = modelitem
		//println("%%%%%%%%%%%%%%%% updateState from $curState to $curmodelval" )
		changed()	// notify all CoAp observers		
        	//
        	// Notifies all CoAP clients that have established an observe relation with
        	// this resource that the state has changed by reprocessing their original
        	// request that has established the relation. The notification is done by
        	// the executor of this resource or on the executor of its parent or
        	// transitively ancestor. If no ancestor defines its own executor, the
        	// thread that has called this method performs the notification.
	}
 	*/
	 
	override fun handleGET(exchange: CoapExchange?) {
 		//println("%%%%%%%%%%%%%%%% handleGET  curmodelval=$curmodelval  "  )			
		exchange!!.respond(ResponseCode.CONTENT, curmodelval, MediaTypeRegistry.TEXT_PLAIN)
	}

	override fun handlePOST(exchange: CoapExchange?) {
 		//println("%%%%%%%%%%%%%%%% handlePOST  "  )
		handlePUT( exchange )		
	}
	override fun handlePUT(exchange: CoapExchange?) {
		try {
			val value = exchange!!.getRequestText()//new String(payload, "UTF-8");
			//println("%%%%%%%%%%%%%%%% handlePUT value= $value"  )
			//itunibo.robot.resourceModelSupport.updateRobotModel( actor, value )//HAREMFUL SHERTCUT					
			val curState = curmodelval		
			GlobalScope.launch{
				println("Messaggio ottenuto, contenuto: $value")
 				exchange.respond(CHANGED, "fridge:state(\'culo,2@pinocchio,4@asdrubalo,1\')")
			}			
 		} catch (e: Exception) {
			exchange!!.respond(BAD_REQUEST, "Invalid String")
		}
	}
}