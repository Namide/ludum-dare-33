package ld33.level;
import ld33.actors.Bullet;
import ld33.actors.Enemy;
import ld33.actors.Policeman;
import ld33.actors.Tank;
import ld33.managers.WaveManager;
import ld33.managers.WaveManager.Datas;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Levels
{

	inline static function getZ( t:Float, a:Enemy )
	{
		var z:Float;
		if ( t < 0 ) {
			z = 1 + (t - WaveManager.TIME_INIT) / WaveManager.TIME_INIT;
			z = 5 * z + a.size.z * .5;
		}
		else {
			z = a.size.z * .5;
		}
		return z;
	}
	
	
	public static function getLevel(num:Int):Datas
	{
		switch( num )
		{
			case 0 :
				return getLevel0();
				
			case 1 :
				return getLevel1();	// 4 persos + circles
				
			case 2 :
				return getLevel2();
				
			case 3 :
				return getLevel3();
				
			case 4 :
				return getLevel4();
		}
		
		Game.INST.dispose();
		
		return null;
	}
	
	static function getLevel0():Datas
	{
		var n = 15;
		var path = function ( a:Enemy, t:Float ) {
			
			a.setZ( getZ(t, a) );
			
			if ( t < 0 )
				t = 0;
			
			var y:Float = Math.floor(a.id / 3) / 4 - .5;
			var x:Float = (a.id % 3) * .5 - .5;
			
			x = x * Game.GROUND_HALF_SIZE * 0.2	+ 0.7 * Game.GROUND_HALF_SIZE * Math.cos( t * 0.3 );
			y = y * Game.GROUND_HALF_SIZE * 1.0 + 0.35 * Game.GROUND_HALF_SIZE * Math.sin( t );
			
			a.setPos( x, y, 0 );
			
		}
		
		var shoot = function (a:Enemy) { }
		
		return /*{
				//path:[ for (i in 0...n) path ],
				init:*/[ for (i in 0...n) function( id:Int, idMax:Int ) {
					
					var a = new Policeman(path);
					//Type.createInstance(Clas, [level.path[i]] );
					a.shoot = null;
					a.id = id;
					a.idMax = idMax;
					
				} ]/*,
				//shoot:[ for (i in 0...n) null ]
			}*/;
	}
	
	static function getLevel1():Datas
	{
		var n = 4;
		var path = function ( a:Enemy, t:Float ) {
			
			a.setZ( getZ(t, a) );
			
			if ( t < 0 )
				t = 0;
			
			var y:Float = (a.id < 2) ? .5 : -.5;
			var x:Float = (a.id % 2 == 0) ? .5 : -.5;
			
			x *= Game.GROUND_HALF_SIZE;
			y *= Game.GROUND_HALF_SIZE;
			
			a.setPos( x, y, 0 );
		}
		
		var shoot = function ( a:Enemy ) {
			
			var max = 32;
			for ( i in 0...max )
			{
				var th = Math.PI * 2 * i / max;
				
				var bullet = new Bullet( a.size.z, BulletType.orange, function( bullet:Bullet, dt:Float ) {
				
					bullet.x += 0.02 * Math.cos(th);
					bullet.y += 0.02 * Math.sin(th);
					
					Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
					bullet.onOutKill();
				});
				bullet.setPos( a.x, a.y, a.z );
			}
		}
		
		
		return[ for (i in 0...n) function( id:Int, idMax:Int ) {
					
					var a = new Policeman(path);
					//Type.createInstance(Clas, [level.path[i]] );
					a.shoot = shoot;
					a.id = id;
					a.idMax = idMax;
					a.delay = 5.;
					a.lastShoot = - a.delay;
					
				} ];
	}
	
	static function getLevel2():Datas
	{
		var n = 4;
		var path = function ( a:Enemy, t:Float ) {
			
			a.setZ( getZ(t, a) );
			
			if ( t < 0 )
				t = 0;
			
			var y:Float = (a.id < 2) ? .5 : -.5;
			var x:Float = (a.id % 2 == 0) ? .5 : -.5;
			
			x *= Game.GROUND_HALF_SIZE;
			y *= Game.GROUND_HALF_SIZE;
			
			a.setPos( x, y, 0 );
		}
		
		var shoot = function ( a:Enemy ) {
			
			var max = 32;
			for ( i in 0...max )
			{
				var th = Math.PI * 2 * i / max;
				
				var bullet = new Bullet( a.size.z, BulletType.orange, function( bullet:Bullet, dt:Float ) {
				
					bullet.x += 0.02 * Math.cos(th);
					bullet.y += 0.02 * Math.sin(th);
					
					Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
					bullet.onOutKill();
				});
				bullet.setPos( a.x, a.y, a.z );
			}
		}
		
		
		return[ for (i in 0...n) function( id:Int, idMax:Int ) {
					
					var a = new Policeman(path);
					//Type.createInstance(Clas, [level.path[i]] );
					a.shoot = shoot;
					a.id = id;
					a.idMax = idMax;
					a.delay = 5.;
					a.lastShoot = - a.delay;
					
				} ];
	}
	
	static function getLevel4():Datas
	{
		var path = function ( a:Enemy, t:Float ) { }
		
		var shoot = function ( a:Enemy ) {
			
			var max = 64;
			for ( i in 0...max )
			{
				var th = Math.PI * 2 * i / max;
				th += a.t;
				
				var bullet = new Bullet( a.size.z, BulletType.blue, function( bullet:Bullet, dt:Float ) {
				
					//var th2 = th + bullet.t;
					
					bullet.x += 0.02 * Math.cos(th);
					bullet.y += 0.02 * Math.sin(th);
					
					var z = bullet.mesh.z + 0.005 * ( Math.sin(th * 4) + 1 );
					bullet.setZ( z );
					
					Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
					bullet.onOutKill();
				});
				bullet.setPos( a.x, a.y, a.z );
				//var z = Math.sin( th * 4. ) * 1.5 + 1.5 + a.size.z;
				//bullet.setZ( z );
			}
		}
		
		
		return [ function( id:Int, idMax:Int ) {
					
					var a = new Tank(path);
					a.shoot = shoot;
					a.id = id;
					a.idMax = idMax;
					a.delay = 4.;
					a.lastShoot = - a.delay;
					a.x = 0.7 * Game.GROUND_HALF_SIZE;
					a.y = 0.;
					
				} ];
	}
	
	static function getLevel3():Datas
	{
		var n = 20;
		var rotationFct1 = function ( a:Enemy, t:Float ) {
			
			t %= n;
			var max = a.idMax * .5;
			var i = a.id % max;
			var x:Float, y:Float;
			
			var th = Math.PI * ( t * 0.5 + 2 * i / max );
			var x = Game.GROUND_HALF_SIZE * .5 + Game.GROUND_HALF_SIZE * .4 * Math.cos( th );
			var y = Game.GROUND_HALF_SIZE * .4 * Math.sin( th );
			
			a.setPos( x, y, 0 );
			a.setZ( getZ(t, a) );
		}
		
		var rotationFct2 = function ( a:Enemy, t:Float ) {
			
			t %= n;
			var max = a.idMax * .5;
			var i = a.id % max;
			var x:Float, y:Float;
			
			var th = Math.PI * ( -t * 0.5 + 2 * i / max );
			var x = Game.GROUND_HALF_SIZE * .5 + Game.GROUND_HALF_SIZE * .2 * Math.cos( th );
			var y = Game.GROUND_HALF_SIZE * .2 * Math.sin( th );
			
			a.setPos( x, y, 0 );
			a.setZ( getZ(t, a) );
		}
		
		var shoot = function (a:Enemy)
		{
			var h = a.size.z;
			var bullet1 = new Bullet( h, BulletType.orange, function( bullet:Bullet, dt:Float ) {
				
				bullet.x -= dt;
				Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
				bullet.onOutKill();
			});
			bullet1.setPos( a.x, a.y, a.z );
			
			var middle = 1.414213;
			bullet1 = new Bullet( h, BulletType.orange, function( bullet:Bullet, dt:Float ){
				
				bullet.x -= dt * middle; 
				bullet.y -= dt * middle;
				Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
				bullet.onOutKill();
			});
			bullet1.setPos( a.x, a.y, a.z );
			
			bullet1 = new Bullet( h, BulletType.orange, function( bullet:Bullet, dt:Float ){
				
				bullet.x -= dt * middle; 
				bullet.y += dt * middle;
				Bullet.faceToCam( bullet.mesh, Game.INST.s3d.camera.pos );
				bullet.onOutKill();
			});
			bullet1.setPos( a.x, a.y, a.z );
		}
		
		/*return {
				path:[ for (i in 0...n) (i<n>>1) ? rotationFct1 : rotationFct2 ],
				clas:[ for (i in 0...n) Policeman ],
				shoot:[ for (i in 0...n) shoot ]
			};*/
		return[ for (i in 0...n) function( id:Int, idMax:Int ) {
					
					var a = new Policeman( (id<idMax>>1) ? rotationFct1 : rotationFct2 );
					//Type.createInstance(Clas, [level.path[i]] );
					a.shoot = shoot;
					a.id = id;
					a.idMax = idMax;
					
				} ];
	}
	
	
}