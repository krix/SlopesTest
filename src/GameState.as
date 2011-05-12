package
{
    import org.flixel.*;
    
    public class GameState extends FlxState
    {
        [Embed(source = 'slopeTiles.png')] private var MapTiles:Class;
        [Embed(source = 'slopeTest.csv', mimeType = "application/octet-stream")] private var MapData:Class;
    
        private var _map:FlxTilemapExt;
        private var _player:Player;
		
        override public function create():void
        {			
			FlxG.bgColor = 0xff006699;
			
			add(new FlxText(32, 32, 100, "I CAN HAZ SLOPEZ!"));
			
            _map = new FlxTilemapExt;
            _map.loadMap(new MapData, MapTiles)
			add(_map);
			
            _player = new Player(128, 48);
			add(_player);
			
			FlxG.camera.setBounds(0, 0, _map.width, _map.height, true);
			FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);
        }
        
        override public function update():void
        {
            super.update();
			
			FlxG.collide(_map, _player);
        }
    
    }

}