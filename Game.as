package  {
	
	import flash.events.*
	
	public class Game {

		public function Game() {
			// constructor code
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event){
			addEventListener(KeyboardEvent.LEFT_KEY_DOWN);
		}

	}
	
}
