package GameObjects {
	
	import fl.core.UIComponent;
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import flash.events.*;
	import Controls.*;
	import Pathfinding.*;
	
	public class Guard extends UIComponent implements ITimeAware, ISecurityObject {
		
		private var _obstacles:Array;
		private var _waypoints:Array;
		private var walkingSpeed:Number = 4;
		private var currentWaypoint:Number = -1;
		
		private var _id:Number = 0;
		
		private var currentWalkingCheckpoints:Array = new Array();
		private var activeWalkingCheckpoint:Point = null;
		
		private var _graphCoordinates:GraphCoordinates = null;
		private var _graph:IGraph = null;
		
		public function Guard() {
			viewField.detectionRadius = Configuration.GUARD_DETECTION_RADIUS;
			viewField.suspectRadius = Configuration.GUARD_SUSPECT_RADIUS;
		}
		
		[Inspectable(defaultValue=0)]
		public function get id() : Number {
			return this._id;
		}
		
		public function set id(id:Number) : void {
			this._id = id;
		}
		
		public function get obstacles() : Array {
			return this._obstacles;
		}
		
		public function set obstacles(arr:Array) : void {
			this._obstacles = arr;
			this.viewField.obstacles = arr;
		}
		
		public function get waypoints() : Array {
			return this._waypoints;
		}
		
		public function set waypoints(arr:Array) : void {
			this._waypoints = arr;
			this.nextWaypoint();
		}
		
		public function get graph() : IGraph {
			return this._graph;
		}
		
		public function set graph(graph:IGraph) : void {
			this._graph = graph;
		}
		
		public function get graphCoordinates() : GraphCoordinates {
			return this._graphCoordinates;
		}
		
		public function set graphCoordinates(graphCoordinates:GraphCoordinates) : void {
			this._graphCoordinates = graphCoordinates;
		}
		
		public function get isWalking() : Boolean {
			return this.activeWalkingCheckpoint != null;
		}
		
		public function walkTo(p:Point) : void {
			var finder:PathFinder = new PathFinder();
			
			var startPoint = new Point(this.x, this.y);
			var endPoint = new Point(p.x, p.y);
			
			var path:Array = finder.FindPath(startPoint, endPoint, graph, graphCoordinates);
			
			path.pop(); // remove first element.
			
			this.currentWalkingCheckpoints = path;
			
			this.activeWalkingCheckpoint = this.currentWalkingCheckpoints.pop();
		}
		
		public function tic(sinceLastTic:int) : void {
			var remainingMovement:Number = walkingSpeed;
			
			while(activeWalkingCheckpoint != null && remainingMovement > 0){
				var distanceToPoint = this.getDistance(x, y, this.activeWalkingCheckpoint.x, this.activeWalkingCheckpoint.y);
				
				this.rotateToPoint(this.activeWalkingCheckpoint);
				
				if(distanceToPoint <= remainingMovement) {
					x = this.activeWalkingCheckpoint.x;
					y = this.activeWalkingCheckpoint.y;
					remainingMovement -= distanceToPoint;
					this.activeWalkingCheckpoint = this.currentWalkingCheckpoints.pop();
					continue;
				}
				
				var speedX = (this.activeWalkingCheckpoint.x - x) / distanceToPoint;
				var speedY = (this.activeWalkingCheckpoint.y - y) / distanceToPoint;
				
				x += speedX * remainingMovement;
				y += speedY * remainingMovement;
				remainingMovement = 0;
			}
			
			if(this.activeWalkingCheckpoint == null)
				this.nextWaypoint();
		}
		
		public function rotateToPoint(p:Point) : void {
			var disx:Number = p.x - x;
			var disy:Number = p.y - y;
			
			var rad:Number = Math.atan2(disy, disx) + (Math.PI / 2);
			var deg:Number = 360 * rad / (2 * Math.PI);
			this.rotation = deg;
		}
		
		public function getViewField() : ViewField {
			return this.viewField;
		}
		
		private function getDistance(p1x:Number, p1y:Number, p2x:Number, p2y:Number) : Number {
			return Math.sqrt(Math.pow((p1x - p2x), 2) + Math.pow((p1y - p2y), 2));
		}
		
		private function walkToCurrentWaypoint() : void {
			var waypoint:Waypoint = Waypoint(this.waypoints[this.currentWaypoint]);
			this.walkTo(new Point(waypoint.x, waypoint.y));
		}
		
		private function nextWaypoint() : void {
			if(this.waypoints == null)
				return;
				
			this.currentWaypoint = (this.currentWaypoint + 1) % this.waypoints.length;
			this.walkToCurrentWaypoint();
		}
	}
}
