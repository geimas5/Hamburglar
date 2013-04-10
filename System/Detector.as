package System {
	import GameObjects.ISecurityObject;
	import GameObjects.Player;
	import Controls.ViewField;
	import flash.display.*;
	import flash.geom.*;
	
	public class Detector {

		private var securityObjects:Array = new Array();
		private var player:Player;

		public function Detector(securityObjects:Array, player:Player) {
			this.securityObjects = securityObjects;
			this.player = player;
		}
		
		public function detect() : Array {
			var results:Array = new Array();
			
			for each(var object:ISecurityObject in this.securityObjects){
				var result:DetectionResult = doDetection(object);
				
				if(result != null)
					results.push(result);
			}
			
			return results;
		}
		
		private function doDetection(object:ISecurityObject) : DetectionResult {
			var viewField:ViewField = object.getViewField();
			
			if(!isHitHelper(player, viewField)) return null;
			
			var viewFieldBounds:Rectangle = viewField.getBounds(DisplayObject(object));
			
			if(distance(viewFieldBounds.x, viewFieldBounds.y, player.x, player.y) < viewField.detectionRadius)
				return new DetectionResult(object, false);
			
			if(distance(viewFieldBounds.x, viewFieldBounds.y, player.x, player.y) < viewField.suspectRadius)
				return new DetectionResult(object, false);
				
			return null;
		}
		
		private function distance(x1, y1, x2, y2){
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
		
		
		// Based on http://www.freeactionscript.com/tag/pixel-perfect-hit-test-with-rotation/
		private function isHitHelper(object1:DisplayObject, object2:DisplayObject, tolerance:int = 255) : Boolean {			
			if (!object1.hitTestObject(object2))
				return false;
			
			var limits1:Rectangle = object1.getBounds(object1.root);
			var limits2:Rectangle = object2.getBounds(object1.root);
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
