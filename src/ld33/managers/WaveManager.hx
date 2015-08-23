package ld33.managers;
import ld33.actors.Enemy;
import ld33.actors.Policeman;
import motion.Actuate;
import motion.MotionPath;



typedef Vec2 = { x:Float, y:Float };
typedef Datas = { time:Float, fct:Array<Float->Enemy->?Int->?Int->Void>,/* dir:Array<Vec2>,*/ clas:Array<Class<Enemy>> };


/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class WaveManager extends Manager
{
	public static var TIME_INIT:Float = -1;
	
	var levels:Array<Datas>;
	
	var level:Datas;
	var t:Float;
	var state:Int;
	
	inline static function getZ( t:Float, a:Enemy )
	{
		var z:Float;
		if ( t < 0 ) {
			z = 1 + (t - TIME_INIT) / TIME_INIT;
			z = 5 * z + a.size.z * .5;
		}
		else {
			z = a.size.z * .5;
		}
		return z;
	}
	
	public function new( game:Game, levelId:Int ) 
	{
		super();
		
		var rotationFct1 = function ( t:Float, a:Enemy, ?i:Int = 0, ?l:Int = 0 ) {
			var x:Float, y:Float, z:Float = getZ(t, a);
			i %= l;
			
			var th = Math.PI * ( t * 0.5 + 2 * i / l );
			var x = Game.GROUND_HALF_SIZE * .5 + Game.GROUND_HALF_SIZE * .4 * Math.cos( th );
			var y = Game.GROUND_HALF_SIZE * .4 * Math.sin( th );
			
			a.setPos( x, y, z );
		}
		
		var rotationFct2 = function ( t:Float, a:Enemy, ?i:Int = 0, ?l:Int = 0 ) {
			var x:Float, y:Float, z:Float = getZ(t, a);
			i %= l;
			
			var th = Math.PI * ( -t * 0.5 + 2 * i / l );
			var x = Game.GROUND_HALF_SIZE * .5 + Game.GROUND_HALF_SIZE * .2 * Math.cos( th );
			var y = Game.GROUND_HALF_SIZE * .2 * Math.sin( th );
			
			a.setPos( x, y, z );
		}
		
		var n = 20;
		levels = [
			{
				time:4 * n,
				fct:[ for (i in 0...n) (i<n>>1) ? rotationFct1 : rotationFct2 ],
				clas:[ for (i in 0...n) Policeman ]
			}
		];
		
		level = levels[levelId];
		
		
		actors = [];
		for ( i in 0...level.clas.length )
		{
			var Clas = level.clas[i];
			var actor:Enemy = Type.createInstance(Clas, [] );
			add( actor );
		}
		
		t = TIME_INIT;
		state = 0;
	}
	
	public override function update( dt:Float )
	{
		t += dt;
		t %= level.time;
		
		var l = actors.length;
		for ( i in 0...l ) {
			var actor = actors[i];
			level.fct[i]( t % level.time, cast actor, i, l>>1 );
		}
		//trace(l);
		
		/*if ( t < 0 )
		{
			var ti = 1 - t;
			for ( i in 0...actors.length )
			{
				var actor = actors[i];
				actor.z = lerp(actor.size.z * 0.5 - 2, actor.size.z * 0.5, ti);
			}
			
			return;
		}
		
		
		var state2 = (state + 1) % level.times.length;
		if ( level.times[state2] > t )
		{
			state++;
			if ( state >= level.times.length )
			{
				t = 0;
				state = 0;
			}
			state2 = (state + 1) % level.times.length;
		}
		
		
		
		var t1 = level.times[state]; 
		var t2 = level.times[state2]; 
		var ti = (t - t1) / (t2 - t1);
		trace(state, ti, t1, t2, level.times.length );
		
		for ( i in 0...actors.length )
		{
			var actor = actors[i];
			var p1 = level.pos[state][i];
			var p2 = level.pos[state2][i];
		
			actor.x = lerp(p1.x, p2.x, ti);
			actor.y = lerp(p1.y, p2.y, ti);
		}*/
	}
	
	/*static inline function lerp( a:Float, b:Float, v:Float )
	{
		return (b - a) * v + a;
	}*/
	
}