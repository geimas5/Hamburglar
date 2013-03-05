package Views {
	
	import flash.display.MovieClip;
	
	public class GameView extends ViewBase {
		
		private var levelId:int;
		
		public function GameView(level:int) {
			this.levelId = level;
			trace("Starting game on level", level);
		}
	}
}
