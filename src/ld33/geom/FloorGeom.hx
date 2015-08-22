package ld33.geom;

import h3d.prim.Cube;
import h3d.prim.UV;
import h3d.col.Point;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class FloorGeom extends Cube
{

	public function new(x=1., y=1., z=1.) 
	{
		super(x, y, z);
	}
	
	public function addRepUVs( rep:Float ) {
		unindex();

		var z = new UV(0, rep);
		var x = new UV(rep, rep);
		var y = new UV(0, 0);
		var o = new UV(rep, 0);

		uvs = [
			z, x, o,
			z, o, y,
			x, z, y,
			x, y, o,
			x, z, y,
			x, y, o,
			z, o, x,
			z, y, o,
			x, y, z,
			x, o, y,
			z, o, x,
			z, y, o,
		];
	}
	
}