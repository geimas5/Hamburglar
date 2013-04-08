package Controls {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	import fl.motion.easing.*;
	
	public class ViewField extends MovieClip {
		
		private var _moved:Boolean = true;
		private var _lastPosition:Rectangle = null;
		
		// Initializing to avoid null test
		private var _obstacles:Array = new Array();
		private var _radius:Number = 100;
		private var _viewAngle:Number = Math.PI / 3 ;
		private var _curveAngle:Number = Math.PI / 180;
		private var _rotationOffset:Number = Math.PI / 2;		
		private var _numberOfSegments:int = 4;
		private var _segmentResolution:Number = Math.PI / 100;
		
		private var _detectionRadius = 100;
		private var _suspectRadius = 100;
		
		private var _timer = new Timer(75);
		
		private var _currentSegments = new Array();
		
		public function ViewField() {
			_timer.start();
			
			this.addEventListener(Event.ENTER_FRAME, onRedraw);
		}
		
		public function get obstacles() : Array {
			return this._obstacles;
		}
		
		public function set obstacles(newValue:Array) : void {
			this._obstacles = newValue;
		}
		
		public function get detectionRadius() : int {
			return this._detectionRadius;
		}
		
		public function set detectionRadius(newValue:int) : void {
			this._detectionRadius = newValue;
		}
		
		public function get suspectRadius() : int {
			return this._suspectRadius;
		}
		
		public function set suspectRadius(newValue:int) : void {
			this._suspectRadius = newValue;
		}
		
		private function onRedraw(e:Event){
			if(hasMoved())			
				drawViewField();
		}
		
		private function hasMoved(){
			var bounds:Rectangle = this.getBounds(root);
			if(this._lastPosition == null || !bounds.equals(this._lastPosition)) {
				this._lastPosition = bounds;
				return true;
			}
			
			return false;
		}
		
		private function drawViewField() {
			for each(var o:DisplayObject in _currentSegments){
				removeChild(o);
			}
			
			_currentSegments = new Array();
				
			var startAngle:Number = (_viewAngle / 2) * -1;
			var endAngle:Number = _viewAngle / 2;
			var segmentAngle:Number = _viewAngle / _numberOfSegments;
			
			for(var i:int = 0; i < _numberOfSegments; i++) {
				var segmentStart:Number = startAngle + (segmentAngle * i);
				var segmentEnd:Number = startAngle + (segmentAngle * (i + 1));
				var segment:Shape = createViewFieldTriangle(segmentStart, segmentEnd, _suspectRadius);
				addChild(segment);
				
				if(!isHit(segment)) {
					_currentSegments.push(segment);
					continue;
				}
				
				removeChild(segment);
				
				for(var j:Number = segmentStart; j < segmentEnd; j += _segmentResolution){
					var triangle:Shape = findClippedTriangle(j);
					addChild(triangle);
					_currentSegments.push(triangle);
				}
			}
		}
		
		private function findClippedTriangle(angle:Number) :Shape {
			var startPoint = new Point(0, 0);
			var endPoint = calculatePoint(angle, _radius);
			
		    var highestPoint:Number = this._radius;
			
			for each(var obstacle:MovieClip in this._obstacles) {				
				var rect:Rectangle = obstacle.getBounds(this);
				
				var xSpeed:Number = endPoint.x / _radius;
				var ySpeed:Number = endPoint.y / _radius;
				
				for(var i:Number = _radius; i > 0 ; i-= 1) {
					var testPoint:Point = this.localToGlobal(new Point(i * xSpeed, i * ySpeed));
					
					if(obstacle.hitTestPoint(testPoint.x, testPoint.y, true) && i < highestPoint)
						highestPoint = i - 1;
				}
			}
			
			return createViewFieldTriangle(angle, angle + _segmentResolution, highestPoint);
		}
		
		private function createViewFieldTriangle(startAngle:Number, endAngle:Number, radius:int):Shape {
			var triangle:Shape = new Shape();
			//triangle.graphics.beginFill(0x2147AB);
			
			var ratio:Number = Number(_detectionRadius) / Number(_suspectRadius);
			var detectionRatio = ratio * 255;
			var suspectRatio = 255 - detectionRatio;
			
			triangle.graphics.beginGradientFill(GradientType.RADIAL, [0xFF3700, 0xFFB300], [1, 1], [detectionRatio, suspectRatio]);
			
			triangle.graphics.moveTo(0, 0);
			
			triangle.graphics.lineTo(calculatePointX(startAngle, radius), calculatePointY(startAngle, radius));
			
			var currentAngle:Number = startAngle + _curveAngle;
			
			do {
				// TODO: Fix this loop
				triangle.graphics.lineTo(calculatePointX(currentAngle, radius), calculatePointY(currentAngle, radius));
				currentAngle += _curveAngle;
			}
			while(currentAngle < endAngle + _curveAngle)
			
			triangle.graphics.lineTo(calculatePointX(endAngle, radius), calculatePointY(endAngle, radius));
			
			triangle.graphics.lineTo(0, 0);
			
			return triangle;
		}
		
		private function calculatePoint(angle:Number, radius:Number):Point {
			return new Point(calculatePointX(angle, radius), calculatePointY(angle, radius));
		}
		
		private function calculatePointX(angle:Number, radius:Number) : Number {
			return Math.cos(angle + _rotationOffset) * radius;
		}
		
		private function calculatePointY(angle:Number, radius:Number) : Number{
			return (Math.sin(angle + _rotationOffset) * radius) * -1;
		}
		
		private function isHit(triangle:Shape) :Boolean {
			for each(var obstacle:MovieClip in this._obstacles) {
				
				if(isHitHelper(triangle, obstacle))
					return true;
			}
			
			return false;
		}
		
	
		// Based on http://www.freeactionscript.com/tag/pixel-perfect-hit-test-with-rotation/
		function isHitHelper(object1:DisplayObject, object2:DisplayObject, tolerance:int = 255):Boolean {			
			if (!object1.hitTestObject(object2))
				return false;
			
			var limits1:Rectangle = object1.getBounds(root);
			var limits2:Rectangle = object2.getBounds(root);
			var limits:Rectangle = limits1.intersection(limits2);
			
			limits.x = Math.floor(limits.x);
			limits.y = Math.floor(limits.y);
			
			limits.width = Math.ceil(limits.width);
			limits.height = Math.ceil(limits.height);
			
			if (limits.width < 1 || limits.height < 1) return false;
	
			var image:BitmapData = new BitmapData(limits.width, limits.height, false);
			
			var matrix:Matrix = object1.transform.concatenatedMatrix;
			matrix.translate(-limits.left, -limits.top);
			image.draw(object1, matrix, new ColorTransform(1, 1, 1, 1, 255, -255, -255, tolerance));
			matrix = object2.transform.concatenatedMatrix;
			matrix.translate(-limits.left, -limits.top);
			image.draw(object2, matrix, new ColorTransform(1, 1, 1, 1, 255, 255, 255, tolerance), BlendMode.DIFFERENCE);
	
			var intersection:Rectangle = image.getColorBoundsRect(0xFFFFFFFF, 0xFF00FFFF);
			if (intersection.width == 0) return false;
			
			return true;
		}	
	}
}