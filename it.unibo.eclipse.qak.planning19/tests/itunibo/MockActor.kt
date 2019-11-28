package itunibo

import it.unibo.kactor.ActorBasic
import it.unibo.kactor.ApplMessage

class MockActor(name:String):ActorBasic(name){
		 
	var receivedMsg :ApplMessage? = null
		
	suspend override fun actorBody(msg : ApplMessage){
		receivedMsg=msg
	}
		
	public fun getReceivedMessage() :ApplMessage?{
		return receivedMsg
	}
		
}