package System {
	
	public class MathHelper {

		public static function distance(x1, y1, x2, y2) : Number {
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
	}
}
