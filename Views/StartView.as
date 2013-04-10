package Views {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import System.*;
	
	public class StartView extends ViewBase {
		private var continueManager:ContinueManager;
		private var playerManager:PlayerManager;
		
		public function StartView() {
			playerManager = new PlayerManager();
			continueManager = new ContinueManager(playerManager);
			addEventListener(Event.ADDED_TO_STAGE, initButtons);
		}
		
		public function getPlayerManager() : PlayerManager{
			return playerManager;
		}
		
		public function enableContinueButton() : void {
			startGameButton.enabled = true;
			startGameButton.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		public function initButtons(evt:Event) : void {
			startGameButton.enabled = false;
			levelSelectButton.addEventListener(MouseEvent.CLICK, showLevelSelectView);
			setNameButton.addEventListener(MouseEvent.CLICK, callSetPlayerName);
			playerManager.getPlayerName(updateNameLabel);
			continueManager.hasContinueLevel(enableContinueButton);
		}
		
		public function callSetPlayerName(e:Event) : void{
			playerManager.setPlayerName(nameLabel.text);
		}
		
		public function updateNameLabel(name:String) : void{
			nameLabel.text = name;
		}
		
		public function startGame (evt:MouseEvent) : void {
			getViewManager().showGame(continueManager.getContinueLevel()); 
		}
		
		public function showLevelSelectView (evt:MouseEvent) : void {
			getViewManager().showLevelSelect(); 
		}
		
	}
	
}
