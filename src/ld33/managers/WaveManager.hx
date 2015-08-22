package ld33.managers;
import ld33.actors.Actor;
import ld33.actors.Policeman;



typedef Vec2 = { x:Float, y:Float };
typedef Datas = { times:Array<Float>, pos:Array<Array<Vec2>>,/* dir:Array<Vec2>,*/ clas:Array<Class<Actor>> };


/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class WaveManager extends Manager
{
	var levels:Array<Datas> = [
		{
			times:[1, 1, 1, 1],
			pos:[
					[ { x:0., y:0. }, { x:0.35, y:-0.5 }, { x:0.7, y:0. }, { x:0.35, y:0.5 } ],
					[ { x:0.35, y:0.5 }, { x:0.7, y:0. }, { x:0.35, y:-0.5 }, { x:0., y:0. } ],
					[ { x:0.7, y:0. }, { x:0.35, y:0.5 }, { x:0., y:0. }, { x:0.35, y:-0.5 } ],
					[ { x:0.35, y:-0.5 }, { x:0., y:0. }, { x:0.35, y:0.5 }, { x:0.7, y:0. } ]
				],
			clas:[Policeman, Policeman, Policeman, Policeman]
		}
	];
	
	//var actors:Array<Actor>;
	var level:Datas;
	var t = .0;
	
	public function new( game:Game, levelId:Int ) 
	{
		super();
		
		level = levels[levelId];
		actors = [];
		for ( i in 0...level.clas.length )
		{
			var Clas = level.clas[i];
			var actor:Actor = Type.createInstance(Clas, [game.s3d] );
			var pos = level.pos[0][i];
			actor.setPos( pos.x * Game.GROUND_HALF_SIZE, pos.y * Game.GROUND_HALF_SIZE, actor.size.z * 0.5 );
			
			game.s3d.addChild( actor );
			game.anim.add( actor );
			add( actor );
		}
		
		t = 0;
	}
	
	public override function update( dt:Float )
	{
		t += dt;
		
		
		
	}
	
}