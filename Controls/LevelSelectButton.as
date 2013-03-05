package Controls {
	
	import fl.core.*;
	
	public class LevelSelectButton extends UIComponent {
		
		private var _levelId:int;
		
		public function LevelSelectButton() {
		}
		
		[Inspectable(DefaultValue=0)]
		public function get levelId() : int {
			return this._levelId;
		}
		
		public function set levelId(levelId:int) : void {
			this._levelId = levelId;
			
			this.idLevelLabel.text = String(levelId);
		}
	}
}
