package  
{
	/**
	 * ...
	 * @author Cory Hughart
	 */
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/cursor.png")] private var cursor:Class;
		
		
		private var level:Level;
		//private var launcher:Launcher;
		//private var spgrid:SPGrid;
		
		public function PlayState() 
		{
			
		}
		
		override public function create():void
		{
			//FlxG.mouse.hide;
			FlxG.mouse.load(cursor, 2, -8, -8);
			
			FlxG.bgColor = 0xff000000;
			
			/*
			var perlinData:BitmapData = new BitmapData(32, 32);
			var seed:Number = Math.floor(Math.random() * 0xFFFFFF);
			perlinData.perlinNoise(32, 32, 32, seed, false, false, 7, false, null);
			
			var noiseData:BitmapData = new BitmapData(32, 32);
			seed = Math.floor(Math.random() * 0xFFFFFF);
			noiseData.noise(seed, 0, 255, 7, false);
			
			perlinData.merge(noiseData, perlinData.rect, new Point(0, 0), 0x40, 0x40, 0x40, 0x40);
			
			spgrid = new SPGrid(perlinData);
			add(spgrid);
			*/
			
			level = new Level(1);
			add(level);
			
			//launcher = new Launcher(level.grid, Launcher.POSITION_LEFT);
			//add(launcher);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}