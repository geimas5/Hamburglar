package  {
	import flash.display.*;
	import Views.*;
	import flash.events.Event;
	
	public class ViewManager extends MovieClip {

		private var activeView:ViewBase = null;
		
		public function ViewManager() {
			this.showMenu();
		}
		
		private function setView(view:ViewBase) : void {
			if(activeView != null)
				removeChild(activeView);
			
			this.activeView = view;
			this.activeView.setViewManager(this);
			addChild(activeView);
			MusicPlayer.getInstance().setView(this.activeView);
		}
		
		public function showGame(level:int) : void {
			setView(new GameView(level));
		}
		
		public function showLevelFinished(score:int) : void {
			setView(new LevelFinishedView(score));
		}
		
		public function showLevelSelect() : void {
			setView(new LevelSelectView());
		}
		
		public function showMenu() : void {
			setView(new StartView());
		}
	}
}
