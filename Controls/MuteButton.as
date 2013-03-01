package Controls {
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MuteButton extends MovieClip {
		
		public function MuteButton(){
			this.addEventListener(MouseEvent.CLICK, onMuteButtonClick);
		}
		
		public function onMuteButtonClick(evt:MouseEvent) : void {
			trace("hello");
		}
	
	}
}
