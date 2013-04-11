package GameObjects {
	
	import fl.core.UIComponent;
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import flash.events.*;
	import Controls.*;
	import Pathfinding.*;
	import System.*;
	
	public class Guard extends UIComponent implements ITimeAware, ISecurityObject, IPlayerAware {
		private static var NORMAL_STATE:String = "NORMAL_STATE";
		private static var SUSPICTION_STATE:String = "SUSPICTION_STATE";
		
		private var _currentState:String = Guard.NORMAL_STATE;
		
		private var _obstacleTester:ObstacleTester = null;
		private var _waypoints:Array;
		private var currentWaypoint:Number = -1;
		
		private var _player:Player = null;
		
		private var _id:Number = 0;
		
		private var currentWalkingCheckpoints:Array = new Array();
		private var activeWalkingCheckpoint:Point = null;
		
		private var _graphCoordinates:GraphCoordinates = null;
		private var _graph:IGraph = null;
		
		private var _reactionTimeLeft:int =0;
		
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
		
		public function get obstacleTester() : ObstacleTester {
			return this._obstacleTester;
		}
		
		public function set obstacleTester(tester:ObstacleTester) : void {
			this._obstacleTester = tester;
			this.viewField.obstacleTester = tester;
		}
		
		public function get waypoints() : Array {
			return this._waypoints;
		}
		
		public function set waypoints(arr:Array) : void {
			this._waypoints = arr;
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
			walk(sinceLastTic);
			
			if(this._currentState == Guard.SUSPICTION_STATE) {
				if (this.activeWalkingCheckpoint == null) {
					this.walkToCurrentWaypoint();
					this._currentState = Guard.NORMAL_STATE;
				}
			}
			else if(this._currentState == Guard.NORMAL_STATE) {
				if(isSuspected()) {
					this._currentState = Guard.SUSPICTION_STATE;
					this._reactionTimeLeft = Configuration.GUARD_REACTION_TIME;
					this.walkTo(new Point(this._player.x, this._player.y));
					this.rotateToPoint(new Point(this._player.x, this._player.y));
					SoundEffects.GuardSuspect();
				}
				else if(this.activeWalkingCheckpoint == null)
					this.nextWaypoint();
			}
			
			this.viewField.tic();
		}
		
		public function rotateToPoint(p:Point) : void {
			var disx:Number = p.x - x;
			var disy:Number = p.y - y;
			
			var rad:Number = Math.atan2(disy, disx) + (Math.PI / 2);
			var deg:Number = 360 * rad / (2 * Math.PI);
			this.rotation = deg;
		}
		
		public function isDeteced() : Boolean {
			var result:DetectionResult = viewField.detectPlayer(this._player);
			
			if(result == null) return false;
			
			return !result.isSuspicion;
		}
		
		public function isSuspected() : Boolean {
			var result:DetectionResult = viewField.detectPlayer(this._player);
			
			if(result == null) return false;
			
			return result.isSuspicion;
		}
		
		public function setPlayer(player:Player) : void {
			this._player = player;
		}
		
		private function walk(sinceLastTic:int) : void {
			if(this._reactionTimeLeft > 0) {
				this._reactionTimeLeft -= sinceLastTic;
				return;
			}
			
			var remainingMovement:Number = (Configuration.GUARD_WALKING_SPEED / 1000) * sinceLastTic;
			
			while(activeWalkingCheckpoint != null && remainingMovement > 0) {
				var distanceToPoint = MathHelper.distance(x, y, this.activeWalkingCheckpoint.x, this.activeWalkingCheckpoint.y);
				
				rotate(sinceLastTic);
				
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
		}
		
		private function rotate(sinceLastTic:int) {
			var disx:Number = this.activeWalkingCheckpoint.x - x;
			var disy:Number = this.activeWalkingCheckpoint.y - y;
			
			var rad:Number = Math.atan2(disy, disx) + (Math.PI / 2);
			var deg:Number = 360 * rad / (2 * Math.PI);
			
			var angle = deg - rotation;
			
			if (angle > 180) angle -= 360;
			if (angle < -180) angle += 360;
			
			var toRotate = Math.min(Math.abs(angle), Configuration.GUARD_ROTATION_SPEED * sinceLastTic);
			
			if(Math.abs(angle) < Configuration.GUARD_ROTATION_SPEED * sinceLastTic) {
				rotation = deg; 
				return;
			}
			
			if (angle > 0) {
				rotation += toRotate;
			}
			else {
				rotation -= toRotate;
			}
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
