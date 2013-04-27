package Views {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import System.*;
	
	public class StartView extends ViewBase {
		private var continueManager:ContinueManager;
		private var playerManager:PlayerManager;
		
		public function StartView() {
			playerManager = new PlayerManager();
			playerManager.activate(playerManagerReady);
			addEventListener(Event.ADDED_TO_STAGE, initButtons);
		}
		
		private function playerManagerReady() : void{
			continueManager = new ContinueManager(playerManager);
			continueManager.hasContinueLevel(enableContinueButton);
			playerManager.getPlayerName(updateNameLabel);
		}
		
		private function enableContinueButton() : void {
			startGameButton.enabled = true;
			startGameButton.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function initButtons(evt:Event) : void {
			startGameButton.enabled = false;
			levelSelectButton.addEventListener(MouseEvent.CLICK, showLevelSelectView);
			setNameButton.addEventListener(MouseEvent.CLICK, callSetPlayerName);
		}
		
		private function callSetPlayerName(e:Event) : void{
			playerManager.setPlayerName(nameLabel.text);
		}
		
		private function updateNameLabel(name:String) : void{
			nameLabel.text = name;
		}
		
		private function startGame (evt:MouseEvent) : void {
			getViewManager().showGame(continueManager.getContinueLevel()); 
		}
		
		private function showLevelSelectView (evt:MouseEvent) : void {
			getViewManager().showLevelSelect(); 
		}
		
	}
	
}
