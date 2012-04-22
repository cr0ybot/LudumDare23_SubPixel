package  
{
	import org.flixel.*;
	
	/**
	 * Creates a Pixel out of 3 SubPixels
	 * @author Cory Hughart
	 */
	public class Pixel extends FlxGroup
	{
		public static const PIXEL_SIZE:uint = 18;
		
		private var subpix:Vector.<SubPixel> = new Vector.<SubPixel>(3,true);
		private var color:uint;
		
		/**
		 * 
		 * @param	X		Sprite X position
		 * @param	Y		Sprite Y position
		 * @param	COLOR
		 */
		public function Pixel(X:Number, Y:Number, COLOR:uint):void
		{
			super(3); // max number of children
			
			color = COLOR;
			
			subpix[0] = new SubPixel(X, Y, splitColor(0));
			subpix[1] = new SubPixel(X + PIXEL_SIZE / 3, Y, splitColor(1));
			subpix[2] = new SubPixel(X + (PIXEL_SIZE / 3) * 2, Y, splitColor(2));
			
			add(subpix[0]);
			add(subpix[1]);
			add(subpix[2]);
		}
		
		private function splitColor(prime:uint):uint
		{
			var result:uint;
			
			switch (prime)
			{
				case 0: // extracts red
					result = ((( color >> 16 ) & 0xFF) << 16) | 0x000000;
					break;
				case 1: // extracts green
					result = (((color >> 8) & 0xFF ) << 8 ) | 0x000000;
					break;
				case 2: // extracts blue
					result = ( color & 0xFF ) | 0x000000;
					break;
				default:
					result = 0x000000;
					break;
			}
			
			return result;
		}
		
	}

}