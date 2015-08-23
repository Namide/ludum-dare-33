package ld33.managers;
import hxd.Res;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class SoundManager
{

	static var _INST:SoundManager;
	
	public var jump:hxd.res.Sound;
	public var impact:hxd.res.Sound;
	public var lose:hxd.res.Sound;
	
	
	function new() 
	{
		jump = Res.sound.jump;
		impact = Res.sound.impact;
		lose = Res.sound.lose;
	}
	
	public static function getInst()
	{
		if ( _INST == null )
			_INST = new SoundManager();
			
		return _INST;
	}
	
}