package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Dirk Bunk
	 */
	public class Player extends FlxSprite 
	{
		[Embed(source = 'player.png')] private var ImgPlayer:Class;
		
		public function Player(x:Number, y:Number) 
		{
			super(x, y, ImgPlayer);
			acceleration.y = 400;
			drag.x = 600;
			drag.y = 600;
			maxVelocity.x = 120;
			maxVelocity.y = 400;
		}
		
		override public function update():void
		{
			//MOVEMENT
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				acceleration.x += drag.x;
			}
						
			if(FlxG.keys.justPressed("X"))
			{
				if((acceleration.y > 0 && isTouching(FLOOR)) || (acceleration.y < 0 && isTouching(CEILING))){
					velocity.y = -acceleration.y / 2;
				}
			}
			
			if(FlxG.keys.justPressed("G"))
			{
				acceleration.y = -acceleration.y;
			}

		}
		
	}

}