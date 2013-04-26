package Controls {
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	
	public class MuteButton extends MovieClip {
		private var audioTransform:SoundTransform = new SoundTransform();
		
		public function MuteButton(){
			this.addEventListener(MouseEvent.CLICK, onMuteButtonClick);
			this.stop();
			this.buttonMode = true;
		}
		
		public function onMuteButtonClick(evt:MouseEvent) : void {
			setVolume((audioTransform.volume + 1) % 2);
		}
	
		private function setVolume(volume:int) {
			audioTransform.volume = volume;
			SoundMixer.soundTransform = audioTransform;
			
			if(volume > 0)
				gotoAndStop("NotMuted");
			else
				gotoAndStop("Muted");
		}
	}
}
