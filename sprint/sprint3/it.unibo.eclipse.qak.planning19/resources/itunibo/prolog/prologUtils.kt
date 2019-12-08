package itunibo.prolog

import it.unibo.kactor.ActorBasic

object prologUtils {
	
	fun parseState(actor : ActorBasic, sol : String) : String {
		return actor.getCurSol(sol)
				.toString()
				.replace(")]","]")
				.replace("),", ")@")
				.replace("[", "'")
				.replace("]", "'")
	}
	
	fun parseFoodState(actor : ActorBasic, sol : String) : String {
		return actor.getCurSol(sol)
				.toString()
				.replace(")]","]")
				.replace("food(","")
				.replace("),", "@")
				.replace("[", "'")
				.replace("]", "'")
	}
	
	fun parseTablewareState(actor : ActorBasic, sol : String) : String {
		return actor.getCurSol(sol)
				.toString()
				.replace(")]","]")
				.replace("tableware(","")
				.replace("),", "@")
				.replace("[", "'")
				.replace("]", "'")
	}
	
}