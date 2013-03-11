package Pathfinding {
	import flash.geom.*;
	
	public class Edge {
		
		private var _source:Vertex;
		private var _destination:Vertex;
		private var _weight;
		
		public function Edge(source:Vertex, destination:Vertex, weight:int) {
			this._source = source;
			this._destination = destination;
			this._weight = weight;
		}
		
		public function get source() : Vertex {
			return this._source;
		}
		
		public function get destination() : Vertex {
			return this._destination;
		}
		
		public function get weight() : int {
			return this._weight;
		}
	}
}
