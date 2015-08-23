package ld33;

import h3d.mat.Data.MipMap;
import h3d.mat.Data.Wrap;
import h3d.mat.MeshMaterial;
import h3d.scene.Mesh;
import h3d.Vector;
import hxd.App;
import hxd.Math;
import ld33.actors.Player;
import ld33.geom.FloorGeom;
import ld33.managers.AIManager;
import ld33.managers.AnimationManager;
import ld33.managers.BulletManager;
import ld33.managers.InputManager;
import ld33.managers.PhysicManager;
import ld33.managers.WaveManager;

class CustomRenderer extends h3d.scene.Renderer {

	var sao : h3d.pass.ScalableAO;
	var saoBlur : h3d.pass.Blur;
	var out : h3d.mat.Texture;

	public function new() {
		super();
		sao = new h3d.pass.ScalableAO();
		// TODO : use a special Blur that prevents bluring across depths
		saoBlur = new h3d.pass.Blur(0,0);//new h3d.pass.Blur(3,5);
		saoBlur.passes = 0;	// 3
	}

	override function process( ctx, passes ) {
		super.process(ctx, passes);

		var saoTarget = allocTarget("sao",0,false);
		setTarget(saoTarget);
		sao.apply(depth.getTexture(), normal.getTexture(), ctx.camera);
		saoBlur.apply(saoTarget, allocTarget("saoBlurTmp", 0, false));

		h3d.pass.Copy.run(saoTarget, null, Multiply);
	}

}

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Game extends App
{

	static inline var SSAO:Bool = false;
	
	public static inline var GROUND_HALF_SIZE:Int = 6;
	public static var INST:Game;
	
	var time : Float = 0.;
	//var shadow : h3d.pass.ShadowMap;
	
	var levelNum = 0;
	
	public var input:InputManager;
	public var ai:AIManager;
	public var bullet:BulletManager;
	public var physic:PhysicManager;
	public var anim:AnimationManager;
	public var wave:WaveManager;
	
	var player:Player;
	var ground:Mesh;
	var groundMod = 0.1;
	//var groundSize = 32;
	
	public static function initMaterial( m : h3d.mat.MeshMaterial ) {
		m.mainPass.enableLights = true;
		//m.shadows = true;
		
		if (SSAO) {
			m.addPass(new h3d.mat.Pass("depth", m.mainPass));
			m.addPass(new h3d.mat.Pass("normal", m.mainPass));
		}
	}

	/*public function start(level:Int)
	{
		
	}*/
	
	override function init() {
		
		Game.INST = this;
		
		init3D();
		initManagers();
		initPlayer();
		
		wave.start(0);
	}
	
	function initManagers()
	{
		input = new InputManager();
		ai = new AIManager();
		bullet = new BulletManager();
		physic = new PhysicManager();
		anim = new AnimationManager();
		wave = new WaveManager();
	}
	
	function initPlayer() {

		player = new Player();
		player.setPos( -Game.GROUND_HALF_SIZE * .5, .0, 0 );
		
	}
	
	function init3D() {

		//	FLOOR
		var floor = new FloorGeom(	2*GROUND_HALF_SIZE,
									2*GROUND_HALF_SIZE,
									2*GROUND_HALF_SIZE );
		floor.addNormals();
		floor.translate(-GROUND_HALF_SIZE, -GROUND_HALF_SIZE, -2*GROUND_HALF_SIZE);
		//floor.addRepUVs( 1/groundMod );
		floor.addRepUVs( 1 );
		var tex = hxd.Res.floor.toTexture();
		//tex.wrap = Wrap.Repeat;
		tex.filter = Nearest;
		var mat = new MeshMaterial(tex);
		/*var mat = new MeshMaterial();
		mat.color.set( 1, 1, 1);*/
		ground = new h3d.scene.Mesh(floor, mat, s3d);
		initMaterial(ground.material);
		ground.material.color.makeColor(1.0, 1.0, 1.0);

		
		//	WALL
		var tex2 = hxd.Res.wall.toTexture();
		tex.filter = Nearest;
		var mat2 = new MeshMaterial(tex2);
		var wall = new h3d.scene.Mesh(floor, mat2, s3d);
		initMaterial(wall.material);
		ground.material.color.makeColor(1.0, 1.0, 1.0);
		wall.y = -2*GROUND_HALF_SIZE;
		wall.z = 2 * GROUND_HALF_SIZE;
		
		wall = new h3d.scene.Mesh(floor, mat2, s3d);
		initMaterial(wall.material);
		ground.material.color.makeColor(1.0, 1.0, 1.0);
		wall.x = -2*GROUND_HALF_SIZE;
		wall.z = 2 * GROUND_HALF_SIZE;
		
		wall = new h3d.scene.Mesh(floor, mat2, s3d);
		initMaterial(wall.material);
		ground.material.color.makeColor(1.0, 1.0, 1.0);
		wall.x = 2*GROUND_HALF_SIZE;
		wall.z = 2 * GROUND_HALF_SIZE;
		
		wall = new h3d.scene.Mesh(floor, mat2, s3d);
		initMaterial(wall.material);
		ground.material.color.makeColor(1.0, 1.0, 1.0);
		wall.y = 2*GROUND_HALF_SIZE;
		
		
		/*for( i in 0...100 ) {
			var box : h3d.prim.Polygon = new h3d.prim.Cube(Math.random(),Math.random(), 0.7 + Math.random() * 0.8);
			box.unindex();
			box.addNormals();
			var p = new h3d.scene.Mesh(box, s3d);
			p.x = Math.srand(3);
			p.y = Math.srand(3);
			initMaterial(p.material);
			p.material.color.makeColor(Math.random() * 0.3, 0.5, 0.5);
		}*/
		
		
		// S3D
		s3d.camera.zNear = 0.5;
		s3d.camera.zFar = 50;
		
		
		// CAMERA
		//trace("camera:", s3d.camera.pos, s3d.camera.target);
		s3d.camera.pos.set( 0, 20., 8. );
		s3d.camera.target.set( 0, 0, 0. );
		
		// LIGHTS
		s3d.lightSystem.ambientLight.set(0.5, 0.5, 0.5);
		var dir = new h3d.scene.DirLight(new h3d.Vector( -0.3, -0.2, -1), s3d);
		dir.color.set(0.5, 0.5, 0.5);
		//shadow = cast(s3d.renderer.getPass("shadow"), h3d.pass.ShadowMap);
		//shadow.lightDirection = dir.direction;
		//shadow.blur.passes = 3;
		
		// SSAO
		if (SSAO) {
			s3d.renderer = new CustomRenderer();
		}
	}

	override function update( dt : Float ) {
		
		dt *= 0.01;
		time += dt;
		
		input.update(dt);
		ai.update(dt);
		bullet.update(dt);
		physic.update(dt);
		anim.update(dt);
		
		if ( wave != null )
			wave.update(dt);
		
		/*s3d.camera.pos.set( player.x + 4, player.y + 20., 8. );
		s3d.camera.target.set( player.x + 4, player.y, 0. );*/
		
	}

	
	
}