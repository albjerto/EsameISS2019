package itunibo

import it.unibo.kactor.ActorBasic
import it.unibo.kactor.ApplMessage

class MockActor(name: String): ActorBasic(name){
		suspend override fun actorBody(msg: ApplMessage){
			// do nothing
		}
	}