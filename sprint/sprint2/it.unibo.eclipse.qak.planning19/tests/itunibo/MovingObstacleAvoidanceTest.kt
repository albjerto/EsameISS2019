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

class MovingObstacleAvoidanceTest {
	var workerinroom: ActorBasic? = null
	
	@Before
	fun systemSetUp(){
		GlobalScope.launch{
			it.unibo.ctxWorkInRoom.main()
		}
		delay(3000)
		workerinroom = sysUtil.getActor("workerinroom")
	}	
	
	@After
	fun terminate(){
		println("MovingObstacleAvoidanceTest terminate")
	}
	
	@Test
	fun movingObstacleAvoidanceTest(){
		GlobalScope.launch{
			workerinroom!!.autoMsg("moveButlerTo","moveButlerTo(6,0,upDir)")
			delay(1000)
			// simulo il movimento verso il frigo, alla seconda w incontro un ostacolo mobile
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepFail","stepFail()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
			delay(500)
			workerinroom!!.autoMsg("stepOk","stepOk()")
		}
		delay(10000)
		// se tutto ok il fatto in clause non deve essere pi� presente
		solveCheckGoalFailed(workerinroom!!, "clause(move(_), true)")
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