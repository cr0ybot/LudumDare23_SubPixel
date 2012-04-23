package  
{
	/**
	 * ...
	 * @author Cory Hughart
	 */
	
	 import flash.display.BitmapData;
	 import flash.geom.Point;
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		private var title:FlxSprite;
		private var startButton:FlxButton;
		private var spgrid:SPGrid;
		
		public function MenuState() 
		{
			
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
			
			var perlinData:BitmapData = new BitmapData(16, 16);
			var seed:Number = Math.floor(Math.random() * 0xFFFFFF);
			perlinData.perlinNoise(32, 32, 32, seed, false, false, 7, false, null);
			
			var noiseData:BitmapData = new BitmapData(16, 16);
			seed = Math.floor(Math.random() * 0xFFFFFF);
			noiseData.noise(seed, 0, 255, 7, false);
			
			perlinData.merge(noiseData, perlinData.rect, new Point(0, 0), 0x40, 0x40, 0x40, 0x40);
			
			spgrid = new SPGrid(perlinData);
			add(spgrid);
			
			title = new FlxSprite(50, 50, SpriteLibrary.TITLE);
			add(title);
			
			// button is 80x20
			startButton = new FlxButton(110, 250, "Start", startGame);
			add(startButton);
		}
		
		private function startGame():void
		{
			//FlxG.mouse.hide();
			FlxG.switchState(new PlayState);
		}
		
	}

}