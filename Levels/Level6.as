package Levels {
	
	import flash.events.*;
	import GameObjects.*;
	import Levels.*;
	
	public class Level6 extends LevelBase {
		
		public function Level6(gameOverCallback:Function, gameFinnishedCallback:Function) {
			super(gameOverCallback, gameFinnishedCallback);
			
			addEventListener(Event.ADDED_TO_STAGE,onInit);
		}
		
		private function onInit(e:Event){
			tutoFinishedDoor.triggerPannel = Pannel(tutoFinishedPannel);
			exitDoor.triggerPannel = Pannel(exitPannel);
		}
	}
}

