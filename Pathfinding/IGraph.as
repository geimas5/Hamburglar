package Pathfinding {
	
	public interface IGraph {
		function findEdgesBySource(source:Vertex) : Array;
		function getVertex(x:int, y:int) : Vertex;
		function addEdge(edge:Edge) : void;
		function resetForPathing() : void;
	}
}
