package ld33.actors;

import h3d.col.Point;
import h3d.scene.Object;
import h3d.Vector;
import hxd.Math;
import ld33.actors.Actor.ActorType;
import ld33.managers.WaveManager;
import motion.Actuate;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Enemy extends Actor
{
	public var t:Float = WaveManager.TIME_INIT;
	public var delay:Float = 5.;
	public var lastShoot:Float;
	
	public var id:Int;
	public var idMax:Int;
	
	public var updatePath:Enemy->Float->Void;
	public var shoot:Enemy->Void;
	
	public var velRot:Vector;
	
	public function new(path:Enemy->Float->Void) 
	{
		super();
		
		lastShoot = 0.5 - delay;
		type = ActorType.enemy;
		updatePath = path;
		
		Game.INST.wave.add( this );
	}
	
	/*public override function kill()
	{
		Game.INST.wave.remove(this);
		super.kill();
	}*/
	
	//function shoot() { }
	
	public override function update( dt:Float )
	{
		if (onDie) {
			
			mesh.rotate( velRot.x * dt, velRot.y * dt, velRot.z * dt );
			return;
		}
		
		t += dt;
		
		
		updatePath( this, t );
		
		
		if ( shoot != null && t > lastShoot + delay ) {
			
			lastShoot += delay;
			shoot(this);
		}
	}
	
	public override function onHurt( pt:Point )
	{
		var dir = pt.sub(getPos());
		vel.x = dir.x * 4.;
		vel.y = dir.y * 4.;
		vel.z = 0;
		vel.normalize();
		vel.scale3( 9 + Math.srand(3) );
		vel.z = 9 + Math.srand(3);
		
		onGround = false;
		onDie = true;
		
		velRot = new Vector( Math.srand(10), Math.srand(10), Math.srand(10) );
		
		Game.INST.physic.add( this );
	}
	
	public override function onGroundHit()
	{
		Game.INST.physic.remove( this );
		//this.kill();
		
		// hack
		Game.INST.wave.remove(this);
		super.kill();
	}
}