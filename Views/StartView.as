package Views {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class StartView extends ViewBase {
		
		public function StartView() {
			addEventListener(Event.ADDED_TO_STAGE, startButton);
		}
		
		public function startButton(evt:Event) : void {
			startGameButton.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		public function startGame (evt:MouseEvent) : void {
			getViewManager().showGame(); 
		}
		
	}
	
}
