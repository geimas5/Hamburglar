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
			
			if(!HitTestHelper.isHit(player.root, player, viewField)) return null;
			
			var viewFieldBounds:Rectangle = viewField.getBounds(DisplayObject(object).root);
			var playerBounds:Rectangle = player.getBounds(DisplayObject(player).root);
			
			
			var distanceToPlayer:Number = distance(viewFieldBounds.x, viewFieldBounds.y, playerBounds.x, playerBounds.y);
			trace("detectionRadius: ", viewField.detectionRadius, "suspectRadius: ", viewField.suspectRadius, "distance: ", distanceToPlayer);
			
			if(distanceToPlayer < viewField.detectionRadius)
				return new DetectionResult(object, false);
			
			if(distanceToPlayer < viewField.suspectRadius)
				return new DetectionResult(object, true);
				
			return null;
		}
		
		private function distance(x1, y1, x2, y2){
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
	}
}
