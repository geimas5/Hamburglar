package Views {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class StartView extends ViewBase {
		
		public function StartView() {
			addEventListener(Event.ADDED_TO_STAGE, initButtons);
		}
		
		public function initButtons(evt:Event) : void {
			startGameButton.addEventListener(MouseEvent.CLICK, startGame);
			levelSelectButton.addEventListener(MouseEvent.CLICK, showLevelSelectView);
		}
		
		public function startGame (evt:MouseEvent) : void {
			getViewManager().showGame(2); 
		}
		
		public function showLevelSelectView (evt:MouseEvent) : void {
			getViewManager().showLevelSelect(); 
		}
		
	}
	
}
