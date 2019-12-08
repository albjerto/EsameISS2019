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

class TableStateTest {
	var table: ActorBasic? = null
	
	@Before
	fun systemSetUp(){
		GlobalScope.launch{
			it.unibo.ctxRoomElements.main()
		}
		delay(3000)
		table = sysUtil.getActor("table")
	}	
	
	@After
	fun terminate(){
		println("TableStateTest terminate")	
	}
	
	@Test
	fun stateTest(){
		table!!.solve("addGenericList([food(cheeseCakeHoFame,2),tableware(piattoPiano,1)])")
		getFoodStateTest()
		getTablewareStateTest()
		removeListStateTest()
		clearTablewareStateTest()
	}
	
	fun getFoodStateTest(){
		table!!.solve("getFoodTableState(L)")
		assertTrue(table!!.getCurSol("L").toString() == "[food(cheeseCakeHoFame,2)]")
	}
	
	fun getTablewareStateTest(){
		table!!.solve("getTablewareTableState(L)")
		assertTrue(table!!.getCurSol("L").toString() == "[tableware(piattoPiano,1)]")
	}
	
	fun removeListStateTest(){
		table!!.solve("removeGenericList([food(cheeseCakeHoFame,2)])")
		table!!.solve("getTablewareTableState(L)")
		assertTrue(table!!.getCurSol("L").toString() == "[tableware(piattoPiano,1)]")
	}
	
	fun clearTablewareStateTest(){
		table!!.solve("clearTableware(L)")
		table!!.solve("getTablewareTableState(L)")
		assertTrue(table!!.getCurSol("L").toString() == "[]")
	}
	
	fun solveCheckGoal( actor : ActorBasic, goal : String ){
		actor.solve(goal)
		var result =  actor.resVar
		assertTrue("", result == "success" )
	}
	
	fun delay( time : Long ){
		Thread.sleep( time )
	}

}