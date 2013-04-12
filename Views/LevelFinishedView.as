package Views {
	import System.PlayerManager;
	import flash.events.*;
	import System.ScoreManager;
	
	public class LevelFinishedView extends ViewBase {
		
		private var _score:int;
		private var _scoreManager:ScoreManager;
		private var _levelId:int;
		private var _time:int;

		public function LevelFinishedView(time:int,levelId:int) {
			_scoreManager = new ScoreManager();
			_time = time;
			_score = (Configuration.MAX_SCORE - time) < 0 ? 0 : (Configuration.MAX_SCORE - time);
			_levelId = levelId;
			_scoreManager.submitLevelScore(_levelId,_time,_score,scoreSubmitted);
			addEventListener(Event.ADDED_TO_STAGE,onInit);
		}
		
		private function onInit(e:Event) : void{
			nextLevelButton.enabled = false;
			selectLevelButton.enabled = false;
			retryButton.enabled = false;
			mainMenuButton.enabled = false;
			setLevelIdLabel(_levelId);
			setScoreLabel(_score);
			setTimeLabel(_time);
		}
		
		private function scoreSubmitted():void{
			if(hasNextLevel()){
				nextLevelButton.enabled = true;
				nextLevelButton.addEventListener(MouseEvent.CLICK,nextLevel);
			}
			selectLevelButton.enabled = true;
			selectLevelButton.addEventListener(MouseEvent.CLICK,selectLevel);
			retryButton.enabled = true;
			retryButton.addEventListener(MouseEvent.CLICK,retry);
			mainMenuButton.enabled = true;
			mainMenuButton.addEventListener(MouseEvent.CLICK,mainMenu);
		}
		
		public function setLevelIdLabel(level:int):void{
			levelIdLabel.text = "Level: " + level;
		}
		
		public function setScoreLabel(score:int):void{
			scoreLabel.text = "" + score;
		}
		
		public function setTimeLabel(time:int):void{
			time /= 1000;
			var sec:int = time % 60;
			var min:int = (time - sec) / 60;
			timeLabel.text = twoDigit(min) + ":" + twoDigit(sec);
		}
		
		private function twoDigit(digits:int){
			var digit:String = String(digits);
			if(digit.length > 1)return digit;
			return "0" + digit;

		}
		
		private function hasNextLevel() : Boolean{
			if(_levelId+1 <= Configuration.LEVEL_COUNT) return true;
			return false;
		}
		
		private function nextLevel(e:Event) : void{
			getViewManager().showGame(_levelId+1);
		}
		
		private function selectLevel(e:Event) : void{
			getViewManager().showLevelSelect();
		}
		
		private function retry(e:Event) : void{
			getViewManager().showGame(_levelId);
		}
		
		private function mainMenu(e:Event) : void{
			getViewManager().showMenu();
		}
	}
}
