package Dialogs {
	import flash.display.*;
	
	public class DialogBase extends MovieClip {
		
		private var _isVisible:Boolean = false;
		private var _container:MovieClip = null;
		
		public function DialogBase(container:MovieClip) {
			_container = container;
		}
		
		public function show() {
			
			x = (_container.width / 2) - (width / 2);
			y = (_container.height / 2) - (height / 2);
			
			if(!_isVisible)
				_container.addChild(this);
			
			_isVisible = true;
		}
		
		public function hide() {
			if(_isVisible)
				_container.removeChild(this);
				
			_isVisible = false;
		}
	}	
}
