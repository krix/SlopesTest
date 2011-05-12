package
{	
	import org.flixel.FlxTilemap;
	import org.flixel.FlxObject;
	import org.flixel.system.FlxTile;

	import org.flixel.FlxG;
	
	/**
	 * Extended FlxTilemap class that provides collision detection against slopes
	 * @author	Dirk Bunk
	 */
	public class FlxTilemapExt extends FlxTilemap
	{		
		//slope related variables
		protected var slopeSnapping:uint = 2;
		
		private var _blockX:Number;
		private	var _blockY:Number;
		private	var _dotX:Number;
		private	var _slopeY:Number;
		
		public static const SLOPE_FLOOR_LEFT:uint  = 2;
		public static const SLOPE_FLOOR_RIGHT:uint = 3;
		public static const SLOPE_CEIL_LEFT:uint   = 4;
		public static const SLOPE_CEIL_RIGHT:uint  = 5;
		
		override public function loadMap(MapData:String, TileGraphic:Class, TileWidth:uint=0, TileHeight:uint=0, AutoTile:uint=OFF, StartingIndex:uint=0, DrawIndex:uint=1, CollideIndex:uint=1):FlxTilemap
		{
			var tmpTileMap:FlxTilemap = super.loadMap(MapData, TileGraphic, TileWidth, TileHeight, AutoTile, StartingIndex, DrawIndex, CollideIndex);
			
			//set properties for slope tiles (to use our own collision detection)
			setTileProperties(SLOPE_FLOOR_LEFT, FlxObject.NONE, solveCollisionSlopeFloorLeft);
			setTileProperties(SLOPE_FLOOR_RIGHT, FlxObject.NONE, solveCollisionSlopeFloorRight);
			setTileProperties(SLOPE_CEIL_LEFT, FlxObject.NONE, solveCollisionSlopeCeilLeft);
			setTileProperties(SLOPE_CEIL_RIGHT, FlxObject.NONE, solveCollisionSlopeCeilRight);	
			
			return tmpTileMap;
		}

		/**
		 * Solves collision against a left-sided floor slope
		 * @param	slope	The slope to check against
		 * @param	obj		The object that collides with the slope
		 */
		final private function solveCollisionSlopeFloorLeft(slope:FlxTile, obj:FlxObject):void
		{			
			//calculate position of slope tile and the object
			_blockX = x + uint(slope.mapIndex % widthInTiles) * _tileWidth;
			_blockY = y + uint(slope.mapIndex / widthInTiles) * _tileHeight;
			_dotX = obj.x + obj.width;

			//check if object is inside slope
			if (_dotX >= _blockX + slopeSnapping) {
				//y position of the slope at the current x position
				_slopeY = _blockY + _tileHeight - (_dotX - _blockX) - slopeSnapping;
	
				//check if the object's y-position is inside slope
				if (obj.y + obj.height >= _slopeY) {
					if (obj.y - obj.last.y >= -1) {
						//set the object's touching flag
						obj.touching = FlxObject.FLOOR;
						
						//adjust the object's velocity
						obj.velocity.y = 0;
						
						//adjust the slope-y position
						if (_slopeY < _blockY) { _slopeY = _blockY; }
						
						//reposition the object
						obj.y = _slopeY - obj.height;
					}
				}
			}
		}
		
		/**
		 * Solves collision against a right-sided floor slope
		 * @param	slope	The slope to check against
		 * @param	obj		The object that collides with the slope
		 */
		final private function solveCollisionSlopeFloorRight(slope:FlxTile, obj:FlxObject):void
		{				
			//calculate position of slope tile and the object
			_blockX = x + uint(slope.mapIndex % widthInTiles) * _tileWidth;
			_blockY = y + uint(slope.mapIndex / widthInTiles) * _tileHeight;
			_dotX = obj.x;
			
			//check if object is inside slope
			if (_dotX <= _blockX + _tileWidth - slopeSnapping) {				
				//y position of the slope at the current x position
				_slopeY = _blockY + _tileHeight - (_blockX + _tileWidth - _dotX) - slopeSnapping;

				//check if the object's y-position is inside slope
				if (obj.y + obj.height >= _slopeY) {
					if (obj.y - obj.last.y >= -1) {
						//set the object's touching flag
						obj.touching = FlxObject.FLOOR;
						
						//adjust the object's velocity
						obj.velocity.y = 0;
						
						//adjust the slope-y position
						if (_slopeY < _blockY) { _slopeY = _blockY; }
						
						//reposition the object
						obj.y = _slopeY - obj.height;
					}
				}
			}
		}
		
		/**
		 * Solves collision against a left-sided ceiling slope
		 * @param	slope	The slope to check against
		 * @param	obj		The object that collides with the slope
		 */
		final private function solveCollisionSlopeCeilLeft(slope:FlxTile, obj:FlxObject):void
		{				
			//calculate position of slope tile and the object
			_blockX = x + uint(slope.mapIndex % widthInTiles) * _tileWidth;
			_blockY = y + uint(slope.mapIndex / widthInTiles) * _tileHeight;
			_dotX = obj.x + obj.width;
			
			//check if object is inside slope
			if (_dotX >= _blockX + slopeSnapping) {
				//y position of the slope at the current x position
				_slopeY = _blockY + (_dotX - _blockX) + slopeSnapping;

				//check if the object's y-position is inside slope
				if (obj.y <= _slopeY) {
					if (obj.last.y - obj.y >= -1) {
						//set the object's touching flag
						obj.touching = FlxObject.CEILING;
						
						//adjust the object's velocity
						obj.velocity.y += 15;
						
						//adjust the slope-y position
						if (_slopeY > _blockY + _tileHeight) { _slopeY = _blockY + _tileHeight; }
						
						//reposition the object
						obj.y = _slopeY;
					}
				}
			}
		}
		
		/**
		 * Solves collision against a right-sided ceiling slope
		 * @param	slope	The slope to check against
		 * @param	obj		The object that collides with the slope
		 */
		final private function solveCollisionSlopeCeilRight(slope:FlxTile, obj:FlxObject):void
		{													
			//calculate position of slope tile and the object
			_blockX = x + uint(slope.mapIndex % widthInTiles) * _tileWidth;
			_blockY = y + uint(slope.mapIndex / widthInTiles) * _tileHeight;
			_dotX = obj.x;
			
			//check if object is inside slope
			if (_dotX <= _blockX + _tileWidth - slopeSnapping) {
				//y position of the slope at the current x position
				_slopeY = _blockY + (_blockX + _tileWidth - _dotX) + slopeSnapping;

				//check if the object's y-position is inside slope
				if (obj.y <= _slopeY) {
					if (obj.last.y - obj.y >= -1) {
						//set the object's touching flag
						obj.touching = FlxObject.CEILING;
						
						//adjust the object's velocity
						obj.velocity.y += 15;
						
						//adjust the slope-y position
						if (_slopeY > _blockY + _tileHeight) { _slopeY = _blockY + _tileHeight; }
						
						//reposition the object
						obj.y = _slopeY;
					}
				}
			}
		
		}
	}
}