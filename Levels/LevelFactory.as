package Levels {
	
	public class LevelFactory {

		public static function createLevel(levelId:int) {
			var level:LevelBase = null;
			switch(levelId){
				case 1:
					return new Level1();
				case 4:
					return new Level4();
				case 5:
					return new Level5();
				default:
					trace("Unknown level", levelId);
					return null;
			}
		}
	}
}
