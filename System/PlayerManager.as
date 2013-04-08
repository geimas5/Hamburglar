package System {
	import flash.net.*;
	import flash.events.*;

	public class PlayerManager {
		public static var urlPath:String = "http://frigg.hiof.no/spillprg_v134/p2/php/";
		private var urlloader:URLLoader;
		private var playerId:int;
		private var sharedObject:SharedObject;
		
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
		
		public function registerPlayerName(name:String){
			var url:String = urlPath+"player.php?action=setName&id="+playerId+"&name="+name+"&rand="+Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE,playerNameRegistered);
		}
		
		private function playerNameRegistered(e:Event){
			trace("name changed");
		}
		
		private function newPlayerRegistered(e:Event){
			playerId = int(urlloader.data);
			sharedObject.data.playerId = playerId;
		}
		
		public function getPlayerId():int{
			return playerId;
		}
	}
}