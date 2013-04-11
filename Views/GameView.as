package Views {
	
	import flash.display.*;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;
	import Levels.*;
	import Sounds.*;
	import Dialogs.*;
	
	public class GameView extends ViewBase {
		
		private var levelId:int;
		
		private var currentLevel:LevelBase;
		private var pauseMenu:PauseMenu;
		private var gameOverDialog:GameOverDialog;
		private var isPaused:Boolean = false;
		private var _ticTimer:Timer = new Timer(Configuration.GAME_TIC_INTERVAL);
		
		public function GameView(level:int) {
			setLevel(level);
			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		override public function getBackgroundMusic() : Array {
			var playlist:Array = new Array();
			playlist.push(new LevelMusic());
			return playlist;
		}
		
		private function onInit(e:Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			gameOverDialog = new GameOverDialog(this, levelId, getViewManager());
			pauseMenu = new PauseMenu(getViewManager(), this);
			pauseMenu.x = (width / 2) - (pauseMenu.width / 2);
			pauseMenu.y = (height / 2) - (pauseMenu.height / 2);
			_ticTimer.addEventListener(TimerEvent.TIMER, onTic);
			_ticTimer.start();
		}
		
		private function onTic(e:Event) : void{
			var time:int = currentLevel.getLapseTime()/1000;
			var sec:int = time % 60;
			var min:int = (time - sec)/60;
			clock.text = twoDigit(min) + ":" + twoDigit(sec);
		}
		
		private function twoDigit(digits:int){
			var digit:String = String(digits);
			if(digit.length > 1)return digit;
			return "0" + digit;

		}
		
		private function setLevel(level:int) {
			this.levelId = level
			if(currentLevel != null)
				removeChild(currentLevel);
				
			currentLevel = LevelFactory.createLevel(level, gameOver);
			addChild(currentLevel);
			currentLevel.resume();
		}
		
		private function onKeyPress(e:KeyboardEvent){
			if(e.keyCode != Keyboard.P)
				return;
			
			if(!isPaused)
				addChild(pauseMenu);
			else
				removeChild(pauseMenu)
			isPaused = !isPaused;
			currentLevel.pause();
		}
		
		public function resume() : void {
			removeChild(pauseMenu);
			isPaused = !isPaused;
			currentLevel.resume();
		}
		
		private function gameOver() {
			gameOverDialog.show();
		}
		
		private function levelFinished(){
			getViewManager().showLevelFinished(0);
		}
	}
}
