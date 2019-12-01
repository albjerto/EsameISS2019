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

class FixedObstacleAvoidanceTest {
	var butlermind: ActorBasic? = null
	var workerinroom: ActorBasic? = null
	
	@Before
	fun systemSetUp(){
		GlobalScope.launch{
			it.unibo.ctxWorkInRoom.main()
		}
		delay(3000)
		butlermind = sysUtil.getActor("butlermind")
		workerinroom = sysUtil.getActor("workerinroom")
	}	
	
	@After
	fun terminate(){
		println("FixedObstacleAvoidanceTest terminate")
	}
	
	@Test
	fun movingObstacleAvoidanceTest(){
		GlobalScope.launch{
			butlermind!!.autoMsg("prepare","prepare()")
			delay(1000)
			// simulo il movimento verso il frigo, alla seconda w incontro un ostacolo fisso
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepFail","stepFail()")
			delay(500)
			// al secondo stepFail l'ostacolo è identificato come fisso
			workerinroom!!.autoMsg("stepFail","stepFail()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
		}
		delay(15000)
		// se tutto ok il fatto in clause non deve essere più presente
		solveCheckGoalFailed(butlermind!!, "clause(msg(proxyfridge, get, get(_)), true)")
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