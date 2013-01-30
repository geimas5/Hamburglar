package  {
	
	import flash.events.*;
	import flash.display.MovieClip;
	
	public class KeyboardMonitor extends MovieClip {
		
		private var keyStates:Array = new Array();

		public function KeyboardMonitor() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function getKeyState(key:int): Boolean {
			var keyState = keyStates[key];
			
			if(keyState == null)
				return false;
			
			return keyState;
		}
		
		private function init(e:Event){
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUP);
		}
		
		private function onKeyDown(e:KeyboardEvent) {
			keyStates[e.keyCode] = true;
		}
		private function onKeyUP(e:KeyboardEvent)	{
			keyStates[e.keyCode] = false;
		}
	}
}
