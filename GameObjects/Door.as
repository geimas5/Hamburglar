package GameObjects {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GameObjects.*;
	
	public class Door extends Obstacle implements ITimeAware{
		
		private var _triggerPannel:Pannel;
		
		public function Door() {
			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function set triggerPannel (triggerPannel:Pannel) : void {
			_triggerPannel = triggerPannel;
		}
		
		public function get triggerPannel () : Pannel {
			return _triggerPannel;
		}
		
		public function tic(slt:int) : void {
			if(_triggerPannel != null && _triggerPannel.isCompleted()) {
				open();
			}
		}
		
		private function onInit(e:Event) : void {
			stop();
		}
		
		private function open() : void {
			gotoAndStop(2);
		}
	}
}
