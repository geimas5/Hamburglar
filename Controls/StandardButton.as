package Controls {
	import fl.core.*;
	import Controls.Layouts.*;
	
	public class StandardButton extends UIComponent {
		
		private var _text:String;
		private var layout:StandardButtonDesign;
		
		[Inspectable(DefaultValue=0)]
		public function get text() : String {
			return this._text;
		}
		
		public function set text(text:String) : void {
			this._text = _text;
			
			layout.text = text;
			validateNow();
		}
		
		override protected function configUI() : void {
			super.configUI();
		
			layout = new StandardButtonDesign();
			layout.text = this._text;
			
			addChild(layout);
		}
	}
}
