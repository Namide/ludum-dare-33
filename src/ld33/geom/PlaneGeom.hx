package ld33.geom;

import h3d.col.Point;
import h3d.prim.Polygon;
import h3d.prim.UV;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class PlaneGeom extends Polygon
{

	public function new( x = 1., y = 1. )
	{
		var p = [
			/*new Point(0, 0, 0),
			new Point(x, 0, 0),
			new Point(0, y, 0),
			new Point(0, 0, z),
			new Point(x, y, 0),
			new Point(x, 0, z),
			new Point(0, y, z),
			new Point(x, y, z),*/
			
			/*new Point(-x*.5, -y*.5, 0),
			new Point(x*.5, -y*.5, 0),
			new Point(x*.5, y*.5, 0),
			new Point(-x*.5, y*.5, 0)*/
			
			/*new Point(-x*.5, 0, -y*.5),
			new Point(x*.5, 0, -y*.5),
			new Point(x*.5, 0, y*.5),
			new Point(-x*.5, 0, y*.5)*/
			
			new Point(-x*.5, 0, -y*.5),
			new Point(x*.5, 0, -y*.5),
			new Point(x*.5, 0, y*.5),
			new Point(-x*.5, 0, y*.5)
			
		];
		var idx = new hxd.IndexBuffer();
		
		idx.push(0); idx.push(2); idx.push(1);
		idx.push(2); idx.push(0); idx.push(3);
		
		/*idx.push(0); idx.push(1); idx.push(5);
		idx.push(0); idx.push(5); idx.push(3);
		idx.push(1); idx.push(4); idx.push(7);
		idx.push(1); idx.push(7); idx.push(5);
		idx.push(3); idx.push(5); idx.push(7);
		idx.push(3); idx.push(7); idx.push(6);
		idx.push(0); idx.push(6); idx.push(2);
		idx.push(0); idx.push(3); idx.push(6);
		idx.push(2); idx.push(7); idx.push(4);
		idx.push(2); idx.push(6); idx.push(7);
		idx.push(0); idx.push(4); idx.push(1);
		idx.push(0); idx.push(2); idx.push(4);*/
		super(p, idx);
	}

	override function addUVs() {
		unindex();

		var z = new UV(0, 1);
		var x = new UV(1, 1);
		var y = new UV(0, 0);
		var o = new UV(1, 0);

		uvs = [
			y, x, o,
			x, y, z
			/*z, x, o,
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
			z, y, o,*/
		];
	}
	
}