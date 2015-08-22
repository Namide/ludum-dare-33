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
	
	public var inputVel = new Vector(.1, .1, .125);

	public function new(?parent:Object) 
	{
		super(parent);
		
		type = ActorType.Player;
		
		var cubes = [	new Vector( 0.23, 0.1, 0., 0.5 ),
						new Vector( 0.8, 0.6, 0.1, 0.4 ),
						new Vector( 0.23, 0.1, 0., 0.1 ) ];		
		
		addCubes( new Vector(0.84, 0.56, 1.7), cubes );
		
	}
	
}