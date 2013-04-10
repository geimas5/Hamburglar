package System {
	import Views.StartView;
	import flash.events.*;
	import flash.net.*;
	import System.*;
	
	public class ContinueManager {
		public static var urlPath:String = "http://frigg.hiof.no/spillprg_v134/rc/php/";
		private var urlloader:URLLoader;
		private var startView:StartView;
		private var playerManager:PlayerManager;
		private var enableContinueButtonCallBack:Function;
		private var continueLevel:int;
		
		public function ContinueManager(playerManager:PlayerManager){
			this.playerManager = playerManager;
			urlloader = new URLLoader();
		}
		
		public function hasContinueLevel(enableContinueButtonCallBack:Function) : void{
			this.enableContinueButtonCallBack = enableContinueButtonCallBack;
			
			var url:String = urlPath+"getContinueLevel.php?id="+playerManager.getPlayerId()+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,foundContinueLevel);
		}
		
		public function getContinueLevel() : int{
			return continueLevel;
		}
		
		private function foundContinueLevel(e:Event){
			continueLevel = int(urlloader.data);
			if(continueLevel > 0) enableContinueButtonCallBack();
			enableContinueButtonCallBack = null;
		}
	}
}