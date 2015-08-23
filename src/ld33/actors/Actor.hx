package ld33.actors;

import h3d.scene.Object;
import h3d.Vector;
import ld33.factory.CubeFactory;
import ld33.factory.MaterialFactory;

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
	
	public function new() 
	{
		super();
		type = ActorType.none;
		vel = new Vector();
		lastVel = new Vector();
		
		Game.INST.input.add( this );
		Game.INST.s3d.addChild( this );
	}
	
	function addCubes( size:Vector, cubes:Array<Vector> /* bottom to top: r, g, b, perc */ )
	{
		this.size = size;
		
		var halfHeight = size.z * 0.5;
		setPos(0, 0, halfHeight);
		
		
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
		var p = new h3d.scene.Mesh(box, MaterialFactory.getInst(color), this );
		/*p.x = hxd.Math.srand(3);
		p.y = hxd.Math.srand(3);
		initMaterial(p.material);
		p.material.color.makeColor(hxd.Math.random() * 0.3, 0.5, 0.5);*/
		p.x = -size.x * .5;
		p.y = -size.y * .5;
		p.z = pos.z;
		
		
		addChild( p );
	}
	
}