package System {
	
	public class MathHelper {

		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number) : Number {
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
	}
}
