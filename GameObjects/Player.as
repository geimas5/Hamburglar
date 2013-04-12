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
			
			if(_keyboardMonitor.getKeyState(Keyboard.UP)) {
				y -= distance;
				this.rotation = 0;
			}
			if(_keyboardMonitor.getKeyState(Keyboard.DOWN)) {
				y += distance;
				this.rotation = 180;
			}
			if(this._obstacleTester != null && this._obstacleTester.hitTest(this)){
				y = oldY;
			}
			if(_keyboardMonitor.getKeyState(Keyboard.LEFT)) {
				x -= distance;
				this.rotation = 270;
				if(_keyboardMonitor.getKeyState(Keyboard.UP)) {
					this.rotation = 315;
				}
				else if(_keyboardMonitor.getKeyState(Keyboard.DOWN)) {
					this.rotation = 225;
				}
			}
			if(_keyboardMonitor.getKeyState(Keyboard.RIGHT)) {
				x += distance;
				this.rotation = 90;
				if(_keyboardMonitor.getKeyState(Keyboard.UP)) {
					this.rotation = 45;
				}
				else if(_keyboardMonitor.getKeyState(Keyboard.DOWN)) {
					this.rotation = 135;
				}
			}
			if(this._obstacleTester != null && this._obstacleTester.hitTest(this)){
				x = oldX;
			}
		}
		
		private function calculateDistance(sinceLastTic:int) {
			return (Configuration.PLAYER_SPEED / 1000) * sinceLastTic;
		}
	}
}
