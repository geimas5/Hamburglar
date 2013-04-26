package System {
	import flash.net.*;
	import flash.events.*;
	import System.*;
	import Views.*;
	
	public class ScoreManager {
		private var playerManager:PlayerManager;
		private var urlloader:URLLoader;
		private var callBackSelectLevel:Function;
		private var _levelFinishedViewCallback:Function;
		
		public function ScoreManager(){
			playerManager = new PlayerManager();
			urlloader = new URLLoader();
		}
		
		public function getPlayerManager() : PlayerManager{
			return playerManager;
		}
		
		public function getLevelScore(level,selectLevelCallBack:Function): void{
			this.callBackSelectLevel = selectLevelCallBack;
			var url:String = Configuration.HIGHSCORE_URL + "getScores.php?view=level&level=" + level + "&id=" + playerManager.getPlayerId() + "&rand=" + Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreReceived);
		}
		
		public function submitLevelScore(levelId:int, time:int, score:int, levelFinishedViewCallback:Function){
			_levelFinishedViewCallback = levelFinishedViewCallback;
			var md5:MD5 = new MD5();
			var hash:String = md5.encrypt("" + playerManager.getPlayerId() + (levelId * 3) + time + (score % 3));
			var url:String = Configuration.HIGHSCORE_URL + 
								"registerScore.php?id=" + playerManager.getPlayerId() + 
								"&level=" + levelId + 
								"&time=" + time + 
								"&score=" + score + 
								"&hash=" + hash + 
								"&rand=" + Math.random();
								
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreSubmitted);
		}
		
		private function levelScoreReceived(e:Event){
			urlloader.removeEventListener(Event.COMPLETE,levelScoreReceived);
			callBackSelectLevel(urlloader.data);
			callBackSelectLevel = null;
		}
		
		private function levelScoreSubmitted(e:Event) : void{
			urlloader.removeEventListener(Event.COMPLETE, levelScoreSubmitted);
			_levelFinishedViewCallback();
			_levelFinishedViewCallback = null;
		}
	}
}