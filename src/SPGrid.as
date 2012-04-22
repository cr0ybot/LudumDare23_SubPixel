package  
{
	/**
	 * Generates random grid of pixels (each made up of 3 subpixels)
	 * 
	 * @author Cory Hughart
	 */
	
	import flash.display.BitmapData;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxColor;
	import org.flixel.system.FlxTile;
	
	public class SPGrid extends FlxGroup
	{
		public var playerX:int = 40;
		public var playerY:int = 20;
		public var x:int, y:int, width:uint, height:uint;
		public var pixels:Vector.<Pixel>;
		
		/**
		 * 
		 * @param	BDATA	BitmapData object for creating subpixels
		 */
		public function SPGrid(BDATA:BitmapData) 
		{
			super();
			
			//var pixel:Pixel = new Pixel(290, 290, 0x429A7F);
			//add(pixel);
			
			pixels = new Vector.<Pixel>(BDATA.width * BDATA.height, true);
			
			width = BDATA.width * Pixel.PIXEL_SIZE;
			height = BDATA.height * Pixel.PIXEL_SIZE;
			trace("level: " + BDATA.width + "x" + BDATA.height);
			x = (FlxG.stage.stageWidth / 2) - (width / 2);
			y = (FlxG.stage.stageHeight / 2) - (height / 2);
			//trace("stage: " + FlxG.stage.stageWidth + "x" + FlxG.stage.stageHeight);
			//trace("pixelgrid: " + x + ":" + y + " " + width + "x" + height);
			
			var index:uint = 0;
			
			// random pixel grid
			for (var j:uint = 0; j < BDATA.height; j++)
			{
				for (var i:uint = 0; i < BDATA.width; i++)
				{
					var pixel:Pixel = new Pixel(x + i * Pixel.PIXEL_SIZE, y + j * Pixel.PIXEL_SIZE, BDATA.getPixel(i, j));
					pixels[index] = pixel;
					index++;
					add(pixel);
				}
			}
			
			BDATA.dispose();
			
		}
		
	}

}