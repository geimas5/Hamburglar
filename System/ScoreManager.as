package System {
	import flash.net.*;
	import flash.events.*;
	import System.*;
	import Views.LevelSelectView;
	
	public class ScoreManager {
		private var playerManager:PlayerManager;
		public static var urlPath:String = "http://frigg.hiof.no/spillprg_v134/rc/php/";
		private var urlloader:URLLoader;
		private var callBackSelectLevel:Function;
		private var _levelFinishedViewCallback:Function;
		
		public function ScoreManager(){
			playerManager = new PlayerManager();
			urlloader = new URLLoader();
		}
		
		public function getLevelScore(level,callBackSelectLevel:Function): void{
			this.callBackSelectLevel = callBackSelectLevel;
			var url:String = urlPath+"getScores.php?view=level&level="+level+"&id="+ playerManager.getPlayerId()+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreReceived);
		}
		
		private function levelScoreReceived(e:Event){
			urlloader.removeEventListener(Event.COMPLETE,levelScoreReceived);
			callBackSelectLevel(urlloader.data);
			callBackSelectLevel = null;
		}
		
		public function submitLevelScore(levelId:int,time:int,score:int,LevelFinishedViewCallback:Function){
			_levelFinishedViewCallback = LevelFinishedViewCallback;
			var md5:MD5 = new MD5();
			var hash:String = md5.encrypt("" + playerManager.getPlayerId() + (levelId * 3) + time + (score % 3));
			var url:String = urlPath+"registerScore.php?id=" + playerManager.getPlayerId() + "&level="+levelId+"&time="+time+"&score="+score+"&hash="+hash+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,levelScoreSubmitted);
		}
		
		public function levelScoreSubmitted(e:Event):void{
			urlloader.removeEventListener(Event.COMPLETE,levelScoreSubmitted);
			_levelFinishedViewCallback();
			_levelFinishedViewCallback = null;
		}
	}
}