package ld33.managers;
import h3d.Quat;
import h3d.Vector;
import hxd.Math;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class AnimationManager extends Manager
{
	var t = 0.;
	
	public function new() 
	{
		super();
		
	}
	
	public override function update( dt:Float )
	{
		t += dt;
		
		var v = new Vector();
		for ( actor in actors )
		{
			v.x = actor.vel.x;
			v.y = actor.vel.y;
			
			if ( !(v.x == 0 && v.y == 0) )
			{
				var r = Math.atan2( v.y, v.x ) - Math.PI * 0.5;
				var quat = actor.getRotationQuat();
				var quat2 = new Quat();
				quat2.initRotate(.0, .0, r);
				
				quat.lerp(quat, quat2, 0.5 );
				actor.setRotationQuat( quat );
			}
		}
	}
	
}