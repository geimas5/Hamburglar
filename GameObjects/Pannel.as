package GameObjects {
	
	import flash.display.*;
	import GameObjects.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import Controls.*;
	import Pathfinding.*;
	import Obstacles.*;
	import System.*;
	import flash.events.Event;
	
	public class Pannel extends Obstacle implements IObjective, IPlayerAware  {		
		
		private var player:Player;
		private var objectiveComplete:Boolean = false;
		private var hit:Boolean = false;
		
		public function Pannel() {
			addEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.REMOVED_FROM_STAGE, onDeInit);
		}
		
		public function onInit(e:Event) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onClick);
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
			if(MathHelper.distance(this.x, this.y, player.x, player.y) < 15) {
				objectiveComplete = true;
				trace("mø");
			}
		}
	}
}