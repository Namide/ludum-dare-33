package ld33.managers;
import ld33.actors.Actor;
import ld33.actors.Bullet;
import ld33.actors.Enemy;
import ld33.actors.Policeman;
import ld33.level.Levels;
import motion.Actuate;
import motion.MotionPath;



typedef Vec2 = { x:Float, y:Float };
//typedef Datas = { /*time:Float,*/ path:Array<Enemy->Float->Void>,/* dir:Array<Vec2>,*/ init:Array<Int->Int->Void>, shoot:Array<Enemy->Void> };
typedef Datas = Array<Int->Int->Void>;


/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class WaveManager extends Manager
{
	public static var TIME_INIT:Float = -1; // -1
	
	//var levels:Array<Datas>;
	
	//var level:Datas;
	//var t:Float;
	var id:Int;
	public var play:Bool = false;
	
	public function new() 
	{
		super();
		//Game.INST.wave = this;	// hack
		
		//start( levelId )
	}
	
	
	public function start( levelId:Int )
	{
		var level = Levels.getLevel( levelId );
		
		if ( level != null )
		{
			actors = [];
			var l = level.length;
			for ( i in 0...l ) {
				level[i]( i, l );
			}
			
			id = levelId;
		}
		
		play = true;
	}
	
	
	public override function update( dt:Float )
	{
		if (!play)
			return;
		
		if ( actors.length < 1)	{
			start( id + 1 );
		}
	}
	
}