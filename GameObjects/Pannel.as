package GameObjects {
	
	import flash.display.*;
	import GameObjects.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import Controls.*;
	import Pathfinding.*;
	import Obstacles.*;
	import System.*;
	import flash.events.*;
	import flash.geom.*;
	
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
		
		public function onInit(e:Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onClick);
			avalableRectangle = new Rectangle(this.x, this.y, this.width + 7, this.height + 7);
		}
		
		public function onDeInit(e:Event) {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onClick);
		}
		
		public function setPlayer(player:Player) : void {
			this.player = player;
		}
		
		
		public function isCompleted() : Boolean{
			return objectiveComplete;
		}
		
		public function onClick(e:KeyboardEvent) : void {
			if(e.keyCode != Keyboard.SPACE)
				return;
			
			if(avalableRectangle.intersects(new Rectangle(player.x, player.y, player.width, player.height))) {
				objectiveComplete = true;
				gotoAndStop("completed");
			}
		}
	}
}