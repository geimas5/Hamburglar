package Views {
	import flash.display.*;
	
	public class ViewBase extends MovieClip {
	
		private var viewManager:ViewManager;
	
		public function setViewManager(viewManager:ViewManager) : void {
			this.viewManager = viewManager;
		}
		
		public function getViewManager() : ViewManager {
			return viewManager;
		}
	
		public function ViewBase() {
		}
		
		public function getBackgroundMusic() : Array {
			return new Array();
		}
		
	}
}
