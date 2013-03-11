package Views {
	
	import flash.display.*;
	import Levels.*;
	
	public class GameView extends ViewBase {
		
		private var levelId:int;
		
		private var currentLevel:LevelBase;
		
		public function GameView(level:int) {
			setLevel(level);
		}
		
		private function setLevel(level:int) {
			this.levelId = level
			if(currentLevel != null)
				removeChild(currentLevel);
				
			currentLevel = LevelFactory.createLevel(level);
			addChild(currentLevel);
		}
	}
}
