package System {
	import flash.net.*;
	import flash.events.*;
	import System.*;
	
	public class ScoreManager {
		private var selectedLevelScore:int;
		private var playerManager:PlayerManager;
		private var playerId:int;
		public static var urlPath:String = "http://frigg.hiof.no/spillprg_v134/p2/php/";
		private var urlloader:URLLoader;
		
		public function ScoreManager(){
			playerManager = new PlayerManager();
			playerId = playerManager.getPlayerId();
			urlloader = new URLLoader();
		}
		
		public function setSelectedLevelScore(level:int){
			var url:String = urlPath+"getScores.php?view=level&level="+level+"&id="+playerId+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreReceived);
		}
		
		public function getSelectedLevelScore():int{
			return selectedLevelScore;
		}
		
		private function levelScoreReceived(e:Event){
			selectedLevelScore = int(urlloader.data);
		}
		
		public function submitLevelScore(levelId:int,time:int,score:int){
			//levelId:int,startTime:,endTime:,score:int
			var md5:MD5 = new MD5();
			var hash:String = md5.encrypt("" + playerId + (levelId * 3) + time + (score % 3));
			var url:String = urlPath+"registerScore.php?id="+playerId+"&level="+levelId+"&time="+time+"&score="+score+"&hash="+hash+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreReceived);
		}
	}
}