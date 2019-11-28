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

class ButlermindTest{
	var butler :ActorBasic? = null
	var fridge :MockActor? = null
	var pantry :MockActor? = null
	var dishwasher :MockActor? = null
	var table :MockActor? = null
	
	@Before
	fun systemSeUp(){
		
		fridge=MockActor("fridge")
		pantry=MockActor("pantry")
		dishwasher=MockActor("dishwasher")
		table=MockActor("table")
		GlobalScope.launch{ 
 					     it.unibo.ctxWorkInRoom.main()	
 					      println(" %%%%%%% TestButlerMind starts ")
 			}	
		butler= sysUtil.getActor("butlermind")
	}
	
	
	@After
	fun terminate(){
		println("TestButlerMind terminate")	
	}
	
	
	 @Test
	 fun prepareTest(){
		 GlobalScope.launch{ 
			 butler!!.autoMsg("prepare","prepare()")
			 //controllo che mandi un messaggio al frigo
			 butler!!.autoMsg("targetReached","targetReached()")
			 assertTrue(fridge!!.getRecivedMessage()!!.msgId()=="get")
			 //controllo che mandi un messaggio al tavolo
			 butler!!.autoMsg("targetReached","targetReached()")
			 assertTrue(table!!.getRecivedMessage()!!.msgId()=="put")
			 //controllo che mandi un messaggio alla pantry
			 butler!!.autoMsg("targetReached","targetReached()")
			 assertTrue(pantry!!.getRecivedMessage()!!.msgId()=="get")
			 //controllo che mandi un messaggio alla table
			 butler!!.autoMsg("targetReached","targetReached()")
			 assertTrue(table!!.getRecivedMessage()!!.msgId()=="put")
			 //porto il butler nellos tato waitcmd
			 butler!!.autoMsg("targetReached","targetReached()")
		 }
		 
	}
}

