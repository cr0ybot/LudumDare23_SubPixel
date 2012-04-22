package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Cory Hughart
	 */
	public class GameGrid extends FlxBasic
	{
		public var cellWidth:uint;
		public var cellHeight:uint;
		public var rows:uint;
		public var columns:uint;
		
		/**
		 * 
		 * @param	Width	Width of grid, in "pixels", as in a group of 3 subpixels, not screen pixels
		 * @param	Height	Height of grid, in "pixels", as in a group of 3 subpixels, not screen pixels
		 */
		public function GameGrid(Width:uint, Height:uint, CellWidth:uint, CellHeight:uint):void
		{
			width = Width * SubPixel.PIXEL_SIZE;
			height = Height * SubPixel.PIXEL_SIZE;
			cellWidth = CellWidth;
			cellHeight = CellHeight;
			centerX = FlxG.width / 2;
			centerY = FlxG.height / 2;
			x = centerX - (width / 2);
			y = centerY - (height / 2);
			
			rows = Height;
			columns = Width * 3;
		}
		
	}

}