package ld33.managers;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class PhysicManager extends Manager
{

	public var gravity = -1.;
	
	public function new() 
	{
		super();
		
	}
	
	public override function update( dt:Float )
	{
		for ( actor in actors )
		{
			var posZ = actor.mesh.z;
			if ( !actor.onGround ) {
				
				actor.vel.z += gravity;
				posZ += (actor.vel.z) * dt;
				
				if ( posZ < actor.size.z * .5 ) {
					actor.onGround = true;
					posZ = actor.size.z * .5;
				}
			}
			
			actor.setPos( actor.x + actor.vel.x * dt, actor.y + actor.vel.y * dt, 0 );
			actor.mesh.z = posZ;
			actor.lastVel.load( actor.vel );
		}
	}
	
}