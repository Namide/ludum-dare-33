package ld33.managers;
import ld33.actors.Actor;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class Manager
{

	var actors:Array<Actor>;
	
	public function new() 
	{
		actors = [];
	}
	
	public inline function add( actor:Actor )
	{
		actors.push(actor);
	}
	
	public inline function remove( actor:Actor )
	{
		actors.remove(actor);
	}
	
	public function update( dt:Float )
	{
		
	}
	
}