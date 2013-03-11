package Pathfinding {
	import flash.geom.*;
	
	public class GraphCoordinates {
		
		private var _resolution:int;

		public function GraphCoordinates(resolution) {
			_resolution = resolution;
		}
		
		public function get resolution() : int {
			return this._resolution;
		}
		
		public function convertToGraph(coordinate:Number) : int {
			return Math.floor(coordinate / _resolution);
		}
		
		public function convertToGraphPoint(point:Point) : Point {
			return new Point(convertToGraph(point.x), convertToGraph(point.y));
		}
		
		public function createGraphPoint(x:Number, y:Number) : Point {
			return new Point(convertToGraph(x), convertToGraph(y));
		}
		
		public function convertFromGraph(coordinate:int) : Number {
			return (coordinate * _resolution) + (_resolution / 2);
		}
		
		public function convertFromGraphPoint(point:Point) : Point {
			return new Point(convertFromGraph(point.x), convertFromGraph(point.y));
		}
	}
}
