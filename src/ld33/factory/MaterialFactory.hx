package ld33.factory;

import h3d.mat.MeshMaterial;
import h3d.Vector;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class MaterialFactory extends MeshMaterial
{
	static var _LIST:Map<Int, MaterialFactory>;
	
	public function new(color:Vector) 
	{
		super();
		//color.set(color.r, color.g, color.b);
		Game.initMaterial( this );
		this.color.set(color.r, color.g, color.b);
	}
	
	public static function getInst( color:Vector )
	{
		if ( _LIST == null )
			_LIST = new Map<Int, MaterialFactory>();
	
		color.w = 0;
		var hashColor = color.toColor();
		
		if ( !_LIST.exists(hashColor) )
		{
			_LIST.set( hashColor, new MaterialFactory(color) );
			
			#if debug
			
				var i = 0;
				for ( m in _LIST )
					i++;
				trace("MaterialFactory: ", i);
				
			#end
		}
			
		return _LIST.get(hashColor);
	}	
}