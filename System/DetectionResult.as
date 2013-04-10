package System {
	
	import GameObjects.ISecurityObject;
	
	public class DetectionResult {

		private var _detectedBy:ISecurityObject;
		private var _isSuspicion:Boolean;
		
		public function DetectionResult(detectedBy:ISecurityObject, isSuspicion:Boolean) {
			this._detectedBy = detectedBy;
			this._isSuspicion = isSuspicion;
		}
		
		public function get detectedBy() : ISecurityObject {
			return this._detectedBy;
		}
		
		public function get isSuspicion() : Boolean {
			return this._isSuspicion;
		}
	}
}
