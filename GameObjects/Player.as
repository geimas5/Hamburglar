package GameObjects {
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import System.ObstacleTester;
	
	public class Player extends MovieClip implements ITimeAware {
		private var _keyboardMonitor:KeyboardMonitor = KeyboardMonitor.getInstance();
		
		private var _obstacleTester:ObstacleTester = null;

		public function Player() {
			
		}
		
		public function get obstacleTester() : ObstacleTester {
			return this._obstacleTester;
		}
		
		public function set obstacleTester(tester:ObstacleTester) {
			this._obstacleTester = tester;
		}
		
		public function tic(sinceLastTic:int) : void {
			movePlayer(sinceLastTic);
		}
		
		private function movePlayer(sinceLastTic:int){
			var oldX = this.x;
			var oldY = this.y;
			
			var distance = calculateDistance(sinceLastTic);
			
			if(_keyboardMonitor.getKeyState(Keyboard.UP))
				y -= distance;
			if(_keyboardMonitor.getKeyState(Keyboard.DOWN))
				y += distance;
			if(_keyboardMonitor.getKeyState(Keyboard.LEFT))
				x -= distance;
			if(_keyboardMonitor.getKeyState(Keyboard.RIGHT))
				x += distance;
				
			if(this._obstacleTester != null && this._obstacleTester.hitTest(this)){
				y = oldY;
				x = oldX;
			}
		}
		
		private function calculateDistance(sinceLastTic:int) {
			return (Configuration.PLAYER_SPEED / 1000) * sinceLastTic;
		}
	}
}
