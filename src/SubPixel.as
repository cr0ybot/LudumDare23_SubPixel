package  
{
	import flash.utils.Dictionary;
	import org.flixel.*;
	
	/**
	 * SubPixel class
	 * @author Cory Hughart
	 */
	public class SubPixel extends FlxSprite
	{
		static public const RED:uint = 0xFF0000;
		static public const GREEN:uint = 0x00FF00;
		static public const BLUE:uint = 0x0000FF;
		static public const BLACK:uint = 0x000000;
		static public const WHITE:uint = 0xFFFFFF;
		
		static public const SUBPIX_W:uint = 6;
		static public const PIXEL_SIZE:uint = 18;
		
		/**
		 * 
		 * @param	X		Sprite X position
		 * @param	Y		Sprite Y position
		 * @param	COLOR	Hex color value, hopefully already split into only the R, G, or B values
		 */
		public function SubPixel(X:Number, Y:Number, COLOR:uint):void
		{
			super(X, Y);
			
			loadGraphic(SpriteLibrary.SUBPIX, false, false, 6, 18, false);
			color = COLOR;
			
		}
		
		/**
		 * Moves subpixel in direction dictated by launcher position
		 * @param	Value		Absolute value of movement (positive number) in subpixel cell units; 1 will move subpixel 1 subpixel over, horizontally or vertically.
		 * @param	Position	Position value, provided by Launcher.position
		 */
		public function move(Value:uint, Position:uint):void
		{
			switch(Position)
			{
				case Launcher.POSITION_BOTTOM:
					y -= Value * PIXEL_SIZE;
					break;
				case Launcher.POSITION_LEFT:
					x += Value * SUBPIX_W;
					break;
				case Launcher.POSITION_TOP:
					y += Value * PIXEL_SIZE;
					break;
				case Launcher.POSITION_RIGHT:
					x -= Value * SUBPIX_W;
					break;
			}
		}
		
		/**
		 * 
		 * @param	Ignore	Ignore value. Will choose any color BUT this one.
		 * @return	Returns a color as uint
		 */
		public static function randomRGB(Ignore:uint = 0x000000):uint
		{
			var choice:uint = Math.floor(Math.random() * 3);
			
			if (Ignore != 0x000000)
			{
				while (colorFromNum(choice) == Ignore)
				{
					choice = Math.floor(Math.random() * 3);
				}
			}
			
			return colorFromNum(choice);
		}
		
		public static function colorFromNum(Num:uint):uint
		{
			if (Num == 0) return RED;
			else if (Num == 1) return GREEN;
			else if (Num == 2) return BLUE;
			else return WHITE;
		}
	}

}