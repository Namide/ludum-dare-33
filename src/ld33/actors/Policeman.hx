package ld33.actors;

import h3d.scene.Object;
import h3d.Vector;
import hxd.Math;
import ld33.actors.Actor.ActorType;
import ld33.actors.Bullet.BulletType;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Policeman extends Enemy
{
	//public var t:Float;
	
	public function new(path:Enemy->Float->Void) 
	{
		super(path);
		
		var cubes = [	new Vector( 0., 0., 0.8, 0.5 ),
						new Vector( 0.8, 0.33, 0.54, 0.4 ),
						new Vector( 0., 0., 0.8, 0.1 ) ];		
		
		addCubes( new Vector(0.13, 0.13, 0.24), cubes );
	}
	public override function kill()
	{
		super.remove();
	}
	
	override function shoot()
	{
		//var y = this.y;
		var h = size.z;
		var bullet1 = new Bullet( h, BulletType.orange, function( bullet:Bullet, dt:Float ) {
			
			//t += dt;
			bullet.x -= dt;
			Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
			//bullet.y = y + Math.sin( t );
			
		});
		bullet1.setPos( this.x, this.y, this.z );
		
		var middle = 1.414213;
		bullet1 = new Bullet( h, BulletType.orange, function( bullet:Bullet, dt:Float ){
			bullet.x -= dt * middle; 
			bullet.y -= dt * middle;
			Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
			
		});
		bullet1.setPos( this.x, this.y, this.z );
		
		bullet1 = new Bullet( h, BulletType.orange, function( bullet:Bullet, dt:Float ){
			bullet.x -= dt * middle; 
			bullet.y += dt * middle;
			Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
			
		});
		bullet1.setPos( this.x, this.y, this.z );
		
		
	}
	
}