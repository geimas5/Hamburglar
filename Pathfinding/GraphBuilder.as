package Pathfinding {
	import flash.geom.*;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	public class GraphBuilder {
		private var graphCoordinates:GraphCoordinates = null;
		private var obstacles:Array;
		private var bounds:Rectangle;
		private var graphHeight:int;
		private var graphWidth:int;
		
		private var workingGraph:Graph = null;
		
		private var verticies:Array = null;
		private var edges:Array = null;
		
		public function GraphBuilder(obstacles:Array, bounds:Rectangle, graphCoordinates:GraphCoordinates) {
			this.obstacles = obstacles;
			this.graphCoordinates = graphCoordinates;
			this.bounds = bounds;
			this.graphHeight = graphCoordinates.convertToGraph(bounds.height);
			this.graphWidth = graphCoordinates.convertToGraph(bounds.width);
		}
		
		public function buildGraph() : IGraph {
			this.workingGraph = new Graph();
			this.verticies = new Array();
			this.edges = new Array();
			
			generateVerticies();
			generateEdges();
			
			for each(var edge:Edge in this.edges) {
				workingGraph.addEdge(edge);
			}
			
			return workingGraph;
		}
		
		private function generateVerticies() : void {
			for(var x = 0; x < graphWidth; x++) {
				verticies[x] = new Array();
				
				for(var y = 0; y < graphHeight; y++) {
					if(isBlocked(x, y))
						verticies[x][y] = null;
					else
						verticies[x][y] = new Vertex(x, y, 1);
				}
			}
		}
		
		private function generateEdges() : void {
			for(var x = 0; x < graphWidth; x++) {				
				for(var y = 0; y < graphHeight; y++) {
					
					for(var dx = -1; dx <= 1; dx++){
						for(var dy = -1; dy <= 1; dy++) {
							var testX = (x + dx);
							var testY = (y + dy);
							
							var weight:int = 1;
							if(Math.abs(dx) + Math.abs(dy) == 2)
								weight = 2;
							
							if(testX >= 0 && testY >= 0 && testX < graphWidth && testY < graphHeight && verticies[testX][testY] != null) {
								if(verticies[x][y] == null || verticies[testX][testY] == null)
									continue;
									
								this.edges.push(new Edge(verticies[x][y], verticies[testX][testY], weight));
							}
						}
					}
				}
			}
		}
		
		private function isBlocked(x:int, y:int) : Boolean {
			for each(var o:MovieClip in obstacles) {
				var startX = this.graphCoordinates.convertFromGraph(x - 1) + (this.graphCoordinates.resolution / 2);
				var startY = this.graphCoordinates.convertFromGraph(y - 1) + (this.graphCoordinates.resolution / 2);
				
				for(var tX = startX; tX < startX + this.graphCoordinates.resolution; tX++){
					for(var tY = startY; tY < startY + this.graphCoordinates.resolution; tY++){
						if(o.hitTestPoint(tX, tY, true))
							return true;
					}
				}
			}
			return false;
		}
	}
}