package  {
	
	import flash.display.MovieClip;
	

	
	public class Guy extends MovieClip {
		

		
		public function Guy() {
			// constructor code
			stop();
		}
		
		public function StartWalkingLeft(){
			this.rotate = 45;
			start();
		}
		
		public function StopWalking(){
			
		}	
	}
	
}
