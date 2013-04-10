package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import Views.*;
	
	public class PauseMenu extends MovieClip {
		private var viewManager:ViewManager = null;
		private var gameView:GameView = null;
		
		public function PauseMenu(viewManager:ViewManager, gameView:GameView) {
			addEventListener(Event.ADDED_TO_STAGE, initButtons);
			this.viewManager = viewManager;
			this.gameView = gameView;
		}
		
		public function initButtons(evt:Event) : void {
			continueGameButton.addEventListener(MouseEvent.CLICK, continueGame);
			levelSelectButton.addEventListener(MouseEvent.CLICK, showLevelSelectView);
			mainMenuButton.addEventListener(MouseEvent.CLICK, showMainMenu);
		}
		public function continueGame(evt:MouseEvent) : void {
			gameView.resume();
		}
		
		public function showLevelSelectView(evt:MouseEvent) : void {
			viewManager.showLevelSelect();
		}
		
		public function showMainMenu(evt:MouseEvent) : void {
			viewManager.showMenu(); 
		}
	}
}
