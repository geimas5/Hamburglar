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
		}
		
		public function showGame() : void {
			setView(new GameView());
		}
		
		public function showMenu() : void {
			setView(new StartView());
		}
	}
}
