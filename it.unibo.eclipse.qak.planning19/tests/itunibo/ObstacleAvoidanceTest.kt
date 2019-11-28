package itunibo

import org.junit.Assert.assertTrue
import it.unibo.kactor.ActorBasic
import org.junit.Before
import it.unibo.kactor.sysUtil
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.junit.After
import org.junit.Test
import it.unibo.kactor.ApplMessage

class ObstacleAvoidanceTest {
	var butlermind: ActorBasic? = null
	var workerinroom: ActorBasic? = null
	var proxyFridge: MockActor? = null
	
	@Before
	fun systemSetUp(){
		GlobalScope.launch{
			it.unibo.ctxWorkInRoom.main()
		}
		butlermind = sysUtil.getActor("butlermind")
		workerinroom = sysUtil.getActor("workerinroom")
		proxyFridge = MockActor("proxyfridge")
	}	
	
	@After
	fun terminate(){
		println("ObstacleAvoidanceTest terminate")
	}
	
	@Test
	fun obstacleAvoidanceTest(){
		butlermind!!.scope.launch{
			butlermind!!.autoMsg("prepare","prepare()")
		}
		delay(2000)
		// simulo il movimento verso il frigo, il terzo passo incontra un ostacolo
		workerinroom!!.scope.launch{
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(1000)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(1000)
			workerinroom!!.autoMsg("stepFail","stepFail()")
			delay(1000)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(1000)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(1000)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(1000)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(1000)
		}
		assertTrue(proxyFridge!!.getReceivedMessage()!!.msgId() == "get")
	}
	
	fun delay( time : Long ){
		Thread.sleep( time )
	}

}