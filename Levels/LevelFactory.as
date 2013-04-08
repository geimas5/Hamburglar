package Levels {
	
	public class LevelFactory {

		public static function createLevel(levelId:int) {
			var level:LevelBase = null;
			switch(levelId){
				case 1: return new Level1();
				case 2: return new Level2();
				case 3: return new Level3();
				case 4: return new Level4();
				case 5: return new Level5();
				case 6: return new Level6();
				case 7: return new Level7();
				case 8: return new Level8();
				case 9: return new Level9();
				case 10: return new Level10();
				default:
					trace("Unknown level", levelId);
					return null;
			}
		}
	}
}
