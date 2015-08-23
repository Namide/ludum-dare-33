package ld33.managers;
import ld33.actors.Actor.ActorType;
import ld33.actors.Player;

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
		var i = actors.length;
		while ( --i > -1 )
		{
			var actor = actors[i];
			var posZ = actor.mesh.z;
			if ( !actor.onGround ) {
				
				actor.vel.z += gravity;
				posZ += (actor.vel.z) * dt;
				
				if ( posZ < actor.size.z * .5 ) {
					
					actor.onGround = true;
					posZ = actor.size.z * .5;
					actor.onGroundHit();
					
					if ( actors.indexOf(actor) < 0 )
						continue;
				}
			}
			
			actor.setPos( actor.x + actor.vel.x * dt, actor.y + actor.vel.y * dt, 0 );
			actor.setZ( posZ );
			
			actor.lastVel.load( actor.vel );
			
			if ( actor.type == ActorType.player )
			{
				if ( actor.x < -Game.GROUND_HALF_SIZE )
					actor.x = -Game.GROUND_HALF_SIZE;
					
				else if ( actor.x > Game.GROUND_HALF_SIZE )
					actor.x = Game.GROUND_HALF_SIZE;
					
				if ( actor.y < -Game.GROUND_HALF_SIZE )
					actor.y = -Game.GROUND_HALF_SIZE;
					
				else if ( actor.y > Game.GROUND_HALF_SIZE )
					actor.y = Game.GROUND_HALF_SIZE;
				
			}
		}
	}
	
}