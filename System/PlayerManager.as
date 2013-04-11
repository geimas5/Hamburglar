package System {
	import flash.net.*;
	import flash.events.*;

	public class PlayerManager {
		public static var urlPath:String = "http://frigg.hiof.no/spillprg_v134/rc/php/";
		private var urlloader:URLLoader;
		private var playerId:int;
		private var sharedObject:SharedObject;
		private var getPlayerNameCallBack:Function = null;
		
		public function PlayerManager(){
			urlloader = new URLLoader();
			sharedObject = SharedObject.getLocal("Hamburglar");
			if(isRegistered()){
				playerId = sharedObject.data.playerId;
			}
			else{
				registerNewPlayer();
			}
		}
		
		public function setPlayerName(playerName:String) : void{
			var url:String = urlPath+"player.php?action=setName&id="+playerId+"&name="+playerName+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
		}
		
		private function playerNameFound(e:Event){
			urlloader.removeEventListener(Event.COMPLETE,playerNameFound);
			getPlayerNameCallBack(urlloader.data);
			getPlayerNameCallBack = null;
		}
		
		public function getPlayerName(getPlayerNameCallBack:Function) : void{
			this.getPlayerNameCallBack = getPlayerNameCallBack;

			var url:String = urlPath+"player.php?action=getName&id="+playerId+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,playerNameFound);
		}
		
		private function isRegistered():Boolean{
			if(sharedObject.data.hasOwnProperty("playerId")){
				return true;
			}
			return false;
		}
		
		public function registerNewPlayer(){
			var url:String = urlPath+"player.php?action=new&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,newPlayerRegistered);
		}
		
		private function newPlayerRegistered(e:Event){
			urlloader.removeEventListener(Event.COMPLETE,newPlayerRegistered);
			playerId = int(urlloader.data);
			sharedObject.data.playerId = playerId;
		}
		
		public function getPlayerId():int{
			return playerId;
		}
	}
}