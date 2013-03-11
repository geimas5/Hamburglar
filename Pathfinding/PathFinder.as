package Pathfinding {
	import flash.geom.*;
	import flash.display.*;
	import flash.utils.*
	
	public class PathFinder {
		
		private var _graphCoordinates:GraphCoordinates;
		private var _settled:Array = null;
    	private var _unSettled:Array = null;
		private var _vertexes:Array = new Array();
		private var _graph:IGraph = null;

		public function FindPath(start:Point, end:Point, graph:IGraph, graphCoordinates:GraphCoordinates) : Array {
			this._graphCoordinates = graphCoordinates;
			
			var startPoint = graphCoordinates.convertToGraphPoint(start);
			var endPoint = graphCoordinates.convertToGraphPoint(end);
			
			var startVertex:Vertex = graph.getVertex(startPoint.x, startPoint.y); 
			var endVertex:Vertex = graph.getVertex(endPoint.x, endPoint.y);
			
			this.initialize(graph.getVertex(startPoint.x, startPoint.y), graph);
			
			var foundPath:Boolean = false;
			
			while(this._unSettled.length > 0 && !foundPath) {
				var v:Vertex = findMin();
				
				removeArrayElement(_unSettled, v);
				
				_settled.push(v);
				
				for each(var e:Edge in graph.findEdgesBySource(v)) {
					var u:Vertex = e.destination;
					
					if(arrayContainsElement(this._unSettled, u)) {
						var origDist:int = u.weight;
						var currDist:int = v.weight + e.weight;
						
						if(currDist < origDist) {
							u.previous = v;
							u.weight = currDist;
							if(u == endVertex)
								foundPath = true;
						}
					}
					else if(!arrayContainsElement(this._settled, u)) {
						u.previous = e.source;
						u.weight = v.weight + e.weight;
						this._unSettled.push(u);
						if(u == endVertex)
							foundPath = true;
					}
				}
			}
		
			return backtrackPath(graph, graphCoordinates, endVertex);
		}
		
		private function initialize(startPoint:Vertex, graph:IGraph) {
			this._graph = graph;
        	this._settled = new Array();
        	this._unSettled = new Array();
			
        	this._unSettled.push(startPoint);
			
			graph.resetForPathing();
			startPoint.weight = 0;
		}
		
		private function backtrackPath(graph:IGraph, graphCoordinates:GraphCoordinates, endVertex:Vertex) : Array {
			var path:Array = new Array();
			
			var current:Vertex = endVertex;
			while(current != null) {
				var currentPoint = new Point(current.x, current.y);
				path.push(graphCoordinates.convertFromGraphPoint(currentPoint));
				current = current.previous
			}
			
			return path;
		}
		
		private function findMin() : Vertex {
			var min:Vertex = null;
			var dist:int = int.MAX_VALUE;
			
			for each(var p:Vertex in this._unSettled) {
				var vDist:int = p.weight;
				
				if(vDist < dist || dist == int.MAX_VALUE) {
					min = p;
					dist = vDist;
				}
			}
			
			return min;
		}
		
		private function removeArrayElement(arr:Array, p:Vertex) : void {
			var index = arr.indexOf(p);
			
			arr.splice(index, 1);
		}
		
		private function arrayContainsElement(arr:Array, p:Vertex) : Boolean {
			return arr.indexOf(p) != -1;
		}
	}
}