package ld33.actors;

import h3d.scene.Object;
import h3d.Vector;
import ld33.actors.Actor.ActorType;
import ld33.actors.Bullet.BulletType;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Policeman extends Enemy
{
	
	public function new() 
	{
		super();
		
		var cubes = [	new Vector( 0., 0., 0.8, 0.5 ),
						new Vector( 0.8, 0.33, 0.54, 0.4 ),
						new Vector( 0., 0., 0.8, 0.1 ) ];		
		
		addCubes( new Vector(0.13, 0.13, 0.24), cubes );
	}
	
	override function shoot()
	{
		//var y = this.y;
		var bullet1 = new Bullet( 0.1, BulletType.orange, function( bullet:Bullet, dt:Float ) {
			
			//t += dt;
			bullet.x -= dt; 
			//bullet.y = y + Math.sin( t );
			
		});
		bullet1.setPos( this.x, this.y, this.z );
		
		bullet1 = new Bullet( 0.1, BulletType.orange, function( bullet:Bullet, dt:Float ){
			bullet.x -= dt * .5; 
			bullet.y -= dt * .5; 
		});
		bullet1.setPos( this.x, this.y, this.z );
		
		bullet1 = new Bullet( 0.1, BulletType.orange, function( bullet:Bullet, dt:Float ){
			bullet.x -= dt * .5; 
			bullet.y += dt * .5; 
		});
		bullet1.setPos( this.x, this.y, this.z );
		
		
	}
	
}