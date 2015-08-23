package ld33;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import hxd.Res;
import ld33.managers.SoundManager;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */

class Main 
{
	
	static var _INST:Main;
	
	var game:Game;
	//var screen:Start;
	
	var sounds:SoundManager;
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		_INST = new Main();
	}
	
	function new()
	{
		Res.initEmbed();
		sounds = SoundManager.getInst();
		//screenStart();
		
		
		game = new Game();
	}
	
	/*function screenStart( ?engine:h3d.Engine )
	{
		game = null;
		screen = new Start( engine );
		if ( engine != null )
			screen.init();
		screen.onFinish = screenStart;
	}*/
	
	/*function screenGame( ?engine:h3d.Engine )
	{
		screen = null;
		game = new Game( engine );
		if ( engine != null )
			game.init();
		game.onFinish = screenStart;
	}*/
	
}