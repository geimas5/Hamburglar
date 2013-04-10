package Levels {
	
	public class LevelFactory {

		public static function createLevel(levelId:int, gameOverCallback:Function) : LevelBase {
			var level:LevelBase = null;
			switch(levelId){
				case 1: return new Level1(gameOverCallback);
				case 2: return new Level2(gameOverCallback);
				case 3: return new Level3(gameOverCallback);
				case 4: return new Level4(gameOverCallback);
				case 5: return new Level5(gameOverCallback);
				case 6: return new Level6(gameOverCallback);
				case 7: return new Level7(gameOverCallback);
				case 8: return new Level8(gameOverCallback);
				case 9: return new Level9(gameOverCallback);
				case 10: return new Level10(gameOverCallback);
				default:
					trace("Unknown level", levelId);
					return null;
			}
		}
	}
}
