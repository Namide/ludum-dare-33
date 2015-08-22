package ld33.actors;

import h3d.scene.Object;
import h3d.Vector;
import ld33.actors.Actor.ActorType;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Policeman extends Actor
{

	public function new(?parent:Object) 
	{
		super(parent);
		
		type = ActorType.policeman;
		trace("init");
		var cubes = [	new Vector( 0., 0., 0.8, 0.5 ),
						new Vector( 0.8, 0.33, 0.54, 0.4 ),
						new Vector( 0., 0., 0.8, 0.1 ) ];		
		
		addCubes( new Vector(0.13, 0.13, 0.24), cubes );
	}
	
}