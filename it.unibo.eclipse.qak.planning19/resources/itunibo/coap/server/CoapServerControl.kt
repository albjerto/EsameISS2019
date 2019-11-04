package itunibo.coap.server

import org.eclipse.californium.core.CoapResource
import it.unibo.kactor.ActorBasic
import org.eclipse.californium.core.CoapServer
import org.eclipse.californium.core.coap.CoAP.Type
import org.eclipse.californium.core.server.resources.CoapExchange
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.eclipse.californium.core.coap.CoAP.ResponseCode.BAD_REQUEST
import org.eclipse.californium.core.coap.CoAP.ResponseCode.CHANGED
import kotlinx.coroutines.delay
import kotlinx.coroutines.channels.Channel
import org.eclipse.californium.core.coap.CoAP.ResponseCode
import org.eclipse.californium.core.coap.MediaTypeRegistry

class CoapServerControl (name : String ) : CoapResource(name) {
	
	companion object {
		var curmodelval = "unknown"
		lateinit var coapProxyServer : CoapServerControl
		lateinit var actor : ActorBasic
		val channel = Channel<String>();
		
		fun create(a: ActorBasic,name: String){
			actor = a;
			val server   = CoapServer(5683);		//COAP SERVER
			coapProxyServer = CoapServerControl(name)
			server.add(coapProxyServer);
			println("--------------------------------------------------")
			println("Coap Server started");	
			println("--------------------------------------------------")
			server.start();
			// resourceModelSupport.setCoapResource(resourceCoap)  //Injects a reference
 		}
		
		
		 fun coapNotify(){
			 coapProxyServer.changed();
	}
		
		fun coapRespond(msg :String){
			println("imposto risposta coap: $msg");
			GlobalScope.launch{
				channel.send(msg)
			}	
		}	
	}
	
	init{ 
		println("--------------------------------------------------")
		println(name+"Coap init")
		println("--------------------------------------------------")
		setObservable(true) 				// enable observing	!!!!!!!!!!!!!!
		setObserveType(Type.CON)			// configure the notification type to CONs
		//getAttributes().setObservable();	// mark observable in the Link-Format			
	}	


	
override fun handlePUT(exchange: CoapExchange?) {
	
	try {
			val message = exchange!!.getRequestText()//new String(payload, "UTF-8");
			val id = message.substringBefore("(")
			GlobalScope.launch{
				println("Messaggio ottenuto: $message")
 				actor.autoMsg(id,message)
				exchange!!.respond(ResponseCode.CONTENT, channel.receive(), MediaTypeRegistry.TEXT_PLAIN)	
			}			
 		} catch (e: Exception) {
			exchange!!.respond(BAD_REQUEST, "Invalid String")
		}
	}
	
	
	
	
		


}

