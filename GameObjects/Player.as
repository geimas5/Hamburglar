package GameObjects {
	import flash.display.*;
	import flash.ui.*;
	import flash.events.*;
	import System.*;
	
	public class Player extends MovieClip implements ITimeAware {
		private var _keyboardMonitor:KeyboardMonitor = KeyboardMonitor.getInstance();
		
		private var _obstacleTester:ObstacleTester = null;

		public function Player() {
			addEventListener(Event.ADDED_TO_STAGE, onInit);
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
		
		private function onInit(e:Event) : void {
			man.gotoAndStop(1);
		}
		
		private function movePlayer(sinceLastTic:int) {
			var oldX = this.x;
			var oldY = this.y;
			man.stop();
			var distance = calculateDistance(sinceLastTic);
			
			if(_keyboardMonitor.getKeyState(Keyboard.UP) || _keyboardMonitor.getKeyState(Keyboard.W)) {
				y -= distance;
				this.rotation = 0;
				man.play();
			}
			if(_keyboardMonitor.getKeyState(Keyboard.DOWN) || _keyboardMonitor.getKeyState(Keyboard.S)) {
				y += distance;
				this.rotation = 180;
				man.play();
			}
			if(this._obstacleTester != null && this._obstacleTester.hitTest(this)) {
				y = oldY;
			}
			if(_keyboardMonitor.getKeyState(Keyboard.LEFT) || _keyboardMonitor.getKeyState(Keyboard.A)) {
				x -= distance;
				this.rotation = 270;
				man.play();
				if(_keyboardMonitor.getKeyState(Keyboard.UP) || _keyboardMonitor.getKeyState(Keyboard.W)) {
					this.rotation = 315;
				}
				else if(_keyboardMonitor.getKeyState(Keyboard.DOWN) || _keyboardMonitor.getKeyState(Keyboard.S)) {
					this.rotation = 225;
				}
			}
			if(_keyboardMonitor.getKeyState(Keyboard.RIGHT) || _keyboardMonitor.getKeyState(Keyboard.D)) {
				x += distance;
				this.rotation = 90;
				man.play();
				if(_keyboardMonitor.getKeyState(Keyboard.UP) || _keyboardMonitor.getKeyState(Keyboard.W)) {
					this.rotation = 45;
				}
				else if(_keyboardMonitor.getKeyState(Keyboard.DOWN) || _keyboardMonitor.getKeyState(Keyboard.S)) {
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
