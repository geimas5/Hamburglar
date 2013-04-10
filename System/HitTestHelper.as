package System {
	import flash.display.*;
	import flash.geom.*;
	
	public class HitTestHelper {

		// Based on http://www.freeactionscript.com/tag/pixel-perfect-hit-test-with-rotation/
		public static function isHit(commonCoordinateSpace:DisplayObject, object1:DisplayObject, object2:DisplayObject, tolerance:int = 255) : Boolean {			
			if (!object1.hitTestObject(object2))
				return false;
			
			var limits1:Rectangle = object1.getBounds(commonCoordinateSpace);
			var limits2:Rectangle = object2.getBounds(commonCoordinateSpace);
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
