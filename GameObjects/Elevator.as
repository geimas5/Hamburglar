package GameObjects {
	
	import flash.display.*;
	import GameObjects.*;
	
	public class Elevator extends MovieClip implements IPlayerAware {		
		private var player:Player;
		private var avalable:Boolean = false;
		
		public function Elevator() {
			stop();
		}
		
		public function setPlayer(player:Player) : void {
			this.player = player;
		}

		public function setAvalable() : void {
			avalable = true;
			this.gotoAndStop(2);
		}
		
		public function isAvalable() : Boolean {
			return avalable;
		}
	}
}