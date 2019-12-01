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
	var fridge: ActorBasic? = null
	
	@Before
	fun systemSetUp(){
		GlobalScope.launch{
			it.unibo.ctxFridge.main()
		}
		delay(3000)
		fridge = sysUtil.getActor("fridge")
	}	
	
	@After
	fun terminate(){
		println("CoapCommunicationTest terminate")	
	}
	
	@Test
	fun coapCommunicationTest(){
		itunibo.coap.client.CoapClientControl.create(MockActor("test"), "fridge")
		fridge!!.solve("assert(food(test,test,0))")
		putCommunicationTest()
		getCommunicationTest()
	}
	
	fun putCommunicationTest(){
		val response = itunibo.coap.client.CoapClientControl.send("put([food(test,1)])")
		delay(1000)
		assertTrue(response.getResponseText() == "remove([food(test,1)])")
	}
	
	fun getCommunicationTest(){
		itunibo.coap.client.CoapClientControl.send("get([food(test,1)])")
		delay(1000)
		solveCheckGoalFailed(fridge!!, "clause(food(test,1), true)")
	}
	
	fun solveCheckGoalFailed( actor : ActorBasic, goal : String ){
		actor.solve(goal)
		var result =  actor.resVar
		assertTrue("", result == "fail" )
	}
	
	fun delay( time : Long ){
		Thread.sleep( time )
	}
}