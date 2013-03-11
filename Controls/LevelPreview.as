package Controls {
	
	import flash.display.MovieClip;
	import Levels.*;
	
	
	public class LevelPreview extends MovieClip {
		
		private var _levelId:int;
		private var _currentPreview:LevelBase;
		
		
		public function LevelPreview() {
			// constructor code
		}
		
		public function get levelId() : int {
			return this._levelId;
		}
		
		public function set levelId(levelId:int) : void {
			this._levelId = levelId;
			
			updateLevelPreview();
		}
		
		private function updateLevelPreview() : void {
			if(_currentPreview != null)
				removeChild(_currentPreview);
			
			_currentPreview = LevelFactory.createLevel(this.levelId);
			
			_currentPreview.scaleY =  (this.height / 2) / _currentPreview.height;
			_currentPreview.scaleX = _currentPreview.scaleY;
			
			_currentPreview.x = 12;
			_currentPreview.y = 17;
			
			addChild(_currentPreview);
		}
	}
}
