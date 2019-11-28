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

class CoapCommunicationTest {
	var proxyFridge: ActorBasic? = null
	var proxyServer: ActorBasic? = null
	var butlermind: MockActor? = null
	
	@Before
	fun systemSetUp(){
		GlobalScope.launch{
			it.unibo.ctxWorkInRoom.main()
		}
		GlobalScope.launch{
			it.unibo.ctxFridge.main()
		}
		GlobalScope.launch{
			it.unibo.ctxRoomElements.main()
		}
		proxyFridge = sysUtil.getActor("proxyfridge")
		proxyServer = sysUtil.getActor("serverproxy")
		butlermind = MockActor("butlermind")
	}	
	
	@After
	fun terminate(){
		println("CoapCommunicationTest terminate")	
	}
	
	@Test
	fun coapCommunicationTest(){
		putCommunicationTest()
		getCommunicationTest()
	}
	
	fun delay( time : Long ){
		Thread.sleep( time )
	}
	
	fun putCommunicationTest(){
		proxyFridge!!.scope.launch{
			proxyFridge!!.autoMsg("put","put([food(cheeseCakeHoFame,2),food(piadaDelParco,1)])")
		}
		delay(2000) // attendo l'avvenuto scambio di messaggi
		assertTrue(butlermind!!.getReceivedMessage()!!.msgId() == "remove")
	}
	
	fun getCommunicationTest(){
		proxyFridge!!.scope.launch{
			proxyFridge!!.autoMsg("get","get([food(cheeseCakeHoFame,2),food(piadaDelParco,1)])")
		}
		delay(2000) // attendo l'avvenuto scambio di messaggi
		assertTrue(butlermind!!.getReceivedMessage()!!.msgId() == "put")
	}

}
