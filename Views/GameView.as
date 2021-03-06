﻿package Views {
	
	import flash.display.*;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;
	import Levels.*;
	import Sounds.*;
	import Dialogs.*;
	
	public class GameView extends ViewBase {
		
		private var levelId:int;
		
		private var currentLevel:LevelBase;
		private var pauseMenuDialog:PauseMenuDialog;
		private var gameOverDialog:GameOverDialog;
		private var isPaused:Boolean = false;
		private var _ticTimer:Timer = new Timer(Configuration.GAME_TIC_INTERVAL);
		private var _currentLevelId:int;
		
		public function GameView(level:int) {
			_currentLevelId = level;
			setLevel(level);
			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		override public function getBackgroundMusic() : Array {
			var playlist:Array = new Array();
			playlist.push(new LevelMusic());
			playlist.push(new LevelMusic1());
			playlist.push(new LevelMusic2());
			return playlist;
		}
		
		public function resume() : void {
			pauseMenuDialog.hide();
			isPaused = !isPaused;
			currentLevel.resume();
		}
		
		private function onInit(e:Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			gameOverDialog = new GameOverDialog(this, levelId, getViewManager());
			pauseMenuDialog = new PauseMenuDialog(this, getViewManager(), this);
			
			_ticTimer.addEventListener(TimerEvent.TIMER, onTic);
			_ticTimer.start();
		}
		
		private function onTic(e:Event) : void{
			var time:int = currentLevel.getLapseTime()/1000;
			var sec:int = time % 60;
			var min:int = (time - sec)/60;
			clock.text = twoDigit(min) + ":" + twoDigit(sec);
		}
		
		private function twoDigit(digits:int){
			var digit:String = String(digits);
			if(digit.length > 1) return digit;
			return "0" + digit;

		}
		
		private function setLevel(level:int) {
			this.levelId = level
			if(currentLevel != null)
				removeChild(currentLevel);
				
			currentLevel = LevelFactory.createLevel(level, gameOver, levelFinished);
			addChild(currentLevel);
			currentLevel.resume();
		}
		
		private function onKeyPress(e:KeyboardEvent){
			if(e.keyCode != Keyboard.P)
				return;
			
			if(!isPaused) {
				pauseMenuDialog.show();
				currentLevel.pause();
			}
			else {
				pauseMenuDialog.hide();
				currentLevel.resume();
			}
			isPaused = !isPaused;
		}
		
		private function gameOver() {
			gameOverDialog.show();
		}
		
		private function levelFinished(){
			getViewManager().showLevelFinished(currentLevel.getLapseTime(),_currentLevelId);
		}
	}
}
