package System {
	import flash.net.*;
	import flash.events.*;
	import System.*;
	import Views.LevelSelectView;
	
	public class ScoreManager {
		private var playerManager:PlayerManager;
		public static var urlPath:String = "http://frigg.hiof.no/spillprg_v134/rc/php/";
		private var urlloader:URLLoader;
		private var levelSelectView:LevelSelectView;
		
		public function ScoreManager(levelSelectView:LevelSelectView){
			this.levelSelectView = levelSelectView;
			playerManager = new PlayerManager();
			urlloader = new URLLoader();
		}
		
		public function getLevelScore(level): void{
			var url:String = urlPath+"getScores.php?view=level&level="+level+"&id="+ playerManager.getPlayerId()+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreReceived);
		}
		
		private function levelScoreReceived(e:Event){
			levelSelectView.updateLevelScoreLabel(urlloader.data);
		}
		
		public function submitLevelScore(levelId:int,time:int,score:int){
			//levelId:int,startTime:,endTime:,score:int
			var md5:MD5 = new MD5();
			var hash:String = md5.encrypt("" + playerManager.getPlayerId() + (levelId * 3) + time + (score % 3));
			var url:String = urlPath+"registerScore.php?id=" + playerManager.getPlayerId() + "&level="+levelId+"&time="+time+"&score="+score+"&hash="+hash+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreReceived);
		}
	}
}