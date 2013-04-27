package System {
	import flash.media.*;
	import flash.events.*;
	import Views.*;
	
	public class MusicPlayer {
		private static var _instance:MusicPlayer = null;
		
		private var soundChannel:SoundChannel = null;
		private var currentView:ViewBase = null;
		private var currentPlaylist:Array = new Array();
		
		public static function getInstance() : MusicPlayer {
			if(MusicPlayer._instance == null){
				MusicPlayer._instance = new MusicPlayer();
			}
			
			return MusicPlayer._instance;
		}
		
		public function setView(view:ViewBase) : void {				
			currentView = view;
			
			currentPlaylist = currentView.getBackgroundMusic();
			playNext(null);
		}
		
		private function playNext(e:Event) {
			if(soundChannel != null)
				soundChannel.stop();
				
			if(currentPlaylist.length < 1)
				return;
			
			soundChannel = currentPlaylist[int(Math.random() * currentPlaylist.length)].play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, playNext);
		}
	}
}
