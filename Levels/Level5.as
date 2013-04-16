package Levels {
	
	import flash.display.MovieClip;
	import Levels.*;
	import flash.events.*;
	import GameObjects.*;
	
	
	public class Level5 extends LevelBase{
		public function Level5(gameOverCallback:Function,gameFinnishedCallback:Function) {
			super(gameOverCallback,gameFinnishedCallback);
			addEventListener(Event.ADDED_TO_STAGE,onInit);
		}
		
		private function onInit(e:Event){
			door1.setTriggerPannel(Pannel(pannel4));
			door2.setTriggerPannel(Pannel(pannel5));
			door3.setTriggerPannel(Pannel(pannel1));
			door4.setTriggerPannel(Pannel(pannel2));
			door5.setTriggerPannel(Pannel(pannel7));
			door6.setTriggerPannel(Pannel(pannel3));
			door7.setTriggerPannel(Pannel(pannel6));
		}
	}
}