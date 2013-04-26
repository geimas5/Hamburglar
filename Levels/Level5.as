package Levels {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GameObjects.*;
	import Levels.*;
	
	public class Level5 extends LevelBase {
		
		public function Level5(gameOverCallback:Function, gameFinnishedCallback:Function) {
			super(gameOverCallback, gameFinnishedCallback);
			
			addEventListener(Event.ADDED_TO_STAGE,onInit);
		}
		
		private function onInit(e:Event){
			door1.triggerPannel = Pannel(pannel4);
			door2.triggerPannel = Pannel(pannel5);
			door3.triggerPannel = Pannel(pannel1);
			door4.triggerPannel = Pannel(pannel2);
			door5.triggerPannel = Pannel(pannel7);
			door6.triggerPannel = Pannel(pannel3);
			door7.triggerPannel = Pannel(pannel6);
		}
	}
}