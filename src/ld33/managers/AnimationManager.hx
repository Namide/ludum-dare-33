package ld33.managers;
import h3d.Vector;
import hxd.Math;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class AnimationManager extends Manager
{

	public function new() 
	{
		super();
		
	}
	
	public override function update( dt:Float )
	{
		var v = new Vector();
		for ( actor in actors )
		{
			v.x = actor.vel.x;
			v.y = actor.vel.y;
			
			if ( !(v.x == 0 && v.y == 0) )
			{
				//v.normalize();
				
				//var r = Math.acos( v.x / (v.x * v.x + v.y * v.y) );
				var r = Math.atan2( v.y, v.x ) - Math.PI * 0.5;
				
				//trace( r * 180 / Math.PI );
				
				
				actor.setRotate( .0, .0, r );
			}
		}
	}
	
}