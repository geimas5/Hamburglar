﻿package  {
	
	public class Configuration {
		
		public static const MAX_SCORE = 1000000;
		public static const LEVEL_COUNT = 10;

		public static const PLAYER_SPEED:Number = 30;// points. pr. seconds
		
		public static const LEVEL_TIC_INTERVAL:Number = 50; // Level tic intercal (ms)
		//Game tic interval (ms)
		public static const GAME_TIC_INTERVAL = 200;
		
		public static const CAMERA_DETECTION_RADIUS:Number = 100;
		public static const CAMERA_SUSPECT_RADIUS:Number = 100;
		public static const CAMERA_VIEW_ANGLE:Number = Math.PI / 4;
		
		
		public static const GUARD_DETECTION_RADIUS:Number = 70; // in points
		public static const GUARD_SUSPECT_RADIUS:Number = 100; // in points
		public static const GUARD_WALKING_SPEED:Number = 30; // in points pr. sec
		public static const GUARD_ROTATION_SPEED:Number = 1 / 3; // in degrees pr ms.
		public static const GUARD_REACTION_TIME:Number = 1000; // in ms
		
	}
}