package ld33.actors;

import h3d.mat.MeshMaterial;
import h3d.mat.Texture;
import h3d.prim.Plan2D;
import h3d.prim.Sphere;
import h3d.scene.Mesh;
import h3d.scene.Object;
import h3d.Vector;
import ld33.actors.Actor.ActorType;
import ld33.managers.WaveManager;

enum BulletType {
	orange;
}

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Bullet extends Actor
{
	static var sphere:Sphere;
	static var mats:Map<BulletType, MeshMaterial>;
	
	public var update:Bullet->Float->Void;
	
	public var t:Float;
	
	public function new(size:Float, bullet:BulletType, vel:Bullet->Float->Void ) 
	{
		super();
		
		type = ActorType.bullet;
		
		if ( sphere == null )
		{
			sphere = new Sphere(4,3);
			sphere.unindex();
			sphere.addNormals();
			//sphere.addUVs();
		}
		
		if ( mats == null )
			mats = new Map<BulletType, MeshMaterial>();
		
		if ( !mats.exists(bullet) )
		{
			/*var tex:Texture;
			switch( bullet )
			{
				case BulletType.orange :
					tex = hxd.Res.bullet_orange.toTexture();
			}
			tex.filter = Nearest;*/
			
			var mat = new MeshMaterial();
			Game.initMaterial( mat );
			
			mats.set( bullet, mat );
		}
		
		var mesh = new Mesh( sphere, mats.get(bullet), this );
		mesh.scale(size);
		
		update = vel;
		t = 0;
		
		Game.INST.input.add( this );
	}
	
	
	
}