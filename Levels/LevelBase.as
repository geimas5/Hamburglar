package Levels {
	import flash.display.*;
	import SurveillanceObjects.*;
	import Controls.*;
	import Pathfinding.*;
	import Obstacles.*;
	import flash.events.*;
	
	public class LevelBase extends MovieClip {
		private var obstacles:Array = new Array();
		
		private var guards:Array = new Array();
		private var waypoints:Array = new Array();
		
		private var _graphCoordinates:GraphCoordinates = new GraphCoordinates(15);
		private var _graph:IGraph = null;
		
		public function LevelBase() {
			this.addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event) {
			loadObjectArrays();
			
			initializeGuards();
		}
		
		private function loadObjectArrays() : void {
			for(var i:int = 0; i < numChildren; i++){
				var object:DisplayObject = getChildAt(i);
				
				if(object is Waypoint)
					addWaypoint(Waypoint(object));
				else if(object is Guard)
					addGuard(Guard(object));
				else if(object is Obstacle)
					obstacles.push(object);
			}
			
			buildGraph();
		}
		
		private function addGuard(guard:Guard) {
			this.guards[guard.id] = guard;
		}
		
		private function addWaypoint(waypoint:Waypoint) {
			if(!(waypoint.guardId in this.waypoints)) {
				this.waypoints[waypoint.guardId] = new Array();
			}
			
			this.waypoints[waypoint.guardId][waypoint.waypointId] = waypoint;
		}
		
		private function buildGraph() : void {
			var builder:GraphBuilder = new GraphBuilder(this.obstacles, root.getBounds(this.stage), this._graphCoordinates);
			this._graph = builder.buildGraph();
		}
		
		private function initializeGuards() {
			
			for(var i:String in this.guards) {
				var guard:Guard = Guard(this.guards[Number(i)]);
				
				guard.graph = this._graph;
				guard.graphCoordinates = this._graphCoordinates;
				
				guard.obstacles = this.obstacles;
				
				if(Number(i) in this.waypoints)
					guard.waypoints = this.waypoints[Number(i)];
			}
		}
	}
}