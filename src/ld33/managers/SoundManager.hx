package ld33.managers;
import hxd.Res;

enum Sounds {
	jump;
	impact;
	lose;
	shot;
}

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class SoundManager
{
	static var _INST:SoundManager;
	
	public var volMusic:Bool = true;
	public var volSound:Bool = true;
	var music:hxd.res.Sound;
	
	public function play( sound:Sounds ) {
		
		if ( !volSound )
			return;
		
		switch ( sound )
		{
			case Sounds.impact :
				Res.sound.impact.play();
			case Sounds.jump :
				Res.sound.jump.play();
			case Sounds.lose :
				Res.sound.lose.play();
			case Sounds.shot :
				Res.sound.shoot.play();
		}
	}
	
	function new() 
	{
		music = Res.sound.music;
		music.play( true, 1 );
	}
	
	public function changeMusic()
	{
		volMusic = !volMusic;
		if ( volMusic )
		{
			music = Res.sound.music;
			music.play( true, 1 );
		}
		else
		{
			music.stop();
			music.dispose();
		}
	}
	
	public function changeSound()
	{
		volSound = !volSound;
	}
	
	public static function getInst()
	{
		if ( _INST == null )
			_INST = new SoundManager();
			
		return _INST;
	}
	
}