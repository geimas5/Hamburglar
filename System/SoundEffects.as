package System {
	
	import flash.display.*;
	import Sounds.Effects.*;
	
	public class SoundEffects {		
		public static function GameOver() : void {
			var sound:GameOverSound = new GameOverSound();
			sound.play();
		}
		
		public static function GuardSuspect() : void {
			var sound:GuardSuspectSound = new GuardSuspectSound();
			sound.play();
		}
	}
}
