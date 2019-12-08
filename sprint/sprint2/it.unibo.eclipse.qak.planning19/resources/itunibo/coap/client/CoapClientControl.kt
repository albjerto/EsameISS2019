package itunibo.coap.client

import org.eclipse.californium.core.CoapHandler
import org.eclipse.californium.core.CoapResponse
import org.eclipse.californium.core.CoapClient
import org.eclipse.californium.core.coap.MediaTypeRegistry
import it.unibo.kactor.ActorBasic
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import it.unibo.kactor.ApplMessage

object CoapClientControl {
	
		private lateinit var client: CoapClient
		private lateinit var proxyActor :ActorBasic
		
		fun create(actor :ActorBasic , serverAddr : String ){
			println("ProxyClientFridge create serverAddr = $serverAddr")
			client   = CoapClient( "coap://localhost:5684/" +serverAddr )
			proxyActor=actor;
		}
	
	
		fun send(msg :String):CoapResponse{
			var response= client.put( msg, MediaTypeRegistry.TEXT_PLAIN);
			/*val message = response!!.getResponseText()//new String(payload, "UTF-8");
			val id = message.substringBefore("(")
			println("ricevuto messaggio $message da $id per $sender")
			GlobalScope.launch{
				proxyActor.forward(id,message,sender)
			}*/
			return response
			
		}
}