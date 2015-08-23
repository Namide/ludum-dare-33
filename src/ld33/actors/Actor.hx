package ld33.actors;

import h3d.mat.MeshMaterial;
import h3d.mat.Texture;
import h3d.scene.Mesh;
import h3d.scene.Object;
import h3d.Vector;
import ld33.factory.CubeFactory;
import ld33.factory.MaterialFactory;
import ld33.geom.PlaneGeom;

enum ActorType {
	player;
	enemy;
	bullet;
	none;
}

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Actor extends Object
{
	//public var inputVel(default, default):Vector;
	public var lastVel:Vector;
	public var vel:Vector;

	public var onGround = true;
	
	public var size:Vector;
	public var life:Float;
	public var type:ActorType;
	
	public var shadow:Mesh;
	public var shadowMesh:PlaneGeom;
	public var shadowMat:MeshMaterial;
	public var mesh:Object;
	
	public function new() 
	{
		super();
		type = ActorType.none;
		vel = new Vector();
		lastVel = new Vector();
		
		Game.INST.input.add( this );
		Game.INST.s3d.addChild( this );
		
		
		
		if ( shadowMesh == null )
		{
			shadowMesh = new PlaneGeom(1., 1.);
			shadowMesh.unindex();
			shadowMesh.addNormals();
			shadowMesh.addUVs();
		}
		
		if ( shadowMat == null )
		{
			
			var tex:Texture;
			tex = hxd.Res.shadow.toTexture();
			//tex.filter = Nearest;
			
			shadowMat = new MeshMaterial(tex);
			shadowMat.blendMode = h2d.BlendMode.Multiply;
			//setMat( mat );
			//Game.initMaterial( mat );
			
			//mats.set( bullet, mat );
		}
		
		
		shadow = new Mesh( shadowMesh, shadowMat, this );
		shadow.rotate( Math.PI * .5, .0, .0 );
		shadow.z = .001;
	}
	
	public function update( dt:Float ) { }
	
	public function kill()
	{
		Game.INST.input.remove( this );
		Game.INST.s3d.removeChild( this );
	}
	
	function addCubes( size:Vector, cubes:Array<Vector> /* bottom to top: r, g, b, perc */ )
	{
		//setPos(0, 0, 0);
		this.size = size;
		var halfHeight = size.z * 0.5;
		
		mesh = new Object(this);
		mesh.setPos( 0, 0, halfHeight );
		
		
		var cubePos = new Vector();
		var cubeSize = size.clone();
		var height = - halfHeight;
		
		
		var invTotalHeight = 0.;
		for ( cubeDatas in cubes )
			invTotalHeight += cubeDatas.w;
		invTotalHeight = 1 / invTotalHeight;
		
		
		//trace(size);
		for ( cubeDatas in cubes )
		{
			var cHeight = cubeDatas.w * (halfHeight + halfHeight) * invTotalHeight;
			cubePos.z = height; //+ cHeight * 0.5;
			cubeSize.z = cHeight;
			
			//trace("cHeight:", cHeight, cubePos.z);
			
			addCube( cubePos, cubeSize, cubeDatas );
			height += cHeight;
			
			//trace(cubePos, cubeSize, cubeDatas);
		}
		
		
	}
	
	function addCube( pos:Vector, size:Vector, color:Vector )
	{
		var box : h3d.prim.Polygon = CubeFactory.getInst( size );//new h3d.prim.Cube(size.x, size.y, size.z);
		/*box.unindex();
		box.addNormals();*/
		var p = new h3d.scene.Mesh(box, MaterialFactory.getInst(color), this.mesh );
		/*p.x = hxd.Math.srand(3);
		p.y = hxd.Math.srand(3);
		initMaterial(p.material);
		p.material.color.makeColor(hxd.Math.random() * 0.3, 0.5, 0.5);*/
		p.x = -size.x * .5;
		p.y = -size.y * .5;
		p.z = pos.z;
		
		
		//addChild( p );
	}
	
}