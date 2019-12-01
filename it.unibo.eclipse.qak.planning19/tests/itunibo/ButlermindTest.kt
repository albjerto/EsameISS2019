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
import it.unibo.kactor.ActorBasicFsm

class ButlermindTest {
	var butlermind :ActorBasic? = null
	
	@Before
	fun systemSetUp(){
		GlobalScope.launch{
			it.unibo.ctxWorkInRoom.main()	
			println("ButlermindTest starts")
 		}
		delay(3000)
		butlermind = sysUtil.getActor("butlermind")
	}	
	
	@After
	fun terminate(){
		println("ButlermindTest terminates")	
	}
	
	@Test
	fun prepareTest(){
		butlermind!!.scope.launch{
			butlermind!!.autoMsg("prepare", "prepare()")
		}
		delay(1000)
		solveCheckGoal(butlermind!!, "clause(msg(proxyfridge, get, get(_)), true)")
		solveCheckGoal(butlermind!!, "clause(msg(table,put, put(_)), true)")
		solveCheckGoal(butlermind!!, "clause(msg(pantry,get, get(_)), true)")
		solveCheckGoal(butlermind!!, "clause(msg(table,put, put(_)), true)")
		solveCheckGoal(butlermind!!, "clause(msg(butlermind,waitCommand,waitCommand(ok)), true)")
	}
	
	fun solveCheckGoal( actor : ActorBasic, goal : String ){
		actor.solve( goal  )
		var result =  actor.resVar
		assertTrue("", result == "success" )
	}
	
	fun delay(time : Long){
		Thread.sleep(time)
	}

}