package System {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	import fl.motion.easing.*;
	import Levels.*;
	
	public class ObstacleTester {
		
		private var obstacles:Array = new Array();
		private var level:LevelBase = null;
		private var bounds:Rectangle = null;
		private var cachedBitmap:BitmapData = null;

		public function ObstacleTester(obstacle:Array, level:LevelBase) {
			obstacles = obstacle;
			this.level = level;
			this.bounds = level.getBounds(level);
			this.generateBitmapData();
		}
		
		public function hitTestPoint(point:Point) : Boolean {
			return hitTestCoord(point.x, point.y);
		}
		
		public function hitTestCoord(x:Number, y:Number) : Boolean {
			if(cachedBitmap.getPixel(x, y) < 0xFFFFFF)
				return true;
			
			return false;
		}
		
		public function hitTest(object:DisplayObject) : Boolean {
			if(!bounds.containsRect(object.getBounds(this.level)))
				return true;
			
			for each(var obj:DisplayObject in this.obstacles) {
				if(HitTestHelper.isHit(level, obj, object))
					return true;
			}
			
			return false;
		}
		
		private function generateBitmapData() : void {			
			var image:BitmapData = new BitmapData(level.width, level.height, true);
			
			for each(var obstacle:DisplayObject in this.obstacles) {
				image.draw(obstacle);
			}
			
			this.cachedBitmap = image;
		}
	}
}
