package Levels {
	
	import flash.events.*;
	import GameObjects.*;
	import Levels.*;
	
	public class Level8 extends LevelBase {
		public function Level8(gameOverCallback:Function, gameFinnishedCallback:Function) {
			super(gameOverCallback, gameFinnishedCallback);
			
			addEventListener(Event.ADDED_TO_STAGE,onInit);
		}
		
		private function onInit(e:Event){
			d1.triggerPannel = Pannel(fin);
		}
	}
}

