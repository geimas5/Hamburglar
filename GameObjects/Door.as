package GameObjects {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GameObjects.*;
	import Obstacles.*;
	
	public class Door extends Obstacle implements ITimeAware{
		
		private var _triggerPannel:Pannel;
		
		public function Door() {
			addEventListener(Event.ADDED_TO_STAGE,onInit);
		}
		
		public function setTriggerPannel (triggerPannel:Pannel) : void{
			_triggerPannel = triggerPannel;
		}
		
		public function getTriggerPannel () : Pannel{
			return _triggerPannel;
		}
		
		public function tic(slt:int) : void{
			if(_triggerPannel != null && _triggerPannel.isCompleted()){
				open();
			}
		}
		
		public function onInit(e:Event) : void{
			stop();
		}
		
		public function open () : void{
			gotoAndStop(2);
		}
	}
	
}
