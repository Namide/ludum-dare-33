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
	public var delay:Float = 1.5;
	public var lastShoot:Float;
	
	public function new() 
	{
		super();
		lastShoot = -delay;
		type = ActorType.enemy;
	}
	
	public function update( dt:Float )
	{
		t += dt;
		if ( t > lastShoot + delay ) {
			
			lastShoot += delay;
			shoot();
		}
	}
	
	function shoot()
	{
		
	}
	
}