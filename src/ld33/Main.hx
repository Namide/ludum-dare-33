package ld33;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import hxd.Res;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */

class Main 
{
	
	static var _INST:Main;
	
	var game:Game;
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		Res.initEmbed();
		_INST = new Main();
	}
	
	function new()
	{
		game = new Game();
	}
	
}