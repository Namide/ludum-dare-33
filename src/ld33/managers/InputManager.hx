package ld33.managers;
import hxd.Key;
import hxd.Math;
import ld33.actors.Actor;
import ld33.actors.Bullet;
import ld33.actors.Enemy;
import ld33.actors.Player;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class InputManager extends Manager
{

	public function new() 
	{
		super();
	}
	
	public override function update( dt:Float )
	{
		for ( actor in actors )
		{
			switch( actor.type )
			{
				case ActorType.player :
					
					player( cast actor );
					
				case ActorType.bullet :
				
					bullet( cast actor, dt );
					
				case ActorType.enemy :
					
					enemy( cast actor, dt );
					
				case ActorType.none :
					
			}
		}
	}
	
	function bullet( bullet:Bullet, dt:Float )
	{
		bullet.update( bullet, dt );
	}
	
	function enemy( enemy:Enemy, dt:Float )
	{
		enemy.update( dt );
	}
	
	function player( player:Player)
	{
		player.vel.set( 0, 0, player.vel.z );
		
		if ( Key.isDown( Key.LEFT ) )
			player.vel.x = -player.inputVel.x;
			//player.x -= player.velocity * dt;
			
		if ( Key.isDown( Key.RIGHT ) )
			player.vel.x = player.inputVel.x;
			
		if ( Key.isDown( Key.DOWN ) )
			player.vel.y = player.inputVel.y;
			
		if ( Key.isDown( Key.UP ) )
			player.vel.y = -player.inputVel.y;
			
		if ( player.onGround && Key.isDown( Key.SPACE ) )
		{
			player.onGround = false;			
			player.vel.z = player.inputVel.z;
		}
		
		var max = Math.abs(player.vel.x) + Math.abs(player.vel.y);
		if ( max > player.inputVel.x )
		{
			var sc = 1 / max;
			player.vel.x * sc;
			player.vel.y * sc;
		}
		
	}
	
}