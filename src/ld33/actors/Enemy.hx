package ld33.actors;

import h3d.scene.Object;
import ld33.actors.Actor.ActorType;
import ld33.managers.WaveManager;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Enemy extends Actor
{
	public var t:Float = WaveManager.TIME_INIT;
	public var delay:Float = 5.;
	public var lastShoot:Float;
	
	public var id:Int;
	public var idMax:Int;
	
	public var updatePath:Enemy->Float->Void;
	
	public function new(path:Enemy->Float->Void) 
	{
		super();
		
		lastShoot = 0.5 - delay;
		type = ActorType.enemy;
		updatePath = path;
		
		Game.INST.wave.add( this );
	}
	
	public override function kill()
	{
		super.kill();
		
		Game.INST.wave.remove( this );
	}
	
	public override function update( dt:Float )
	{
		t += dt;
		updatePath( this, t );
		
		if ( t > lastShoot + delay ) {
			
			lastShoot += delay;
			shoot();
		}
	}
	
	function shoot()
	{
		
	}
	
}