package ld33.actors;
import h3d.Vector;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Tank extends Enemy
{

	public function new(path:Enemy->Float->Void) 
	{
		super(path);
		
		var cubes = [	new Vector( 0.012, 0.003, 0.003, 0.1 ),
						new Vector( 0.069, 0.315, 0.016, 0.4 ) ];		
		
		addCubes( new Vector(0.7, 0.5, 0.4), cubes );
	}
	
}