﻿package GameObjects {
	
	import flash.display.*;
	import GameObjects.*;
	
	public class Key extends MovieClip implements IObjective, ITimeAware, IPlayerAware {		
		
		private var player:Player;
		private var objectiveComplete:Boolean = false;
		
		public function Key() {
		}
		
		public function setPlayer(player:Player) : void {
			this.player = player;
		}
		
		public function tic(sinceLastTic:int) : void{
			if(player.hitTestObject(this))
				objectiveComplete = true;
		}
		
		public function isCompleted() : Boolean{
			return objectiveComplete;
		}
	}
}