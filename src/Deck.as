package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Cory Hughart
	 */
	public class Deck extends FlxSprite
	{
		public static const D_W:uint = 3;
		public static const D_H:uint = 6;
		
		public function Deck(List:Vector.<uint>) 
		{
			super(0, 0);
			updateDeck(List);
		}
		
		public function updateDeck(List:Vector.<uint>):void
		{
			var deckBitmap:BitmapData = new BitmapData(D_W * List.length, D_H, false);
			
			for (var i:uint = 0; i < List.length; i++)
			{
				var pixels:BitmapData;
				switch(List[i])
				{
					case SubPixel.RED:
						pixels = FlxG.addBitmap(SpriteLibrary.DECK_R);
						break;
					case SubPixel.GREEN:
						pixels = FlxG.addBitmap(SpriteLibrary.DECK_G);
						break;
					case SubPixel.BLUE:
						pixels = FlxG.addBitmap(SpriteLibrary.DECK_B);
						break;
				}
				
				deckBitmap.copyPixels(pixels, new Rectangle(0, 0, pixels.width, pixels.height), new Point((List.length - (i+1)) * D_W, 0));
			}
			
			this._pixels = deckBitmap;
			width = frameWidth = deckBitmap.width;
			height = frameHeight = deckBitmap.height;
			resetHelpers();
		}
		
	}

}