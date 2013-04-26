package Dialogs {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import Views.*;
	import System.*;
	
	public class PauseMenuDialog extends DialogBase {
		private var viewManager:ViewManager = null;
		private var gameView:GameView = null;
		
		public function PauseMenuDialog(container:MovieClip, viewManager:ViewManager, gameView:GameView) {
			super(container);
			
			addEventListener(Event.ADDED_TO_STAGE, initButtons);
			this.viewManager = viewManager;
			this.gameView = gameView;
		}
		
		private function initButtons(evt:Event) : void {
			continueGameButton.addEventListener(MouseEvent.CLICK, continueGame);
			levelSelectButton.addEventListener(MouseEvent.CLICK, showLevelSelectView);
			mainMenuButton.addEventListener(MouseEvent.CLICK, showMainMenu);
		}
		private function continueGame(evt:MouseEvent) : void {
			gameView.resume();
		}
		
		private function showLevelSelectView(evt:MouseEvent) : void {
			viewManager.showLevelSelect();
		}
		
		private function showMainMenu(evt:MouseEvent) : void {
			viewManager.showMenu(); 
		}
	}
}
