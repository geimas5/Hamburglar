package Views {
		import flash.events.*;
		import Controls.*;
		import flash.display.*;
		import fl.controls.SelectableList;
	
	public class LevelSelectView extends ViewBase {
		
		private var selectedLevel:int = 0;

		public function LevelSelectView() {
			addEventListener(Event.ADDED_TO_STAGE, initButtons);
		}
	
		public function initButtons(evt:Event) : void {
			startGameButton.addEventListener(MouseEvent.CLICK, startGame);
			
			for(var i:int = 0; i < numChildren; i++) {
			    var child:DisplayObject = getChildAt(i);
				
				if(child is LevelSelectButton){
					child.addEventListener(MouseEvent.CLICK, onSelectLevel);
				}
			}
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
