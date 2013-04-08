package Views {
	
	import flash.display.*;
	import Levels.*;
	import Sounds.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	public class GameView extends ViewBase {
		
		private var levelId:int;
		
		private var currentLevel:LevelBase;
		private var pauseMenu:PauseMenu;
		private var isPaused:Boolean = false;
		
		public function GameView(level:int) {
			pauseMenu = new PauseMenu();
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
			pauseMenu.x = (width / 2) - (pauseMenu.width / 2);
			pauseMenu.y = (height / 2) - (pauseMenu.height / 2);
		}
		
		private function setLevel(level:int) {
			this.levelId = level
			if(currentLevel != null)
				removeChild(currentLevel);
				
			currentLevel = LevelFactory.createLevel(level);
			addChild(currentLevel);
			currentLevel.resume();
		}
		
		private function onKeyPress(e:KeyboardEvent){
			if(e.keyCode != Keyboard.P)
				return;
			
			if(!isPaused)
				addChild(pauseMenu);
			
			isPaused = true;
		}
	}
}
