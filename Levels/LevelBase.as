package Levels {
	import flash.display.*;
	import GameObjects.*;
	import Controls.*;
	import Pathfinding.*;
	import Obstacles.*;
	import System.*;
	import flash.events.*;
	import flash.utils.*;
	import fl.controls.BaseButton;
	
	public class LevelBase extends MovieClip {
		private var obstacles:Array = new Array();
		
		private var timeAware:Array = new Array();
		private var guards:Array = new Array();
		private var waypoints:Array = new Array();
		private var securityObjects:Array = new Array();
		private var objectives:Array = new Array();
		private var cameras:Array = new Array();
		private var elevator:Elevator = null;
		
		private var _lapseTime:int = 0;
				
		private var _obstacleTester:ObstacleTester = null;
		private var _graphCoordinates:GraphCoordinates = new GraphCoordinates(15);
		private var _graph:IGraph = null;
				
		private var ticTimer:Timer = new Timer(Configuration.LEVEL_TIC_INTERVAL);
		private var _lastTic:int = 0;
		private var _player:Player;
		
		private var _gameOverCallback:Function = null;
		
		public function LevelBase(gameOverCallback:Function) {
			_gameOverCallback = gameOverCallback;
			this.addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function pause() : void {
			this.ticTimer.stop();
		}
		
		public function resume() : void {
			this._lastTic = getTimer();
			this.ticTimer.start();
		}
		
		private function isObjectivesCompleted() : Boolean {
			for each(var objective:IObjective in objectives) {
				if(!objective.isCompleted())
					return false;
			}
			
			elevator.setAvalable();
			return true;
		}
		
		public function getLapseTime() : int{
			return _lapseTime;
		}
		
		private function onInit(e:Event) : void {
			createPlayer();
			ticTimer.addEventListener(TimerEvent.TIMER, onTic);
			
			loadObjectArrays();
			
			initializeGuards();
			initializeCameras();
			initializePlayer();
		}
		
		protected function onTic(e:Event) :  void {
			var sinceLastTic:int = getTimer() - _lastTic;
			_lapseTime += sinceLastTic;
			_lastTic = getTimer();
			
			for each(var object in timeAware)
				ITimeAware(object).tic(sinceLastTic);
				
			isObjectivesCompleted();
				
			detectPlayer();
			finishedLevel();
		}
		
		private function createPlayer() : void {
			this._player = new Player();
			this.addChild(this._player);
			this._player.x = 30;
			this._player.y = 50;
		}
		
		private function loadObjectArrays() : void {
			for(var i:int = 0; i < numChildren; i++){
				var object:DisplayObject = getChildAt(i);
				
				if(object is ITimeAware)
					timeAware.push(object);
					
				if(object is ISecurityObject)
					securityObjects.push(object);
					
				if(object is IPlayerAware)
					IPlayerAware(object).setPlayer(this._player);
					
				if(object is IObjective)
					objectives.push(object);
					
				if(object is Waypoint)
					addWaypoint(Waypoint(object));
				else if(object is Guard)
					addGuard(Guard(object));
				else if(object is Obstacle)
					obstacles.push(object);
				else if (object is Elevator)
					elevator = Elevator(object);
				else if(object is Camera)
					cameras.push(object);
			}
			
			_obstacleTester = new ObstacleTester(this.obstacles, this);
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
			var builder:GraphBuilder = new GraphBuilder(this._obstacleTester, root.getBounds(this.stage), this._graphCoordinates);
			this._graph = builder.buildGraph();
		}
		
		private function initializeGuards() {
			
			for(var i:String in this.guards) {
				var guard:Guard = Guard(this.guards[Number(i)]);
				
				guard.graph = this._graph;
				guard.graphCoordinates = this._graphCoordinates;
				
				guard.obstacleTester = this._obstacleTester;
				
				if(Number(i) in this.waypoints)
					guard.waypoints = this.waypoints[Number(i)];
			}
		}
		
		private function initializeCameras(){
			for each(var camera:Camera in this.cameras) {
				 camera.obstacleTester = this._obstacleTester;
			}
		}
		
		private function initializePlayer() {
			 _player.obstacleTester = _obstacleTester;
		}
		
		private function detectPlayer() {
			for each(var object:ISecurityObject in this.securityObjects){
				if(object.isDeteced()) {
					SoundEffects.GameOver();
					this._gameOverCallback();
					pause();
					return true;
				}
			}
			
			return false;
		}
		
		private function finishedLevel() {
			if(elevator.isAvalable() && elevator.hitTestObject(_player)) {
				this._gameOverCallback();
				pause();
				return true;
			}
		}
	}
}
