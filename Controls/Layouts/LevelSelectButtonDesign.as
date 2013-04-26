﻿package Controls.Layouts {
	
	import flash.display.*;
	
	public class LevelSelectButtonDesign extends MovieClip {
		private var _levelId:int;
		
		public function get levelId() : int {
			return this._levelId;
		}
		
		public function set levelId(levelId:int) : void {
			this._levelId = levelId;
			this.idLevelLabel.text = String(levelId);
		}
	}
}