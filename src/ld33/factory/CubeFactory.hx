package ld33.factory;

import h3d.prim.Cube;
import h3d.Vector;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class CubeFactory extends Cube
{
	static var _LIST:Map<String, CubeFactory>;
	
	public function new(x=1., y=1., z=1.) 
	{
		super(x, y, z);
		
	}
	
	public static function getInst( size:Vector )
	{
		if ( _LIST == null )
			_LIST = new Map<String, CubeFactory>();
		
		var hashSize = hxd.Math.ceil(size.x * 1000)+ "," + hxd.Math.ceil(size.y * 1000) + "," + hxd.Math.ceil(size.z * 1000);
		
		if ( !_LIST.exists(hashSize) )
		{
			var box = new CubeFactory(size.x, size.y, size.z);
			box.unindex();
			box.addNormals();
			
			_LIST.set( hashSize, box /*new CubeFactory(color)*/ );
			
			#if debug
			
				var i = 0;
				for ( m in _LIST )
					i++;
				trace("CubeFactory: ", i);
				
			#end
		}
		
		return _LIST.get(hashSize);
	}
	
}