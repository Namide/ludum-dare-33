package ld33;

import h3d.mat.Data.MipMap;
import h3d.mat.Data.Wrap;
import h3d.mat.MeshMaterial;
import h3d.scene.Mesh;
import h3d.Vector;
import hxd.App;
import hxd.Math;
import ld33.actors.Actor;
import ld33.actors.Player;
import ld33.geom.FloorGeom;
import ld33.managers.AIManager;
import ld33.managers.AnimationManager;
//import ld33.managers.BulletManager;
import ld33.managers.InputManager;
import ld33.managers.PhysicManager;
import ld33.managers.SoundManager;
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

	static public inline var NO_END:Bool = false;
	
	public var time:Float;
	
	//public var onFinish:?h3d.Engine->Void;
	
	static inline var SSAO:Bool = false;
	
	public static inline var GROUND_HALF_SIZE:Int = 6;
	public static var INST:Game;
	
	//var time : Float = 0.;
	//var shadow : h3d.pass.ShadowMap;
	
	var levelNum = 0;
	
	public var input:InputManager;
	public var ai:AIManager;
	//public var bullet:BulletManager;
	public var physic:PhysicManager;
	public var anim:AnimationManager;
	public var wave:WaveManager;
	
	public var inGame = false;
	
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
	
	
	var spr : h2d.Sprite;
	var bmp : h2d.Bitmap;
	var tf : h2d.Text;
	public function screen(?score:Float = -1)
	{
		spr = new h2d.Sprite(s2d);
		spr.x = Std.int(s2d.width / 2);
		spr.y = Std.int(s2d.height / 2);

		var tile = hxd.Res.screen_title.toTile();
		tile = tile.center();
		var tex:h3d.mat.Texture = tile.getTexture();
		//trace( tex.filter ); // = Linear;
		//trace( tex.mipMap );// = MipMap.Linear;
		bmp = new h2d.Bitmap(tile, spr);
		
		
		
		if (score>-1)
		{
			var font = hxd.Res.font.font.toFont();
			tf = new h2d.Text(font, s2d);
			tf.textColor = 0xFFFFFF;
			tf.dropShadow = { dx : 0.5, dy : 0.5, color : 0x000000, alpha : 0.8 };
			
			var sc:Float = score - Math.floor(score);
			tf.text = "time: " + Math.floor(score)+"."+Math.floor((score-Math.floor(score)) * 100)+" sec";

			tf.y = -tf.textHeight * .5 + 150;
			tf.x = -tf.textWidth * .5 - 30;
			//tf.scale(7);
		}
		
		
		
		
		
		onResize();
		inGame = false;
	}
	override function onResize() {

		if ( spr == null || bmp == null )
			return;
		
		spr.x = Std.int(s2d.width / 2);
		spr.y = Std.int(s2d.height / 2);
		
		var r1 = bmp.tile.width / bmp.tile.height;
		var r2 = s2d.width / s2d.height;
		
		var s = (r1 > r2) ? ( s2d.width / bmp.tile.width) : (s2d.height / bmp.tile.height);
		bmp.tile = bmp.tile.center();
		bmp.setScale( s );
		
		if (tf != null)
		{
			//tf.setScale( s );
			tf.y = 10; //s2d.height - tf.textHeight;
			tf.x = s2d.width -tf.textWidth - 20;
		}
		
	}
	
	
	
	
	
	public function start()
	{
		initPlayer();
		wave.start(0);
		inGame = true;
		time = 0;
	}
	
	
	
	public override function init() {
		
		Game.INST = this;
		
		init3D();
		initManagers();
		//initPlayer();
		
		screen();
	}
		
	public function dispose(time:Float)
	{
		Actor.killAll();
		
		input.dispose();
		ai.dispose();
		physic.dispose();
		anim.dispose();
		wave.dispose();
		wave.play = false;
		
		
		/*while ( s3d.numChildren > 0 ) {
			s3d.removeChild( s3d.getChildAt(0) );
		}*/
		
		/*if ( onFinish != null )
			onFinish();*/
		screen(time);
	}
	
	function initManagers()
	{
		input = new InputManager();
		ai = new AIManager();
		//bullet = new BulletManager();
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
		
		if ( hxd.Key.isReleased( 77 ) ) {
			SoundManager.getInst().changeMusic();
		}
		
		if ( hxd.Key.isReleased( 83 ) ) {
			SoundManager.getInst().changeSound();
		}
		
		
		if ( !inGame ) {
			
			if ( hxd.Key.isReleased( hxd.Key.ENTER ) )
			{
				bmp.remove();
				spr.remove();
				bmp = null;
				spr = null;
				
				if (tf != null)
					tf.remove();
				
				start();
				
				
			}
			
		}
		else
		{
			dt *= 0.01;
			time += dt;
			//trace(time);
			
			input.update(dt);
			ai.update(dt);
			//bullet.update(dt);
			physic.update(dt);
			anim.update(dt);
			
			if ( wave != null )
				wave.update(dt);
		}
		
	}
	
}