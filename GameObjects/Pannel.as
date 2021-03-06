﻿package GameObjects {
	
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.geom.*;
	import Controls.*;
	import GameObjects.*;
	import Pathfinding.*;
	import System.*;
	
	public class Pannel extends Obstacle implements IObjective, IPlayerAware  {		
		
		private var player:Player;
		private var objectiveComplete:Boolean = false;
		private var hit:Boolean = false;
		private var avalableRectangle:Rectangle;
		
		public function Pannel() {
			addEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.REMOVED_FROM_STAGE, onDeInit);
			
			stop();
		}
		
		public function setPlayer(player:Player) : void {
			this.player = player;
		}
		
		public function isCompleted() : Boolean{
			return objectiveComplete;
		}
		
		private function onInit(e:Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onClick);
			avalableRectangle = new Rectangle(this.x  - 2, this.y - 2, this.width + 4, this.height + 4);
			
		}
		
		private function onDeInit(e:Event) {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onClick);
		}
		
		private function onClick(e:KeyboardEvent) : void {
			if(e.keyCode != Keyboard.SPACE)
				return;
			
			if(avalableRectangle.intersects(player.getBounds(root))) {
				objectiveComplete = true;
				gotoAndStop("completed");
			}
		}
	}
}