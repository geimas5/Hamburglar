package Dialogs {
	import flash.display.*;
	import flash.events.*;
	
	public class GameOverDialog extends DialogBase {
		
		private var viewManager:ViewManager;
		private var level:int;
		
		public function GameOverDialog(container:MovieClip, level:int, viewManager:ViewManager) {
			super(container);
			
			this.viewManager = viewManager;
			this.level = level;
			
			addEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.REMOVED_FROM_STAGE, onDeInit);
		}
		
		private function onInit(e:Event){
			retryButton.addEventListener(MouseEvent.CLICK, onRetryClick);
			selectLevelButton.addEventListener(MouseEvent.CLICK, onSelectLevelButtonClick);
		}
		
		private function onDeInit(e:Event){
			retryButton.removeEventListener(MouseEvent.CLICK, onRetryClick);
			selectLevelButton.removeEventListener(MouseEvent.CLICK, onSelectLevelButtonClick);
		}
		
		private function onRetryClick(e:MouseEvent) {
			viewManager.showGame(level);
		}
		
		private function onSelectLevelButtonClick(e:MouseEvent) {
			viewManager.showLevelSelect();
		}
	}
}
