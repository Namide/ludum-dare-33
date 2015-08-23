package ld33.actors;

import h3d.scene.Object;
import h3d.Vector;
import ld33.actors.Actor.ActorType;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Player extends Actor
{
	
	public var inputVel = new Vector(10., 10., 17.);

	public function new() 
	{
		super();
		
		type = ActorType.player;
		
		var cubes = [	new Vector( 0.23, 0.1, 0., 0.5 ),
						new Vector( 0.8, 0.6, 0.1, 0.4 ),
						new Vector( 0.23, 0.1, 0., 0.1 ) ];		
		
		addCubes( new Vector(0.84, 0.56, 1.7), cubes );
		
		Game.INST.physic.add( this );
		Game.INST.anim.add( this );
	}
	
	public override function kill()
	{
		super.kill();
		Game.INST.physic.remove( this );
		Game.INST.anim.remove( this );
	}
}