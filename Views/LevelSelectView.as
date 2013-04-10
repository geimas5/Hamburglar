package Views {
	import flash.events.*;
	import flash.display.*;
	import fl.controls.*;
	import Controls.*;
	import Sounds.*;
	import System.*;
	
	public class LevelSelectView extends ViewBase {
		
		private var selectedLevel:int = 0;
		private var scoreManager:ScoreManager;

		public function LevelSelectView() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			scoreManager = new ScoreManager();
			updateLevelScoreLabel("0");
		}
	
		public function init(evt:Event) : void {
			startGameButton.addEventListener(MouseEvent.CLICK, startGame);
			selectLevel(1);
			for(var i:int = 0; i < numChildren; i++) {
			    var child:DisplayObject = getChildAt(i);
				
				if(child is LevelSelectButton){
					child.addEventListener(MouseEvent.CLICK, onSelectLevel);
				}
			}
		}
		
		public function updateLevelScoreLabel(score:String) : void{
			levelScoreLabel.text = score;
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
			scoreManager.getLevelScore(levelId,updateLevelScoreLabel);
		}
	}
}