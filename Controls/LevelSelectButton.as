package Controls {
	
	import fl.core.*;
	import Controls.Layouts.*;
	
	public class LevelSelectButton extends UIComponent {
		
		private var _levelId:int;
		private var layout:LevelSelectButtonDesign;
		
		public function LevelSelectButton() {
		}
		
		[Inspectable(DefaultValue=0)]
		public function get levelId() : int {
			return this._levelId;
		}
		
		public function set levelId(levelId:int) : void {
			this._levelId = levelId;
			
			layout.levelId = levelId;
			validateNow();
		}
		
		override protected function configUI() : void {
			super.configUI();
		
			layout = new LevelSelectButtonDesign();
			layout.levelId = this._levelId;
			
			addChild(layout);
		}
	}
}
