package GameObjects {

	import fl.core.UIComponent;
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import flash.events.*;
	import Controls.*;
	import System.*;
	
	public class Camera extends UIComponent implements ITimeAware, ISecurityObject, IPlayerAware {

		private var _obstacleTester:ObstacleTester;
		private var _player:Player = null;
		
		private var _cameraRotation:int;
		private var _currentDegree:int = 0;
		private var _rotationSpeed:int;
		private var _rotationDegrees:int;
		private var _rotationDirection:int = 1;
		
		public function Camera(){
			addEventListener(Event.ADDED_TO_STAGE,onInit);
			viewField.detectionRadius = Configuration.CAMERA_DETECTION_RADIUS;
			viewField.suspectRadius = Configuration.CAMERA_SUSPECT_RADIUS;
			viewField.viewAngle = Configuration.CAMERA_VIEW_ANGLE;
		}
		
		private function onInit(e:Event) : void{
			_cameraRotation = this.rotation;
		}
		
		
		public function set obstacleTester(obstacleTester:ObstacleTester) : void {
			this._obstacleTester = obstacleTester;
			this.viewField.obstacleTester = obstacleTester;
		}
		
		public function get obstacleTester() : ObstacleTester {
			return this._obstacleTester;
		}
		
		
		[Inspectable(defaultValue=0)]
		public function set rotationDegrees(rotationDegrees:int) : void{
			this._rotationDegrees = rotationDegrees;
		}
		
		public function get rotationDegrees() : int{
			return _rotationDegrees;
		}
		
		[Inspectable(defaultValue=1)]
		public function set rotationSpeed(rotationSpeed:int) : void{
			this._rotationSpeed = rotationSpeed;
		}
		
		public function get rotationSpeed() : int{
			return _rotationSpeed;
		}
		
		public function setPlayer(player:Player) : void{
			this._player = player;
		}
		
		public function isDeteced() : Boolean{
			var result:DetectionResult = viewField.detectPlayer(this._player);
			
			if(result == null) return false;
			
			return true;
		}
		
		public function rotate(){
			if(_currentDegree < -_rotationDegrees || _currentDegree > _rotationDegrees)
				_rotationDirection = -1 * _rotationDirection;
				
			if(_rotationDirection > 0)
				_currentDegree += _rotationSpeed;
				
			else if(_rotationDirection < 0)
				_currentDegree -= _rotationSpeed;
				
			this.rotation = _cameraRotation + _currentDegree;
		}
		
		public function tic(sinceLastTic:int) : void{
			if(_rotationDegrees != 0){
				rotate();
			}
			viewField.tic();
		}
	}
}
