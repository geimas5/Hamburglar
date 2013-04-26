package System {
	import flash.net.*;
	import flash.events.*;

	public class PlayerManager {
		private var urlloader:URLLoader;
		private var _playerId:int;
		private var _sharedObject:SharedObject;
		private var _getPlayerNameCallBack:Function = null;
		private var _gotPlayerIdCallBack:Function = null;
		
		
		public function activate(gotPlayerIdCallBack:Function) : void {
			_gotPlayerIdCallBack = gotPlayerIdCallBack;
			urlloader = new URLLoader();
			_sharedObject = SharedObject.getLocal("Hamburglar","/");
			if(isRegistered()) {
				_playerId = _sharedObject.data.playerId;
				_gotPlayerIdCallBack();	
			}
			else{
				registerNewPlayer();
			}		
		}
		
		public function setPlayerName(playerName:String) : void {
			var url:String = Configuration.HIGHSCORE_URL  + "player.php?action=setName&id=" + _playerId +"&name=" + playerName + "&rand=" + Math.random();
			urlloader.load(new URLRequest(url));
		}
		
		public function getPlayerName(getPlayerNameCallBack:Function) : void {
			_getPlayerNameCallBack = getPlayerNameCallBack;

			var url:String = Configuration.HIGHSCORE_URL + "player.php?action=getName&id=" + _playerId + "&rand=" + Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE, playerNameFound);
		}
		
		public function getPlayerId():int{
			return _playerId;
		}
		
		public function registerNewPlayer(){
			var url:String = Configuration.HIGHSCORE_URL + "player.php?action=new&rand=" + Math.random();
			urlloader.load(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE, newPlayerRegistered);
		}
		
		private function playerNameFound(e:Event){
			urlloader.removeEventListener(Event.COMPLETE, playerNameFound);
			_getPlayerNameCallBack(urlloader.data);
			_getPlayerNameCallBack = null;
		}
		
		private function isRegistered() : Boolean {
			if(_sharedObject.data.playerId != undefined)
				return true;
			
			return false;
		}
		
		private function newPlayerRegistered(e:Event) {
			urlloader.removeEventListener(Event.COMPLETE,newPlayerRegistered);
			_playerId = int(urlloader.data);
			_sharedObject.data.playerId = _playerId;
			_sharedObject.flush(100);
			_gotPlayerIdCallBack();	
		}
	}
}