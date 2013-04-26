package System {
	
	import flash.display.*;
	import flash.events.*;
	
	public class KeyboardMonitor extends MovieClip {
		
		private var keyStates:Array = new Array();
		private static var _instance:KeyboardMonitor = null;
		
		public function KeyboardMonitor() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public static function getInstance() : KeyboardMonitor {
			if(_instance == null)	
				_instance = new KeyboardMonitor();
			
			return _instance;
		}
		
		public function getKeyState(key:int) : Boolean {
			var keyState = keyStates[key];
			
			if(keyState == null)
				return false;
			
			return keyState;
		}
		
		private function init(e:Event){
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUP);
		}
		
		private function onKeyPressed(e:KeyboardEvent) {
			keyStates[e.keyCode] = true;
		}
		private function onKeyUP(e:KeyboardEvent) {
			keyStates[e.keyCode] = false;
		}
	}
}
