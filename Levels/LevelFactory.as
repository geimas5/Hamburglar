package Levels {
	
	public class LevelFactory {

		public static function createLevel(levelId:int, gameOverCallback:Function,gameFinnishedCallback:Function) : LevelBase {
			var level:LevelBase = null;
			switch(levelId){
				case 1: return new Level1(gameOverCallback,gameFinnishedCallback);
				case 2: return new Level2(gameOverCallback,gameFinnishedCallback);
				case 3: return new Level3(gameOverCallback,gameFinnishedCallback);
				case 4: return new Level4(gameOverCallback,gameFinnishedCallback);
				case 5: return new Level5(gameOverCallback,gameFinnishedCallback);
				case 6: return new Level6(gameOverCallback,gameFinnishedCallback);
				case 7: return new Level7(gameOverCallback,gameFinnishedCallback);
				case 8: return new Level8(gameOverCallback,gameFinnishedCallback);
				case 9: return new Level9(gameOverCallback,gameFinnishedCallback);
				case 10: return new Level10(gameOverCallback,gameFinnishedCallback);
				default:
					trace("Unknown level", levelId);
					return null;
			}
		}
	}
}
