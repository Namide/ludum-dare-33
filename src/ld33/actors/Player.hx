package ld33.actors;

import h3d.scene.Object;
import h3d.Vector;
import hxd.Res;
import ld33.actors.Actor.ActorType;
import ld33.managers.SoundManager;
import motion.Actuate;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Player extends Actor
{
	
	public var inputVel = new Vector(10., 10., 17.);

	public function new() 
	{
		super();
		
		type = ActorType.player;
		
		var cubes = [	new Vector( 0.23, 0.1, 0., 0.5 ),
						new Vector( 0.8, 0.6, 0.1, 0.4 ),
						new Vector( 0.23, 0.1, 0., 0.1 ) ];		
		
		addCubes( new Vector(0.84, 0.56, 1.7), cubes );
		
		Game.INST.physic.add( this );
		Game.INST.anim.add( this );
	}
	
	public override function kill()
	{
		super.kill();
		Game.INST.physic.remove( this );
		Game.INST.anim.remove( this );
	}
	
	public override function update( dt:Float )
	{
		var bounds = mesh.getBounds();
		for ( actor in Actor.ACTORS )
		{
			if ( actor.type == ActorType.bullet )
			{
				var pos = actor.getPos();
				if ( bounds.include( pos ) )
				{
					actor.kill();
				}
			}
		}
		
		//trace( x, y, Game.GROUND_HALF_SIZE );
	}
	
	public override function onGroundHit() {
		
		var bounds = mesh.getBounds();
		for ( actor in Actor.ACTORS )
		{
			if ( actor.type == ActorType.enemy )
			{
				if ( bounds.collide(actor.mesh.getBounds() ) )
				{
					actor.onHurt( getPos() );
				}
			}
		}
		
		SoundManager.getInst().impact.play();
		
		Game.INST.s3d.camera.target.z = -.3;
		Actuate.tween( Game.INST.s3d.camera.target, 0.5, { z:0 } ).ease( motion.easing.Elastic.easeOut );
	}
}