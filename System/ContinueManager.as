package System {
	import Views.StartView;
	import flash.events.*;
	import flash.net.*;
	import System.*;
	
	public class ContinueManager {
		private var urlloader:URLLoader;
		private var startView:StartView;
		private var playerManager:PlayerManager;
		private var enableContinueButtonCallBack:Function;
		private var enableNextLevelButtonCallBack:Function;
		private var continueLevel:int;
		private var _nextLevel:int;
		
		public function ContinueManager(playerManager:PlayerManager) {
			this.playerManager = playerManager;
			urlloader = new URLLoader();
		}
		
		public function getNextLevel(levelId:int) : int {
			return levelId + 1;
		}
		
		public function hasNextLevel(levelId:int) : Boolean {
			if(levelId + 1 <= Configuration.MAX_SCORE)
				return true;
				
			return false;
		}
		
		public function hasContinueLevel(enableContinueButtonCallBack:Function) : void {
			this.enableContinueButtonCallBack = enableContinueButtonCallBack;
			
			var url:String = Configuration.HIGHSCORE_URL + "getContinueLevel.php?id=" + playerManager.getPlayerId() + "&rand=" + Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE, foundContinueLevel);
		}
		
		public function getContinueLevel() : int {
			return continueLevel;
		}
		
		private function foundContinueLevel(e:Event) : void {
			continueLevel = int(urlloader.data);
			
			if(continueLevel > 0) 
				enableContinueButtonCallBack();
				
			enableContinueButtonCallBack = null;
		}
	}
}