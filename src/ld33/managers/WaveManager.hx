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
	
	public function new() 
	{
		super();
		//Game.INST.wave = this;	// hack
		
		//start( levelId )
	}
	
	
	public function start( levelId:Int )
	{
		var level = Levels.getLevel( levelId );
		
		actors = [];
		var l = level.length;
		for ( i in 0...l ) {
			level[i]( i, l );
		}
		
		id = levelId;
	}
	
	
	public override function update( dt:Float )
	{
		if ( actors.length < 1)
			start( id + 1 );
		/*t += dt;
		t %= level.time;
		
		var l = actors.length;
		for ( i in 0...l ) {
			var actor = actors[i];
			level.fct[i]( t % level.time, cast actor, i, l>>1 );
		}*/
	}
	
	/*static inline function lerp( a:Float, b:Float, v:Float )
	{
		return (b - a) * v + a;
	}*/
	
}