package ld33.managers;
import ld33.actors.Enemy;
import ld33.actors.Policeman;
import motion.Actuate;
import motion.MotionPath;



typedef Vec2 = { x:Float, y:Float };
typedef Datas = { /*time:Float,*/ fct:Array<Enemy->Float->Void>,/* dir:Array<Vec2>,*/ clas:Array<Class<Enemy>> };


/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class WaveManager extends Manager
{
	public static var TIME_INIT:Float = 0; // -1
	
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
		Game.INST.wave = this;	// hack
		
		var n = 20;
		var rotationFct1 = function ( a:Enemy, t:Float ) {
			
			t %= (4 * n);
			var i = a.id % a.idMax;
			var x:Float, y:Float, z:Float = getZ(t, a);
			
			var th = Math.PI * ( t * 0.5 + 2 * i / a.idMax );
			var x = Game.GROUND_HALF_SIZE * .5 + Game.GROUND_HALF_SIZE * .4 * Math.cos( th );
			var y = Game.GROUND_HALF_SIZE * .4 * Math.sin( th );
			
			a.setPos( x, y, z );
		}
		
		var rotationFct2 = function ( a:Enemy, t:Float ) {
			var x:Float, y:Float, z:Float = getZ(t, a);
			var i = a.id % a.idMax;
			
			var th = Math.PI * ( -t * 0.5 + 2 * i / a.idMax );
			var x = Game.GROUND_HALF_SIZE * .5 + Game.GROUND_HALF_SIZE * .2 * Math.cos( th );
			var y = Game.GROUND_HALF_SIZE * .2 * Math.sin( th );
			
			a.setPos( x, y, z );
		}
		
		levels = [
			{
				fct:[ for (i in 0...n) (i<n>>1) ? rotationFct1 : rotationFct2 ],
				clas:[ for (i in 0...n) Policeman ]
			}
		];
		
		level = levels[levelId];
		
		
		actors = [];
		var l = level.clas.length;
		for ( i in 0...l )
		{
			var Clas = level.clas[i];
			var actor:Enemy = Type.createInstance(Clas, [level.fct[i]] );
			actor.id = i;
			actor.idMax = l>>1;
			add( actor );
		}
		
		t = TIME_INIT;
		state = 0;
	}
	
	public override function update( dt:Float )
	{
		trace(actors.length);
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