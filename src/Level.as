package  
{
	/**
	 * Generates random grid of pixels (each made up of 3 spList)
	 * 
	 * @author Cory Hughart
	 */
	
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
	public class Level extends FlxGroup
	{
		public var x:int, y:int, width:uint, height:uint, centerX:int, centerY:int;
		public var spList:Vector.<SubPixel>;
		
		/**
		 * 
		 * @param	W		Width of grid, in "pixels", as in a group of 3 subpixels, not screen pixels
		 * @param	H		Height of grid, in "pixels", as in a group of 3 subpixels, not screen pixels
		 */
		public function Level(W:uint, H:uint) 
		{
			/*
			pixels = new Vector.<Pixel>(W * H, true);
			
			width = W * Pixel.PIXEL_SIZE;
			height = H * Pixel.PIXEL_SIZE;
			x = (FlxG.stage.stageWidth / 2) - (width / 2);
			y = (FlxG.stage.stageHeight / 2) - (height / 2);
			trace("stage: " + FlxG.stage.stageWidth + "x" + FlxG.stage.stageHeight);
			trace("pixelgrid: " + x + ":" + y + " " + width + "x" + height);
			*/
			
			spList = new Vector.<SubPixel>();
			
			width = W * SubPixel.PIXEL_SIZE;
			height = H * SubPixel.PIXEL_SIZE;
			centerX = FlxG.width / 2;
			centerY = FlxG.height / 2;
			x = centerX - (width / 2);
			y = centerY - (height / 2);
			
			//var index:uint = 0;
			
			// random pixel grid
			for (var i:uint = 0; i < H; i++) // loop through rows
			{
				for (var j:uint = 0; j < W; j++) // loop through columns
				{
					/*
					var pixel:Pixel = new Pixel(x + j * Pixel.PIXEL_SIZE, y + i * Pixel.PIXEL_SIZE, Math.random() * 0xFFFFFF);
					pixels[index] = pixel;
					index++;
					add(pixel);
					*/
					
					for (var k:uint = 0; k < 3; k++) // loop through 3 spList that make one whole pixel
					{
						var spX:int = (x + j * SubPixel.PIXEL_SIZE) + (k * SubPixel.SUBPIX_W);
						var spY:int = (y + i * SubPixel.PIXEL_SIZE);
						var spC:uint = SubPixel.randomRGB();
						
						//trace("chose color: " + spC.toString(16));
						
						if (spList.length > 1)
						{
							// if color picked is different from both of the previous colors, choose one that does
							if (spC != spList[spList.length - 1].color && spC != spList[spList.length - 2].color)
							{
								spC = SubPixel.randomRGB(spC);
								//trace("	choosing new color: " + spC.toString(16));
							}
						}
						
						var sp:SubPixel = new SubPixel(spX, spY, spC);
						spList.push(sp);
						add(sp);
					}
				}
			}
			
		}
		
	}

}