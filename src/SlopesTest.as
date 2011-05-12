package
{
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	//[Frame(factoryClass="Preloader")]

	public class SlopesTest extends FlxGame
	{
		public function SlopesTest():void
		{
			super(320, 240, GameState, 2, 60, 60);
			forceDebugger = true;
		}
	}
}
