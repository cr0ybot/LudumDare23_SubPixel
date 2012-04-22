package  
{
	import flash.geom.Rectangle;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Cory Hughart
	 */
	public class GameGrid extends FlxSprite
	{
		public static const SPGRID_SIZE:uint = 4;
		public static const ROWS:uint = 16;
		public static const COLS:uint = 48;
		
		public var cellWidth:uint;
		public var cellHeight:uint;
		
		public var centerX:int;
		public var centerY:int;
		
		public var highlightH:FlxSprite;
		public var highlightV:FlxSprite;
		
		public var spBounds:Rectangle;
		
		/**
		 * 
		 * @param	Stage
		 */
		public function GameGrid(Stage:uint):void
		{
			width = COLS * SubPixel.SUBPIX_W;
			height = ROWS * SubPixel.PIXEL_SIZE;
			cellWidth = SubPixel.SUBPIX_W;
			cellHeight = SubPixel.PIXEL_SIZE;
			centerX = FlxG.width / 2;
			centerY = FlxG.height / 2;
			x = centerX - (width / 2);
			y = centerY - (height / 2);
			
			super(x, y);
			
			loadGraphic(SpriteLibrary.GRID, false, false, 288, 288, true);
			
			highlightH = new FlxSprite(x, y);
			highlightV = new FlxSprite(x, y);
			
			highlightH.makeGraphic(width, cellHeight, 0x22FFFFFF);
			highlightV.makeGraphic(cellWidth, height, 0x22FFFFFF);
			
			highlightH.visible = highlightV.visible = false;
		}
		
	}

}