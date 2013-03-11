package Controls {
	
	import flash.display.MovieClip;
	import fl.core.*;
	
	public class Waypoint extends UIComponent {
		
		private var _guardId:Number = 0;
		private var _waypointId:Number = 0;
		
		public function Waypoint() {
			// constructor code
		}
		
		[Inspectable(defaultValue=0)]
		public function get guardId() : Number{
			return this._guardId;
		}
		
		public function set guardId(guardId:Number) {
			this._guardId = guardId;
		}
		
		[Inspectable(defaultValue=0)]
		public function get waypointId() : Number{
			return this._waypointId;
		}
		
		public function set waypointId(waypointId:Number) {
			this._waypointId = waypointId;
		}
	}
}
