package System {
	
	import flash.display.*;
	import Sounds.Effecs.*;
	
	public class SoundEffects {		
		public static function GameOver() : void {
			var sound:GameOverSound = new GameOverSound();
			sound.play();
		}
		
		public static function GuardSuspect() : void {
			var sound:Sounds.Effecs.GuardSuspectSound = new Sounds.Effecs.GuardSuspectSound();
			sound.play();
		}
	}
}
