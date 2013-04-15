package Levels {
	
	import flash.display.MovieClip;
	import Levels.*;
	import flash.events.*;
	import GameObjects.*;
	
	
	public class Level3 extends LevelBase{
		public function Level3(gameOverCallback:Function,gameFinnishedCallback:Function) {
			super(gameOverCallback,gameFinnishedCallback);
			addEventListener(Event.ADDED_TO_STAGE,onInit);
		}
		
		private function onInit(e:Event){
			tutoFinishedDoor.setTriggerPannel(Pannel(tutoFinishedPannel));
			exitDoor.setTriggerPannel(Pannel(exitPannel));
		}
	}
}

