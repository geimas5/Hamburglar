package Pathfinding {
	
	public class Graph implements IGraph {
		private var verticies = new Array();
		private var edges = new Array();
		
		public function findEdgesBySource(source:Vertex) : Array {
			return edges[source.key];
		}
		
		public function getVertex(x:int, y:int) : Vertex {
			return verticies[x][y];
		}
		
		public function addEdge(edge:Edge) : void {
			ensureVertex(edge.source);
			ensureVertex(edge.destination);
			
			if(!(edge.source.key in edges))
				edges[edge.source.key] = new Array();
			
			edges[edge.source.key].push(edge);
		}
		
		public function resetForPathing() : void {
			for each(var arr:Array in this.verticies){
				for each(var v:Vertex in arr){
					v.previous = null;
					v.weight = int.MAX_VALUE;
				}
			}
		}
		
		private function ensureVertex(vertex:Vertex) : void {
			if(vertex.x in this.verticies && vertex.y in this.verticies[vertex.x])
				return;
				
			if(!(vertex.x in this.verticies))
				this.verticies[vertex.x] = new Array();
			
			this.verticies[vertex.x][vertex.y] = vertex;
		}
	}
}