package Views {
	import flash.events.*;
	import Controls.*;
	import flash.display.*;
	import fl.controls.*;
	import Sounds.*;
	
	public class LevelSelectView extends ViewBase {
		
		private var selectedLevel:int = 0;

		public function LevelSelectView() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	
		public function init(evt:Event) : void {
			startGameButton.addEventListener(MouseEvent.CLICK, startGame);
			
			for(var i:int = 0; i < numChildren; i++) {
			    var child:DisplayObject = getChildAt(i);
				
				if(child is LevelSelectButton){
					child.addEventListener(MouseEvent.CLICK, onSelectLevel);
				}
			}
		}
		
		override public function getBackgroundMusic() : Array {
			var playlist:Array = new Array();
			playlist.push(new ElevatorMusic());
			return playlist;
		}
	
		public function startGame(evt:MouseEvent) {
			getViewManager().showGame(selectedLevel);
		}
		
		private function onSelectLevel(evt:MouseEvent) {
			var currentButton:LevelSelectButton = LevelSelectButton(evt.currentTarget);
			selectLevel(currentButton.levelId);
		}
		
		private function selectLevel(levelId:int) {
			selectedLevel = levelId;
			levelIdLabel.text = String(levelId);
			levelPreview.levelId = levelId;
		}
	}
}
