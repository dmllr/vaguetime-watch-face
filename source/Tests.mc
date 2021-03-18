using Toybox.Test;

class Tests {
	
	(:test)
	function test_timeEngine(logger){
		var e = new TimeEngine();

		var repr = e.time();
		System.println(repr);
		
		return true;
	}

}
