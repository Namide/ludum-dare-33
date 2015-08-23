package ld33.actors;

import h3d.mat.MeshMaterial;
import h3d.mat.Texture;
import h3d.prim.Cube;
import h3d.prim.Plan2D;
import h3d.prim.Polygon;
import h3d.prim.Sphere;
import h3d.scene.Mesh;
import h3d.scene.Object;
import h3d.Vector;
import ld33.actors.Actor.ActorType;
import ld33.geom.PlaneGeom;
import ld33.managers.WaveManager;
import ld33.shader.BulletShader;

enum BulletType {
	orange;
}

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Bullet extends Actor
{
	static var sphere:Polygon;
	static var mats:Map<BulletType, MeshMaterial>;
	
	public var updatePath:Bullet->Float->Void;
	public var t:Float;
	
	
	public function new(size:Float, bullet:BulletType, vel:Bullet->Float->Void ) 
	{
		super();
		
		type = ActorType.bullet;
		
		if ( sphere == null )
		{
			sphere = new PlaneGeom(size, size);
			sphere.unindex();
			sphere.addNormals();
			sphere.addUVs();
		}
		
		if ( mats == null )
			mats = new Map<BulletType, MeshMaterial>();
		
		if ( !mats.exists(bullet) )
		{
			var tex:Texture;
			switch( bullet )
			{
				case BulletType.orange :
					tex = hxd.Res.bullet_orange.toTexture();
			}
			//tex.filter = Nearest;
			
			var mat = new MeshMaterial(tex);
			mat.blendMode = h2d.BlendMode.Alpha;
			//setMat( mat );
			//Game.initMaterial( mat );
			
			mats.set( bullet, mat );
		}
		
		mesh = new Mesh( sphere, mats.get(bullet), this );
		mesh.z = size * .5;
		//mesh.scale(size);
		
		updatePath = vel;
		t = 0;
		
		shadow.scale( size );
	}
	
	public override function update( dt:Float )
	{
		t += dt;
		updatePath( this, dt );
	}
	
	public override function kill()
	{
		super.kill();
	}
	
	public static inline function faceToCam( obj:Object, target:Vector ) {
		obj.qRot.initDirection( new Vector( target.y-obj.y,  obj.x - target.x, obj.z - target.z ) );
	}
	
	/*function setMat(m : h3d.mat.MeshMaterial)
	{
		//m.mainPass.addShader( new VertexColor() );
		
		var fog = new BulletShader();
		//fog.additive = false;
		//fog.bgColor.set( bgColor.x, bgColor.y , bgColor.z );
		//fog.farDist = areaSize * 0.5;
		m.mainPass.addShader( fog );
		//m.mainPass.enableLights = enableLights;
		//m.shadows = enableShadows;
		
		//m.addPass(new h3d.mat.Pass("depth", m.mainPass));
	}*/
	
}