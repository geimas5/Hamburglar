package Pathfinding {
	
	public class Vertex {

		private var _x:int;
		private var _y:int;
		private var _weight:Number;
		private var _previous:Vertex = null;
		private var _key:String = null;

		public function Vertex(x:int, y:int, weight:int) {
			this._x = x;
			this._y = y;
			this._weight = weight;
			this._key = x + "-" + y;
		}

		public function get x() : int {
			return this._x;
		}
		
		public function get y() : int{
			return this._y;
		}
		
		public function get weight() : Number {
			return this._weight;
		}
		
		public function set weight(value:Number) {
			this._weight = value;
		}
		
		public function get previous() : Vertex {
			return this._previous;
		}
		
		public function set previous(value:Vertex){
			this._previous = value;
		}
		
		public function get key() : String {
			return this._key;
		}
	}
}