package itunibo.coap.client

import org.eclipse.californium.core.CoapHandler
import org.eclipse.californium.core.CoapResponse
import org.eclipse.californium.core.CoapClient
import org.eclipse.californium.core.coap.MediaTypeRegistry
import it.unibo.kactor.ActorBasic
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

object CoapClientControl: CoapHandler {
	
		private lateinit var client: CoapClient
		private lateinit var proxyActor :ActorBasic
	
		fun create(actor :ActorBasic , serverAddr : String ){
			println("ProxyClientFridge create serverAddr = $serverAddr")
			client   = CoapClient( serverAddr )
			proxyActor=actor;
		}
	
	
		fun send(msg :String){
			client.put(this, msg, MediaTypeRegistry.TEXT_PLAIN);	
		}
	
	
		override fun onLoad(response: CoapResponse?) {
				val message = response!!.getResponseText()//new String(payload, "UTF-8");
				val id = message.substringBefore("(")
				GlobalScope.launch{
					println("Messaggio ottenuto: $message")
					proxyActor.autoMsg(id,message)
				}
			
			
		
		}
		override fun onError() {
			println("ProxyClientFridge ERROR")
		}
}