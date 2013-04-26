package Controls.Layouts {
	
	import flash.display.MovieClip;
	
	public class StandardButtonDesign extends MovieClip {
		private var _text:String;
		
		public function get text() : String  {
			return this._text;
		}
		
		public function set text(text:String) : void {
			this._text = text;
			this.buttonText.text = _text == null ? "" : _text;
		}
	}
}
