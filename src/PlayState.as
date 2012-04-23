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
		public var scoreText:FlxText;
		public var multiplierText:FlxText;
		
		public function PlayState() 
		{
			
		}
		
		override public function create():void
		{
			FlxG.play(SoundLibrary.MISC);
			
			FlxG.mouse.load(cursor, 2, -8, -8);
			
			FlxG.bgColor = 0xff000000;
			
			level = new Level(1);
			add(level);
			
			scoreText = new FlxText(0, 0, 50, FlxG.score.toString());
			multiplierText = new FlxText(0, 0, 30, level.multiplier.toString() + "x");
			//multiplierText.size = 8;
			add(scoreText);
			add(multiplierText);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.UP || FlxG.keys.W) level.launcher.position = Launcher.POSITION_TOP;
			if (FlxG.keys.RIGHT || FlxG.keys.D) level.launcher.position = Launcher.POSITION_RIGHT;
			if (FlxG.keys.DOWN || FlxG.keys.S) level.launcher.position = Launcher.POSITION_BOTTOM;
			if (FlxG.keys.LEFT || FlxG.keys.A) level.launcher.position = Launcher.POSITION_LEFT;
			
			if (FlxG.mouse.wheel != 0)
			{
				switch(level.launcher.position)
				{
					case Launcher.POSITION_BOTTOM:
						if (FlxG.mouse.wheel > 0) level.launcher.position = Launcher.POSITION_LEFT;
						if (FlxG.mouse.wheel < 0) level.launcher.position = Launcher.POSITION_RIGHT;
						break;
					case Launcher.POSITION_LEFT:
						if (FlxG.mouse.wheel > 0) level.launcher.position = Launcher.POSITION_TOP;
						if (FlxG.mouse.wheel < 0) level.launcher.position = Launcher.POSITION_BOTTOM;
						break;
					case Launcher.POSITION_TOP:
						if (FlxG.mouse.wheel > 0) level.launcher.position = Launcher.POSITION_RIGHT;
						if (FlxG.mouse.wheel < 0) level.launcher.position = Launcher.POSITION_LEFT;
						break;
					case Launcher.POSITION_RIGHT:
						if (FlxG.mouse.wheel > 0) level.launcher.position = Launcher.POSITION_BOTTOM;
						if (FlxG.mouse.wheel < 0) level.launcher.position = Launcher.POSITION_TOP;
						break;
				}
			}
			
			scoreText.text = FlxG.score.toString();
			multiplierText.text = level.multiplier.toString() + "x";
			
			switch(level.launcher.position)
			{
				case Launcher.POSITION_BOTTOM:
					scoreText.alignment = "left";
					scoreText.angle = 0;
					scoreText.x = level.launcher.x + 26 + 50;
					scoreText.y = FlxG.height - 14;
					multiplierText.alignment = "left";
					multiplierText.angle = 0;
					multiplierText.x = level.launcher.x + 26;
					multiplierText.y = FlxG.height - 14;
					level.deck.angle = 0;
					level.deck.x = level.launcher.x - (level.deck.width + 3);
					level.deck.y = FlxG.height - 8;
					break;
				case Launcher.POSITION_LEFT:
					scoreText.alignment = "left";
					scoreText.angle = 90;
					scoreText.x = -12;
					scoreText.y = level.launcher.y + 54 + 50;
					multiplierText.alignment = "left";
					multiplierText.angle = 90;
					multiplierText.x = -2;
					multiplierText.y = level.launcher.y + 54;
					level.deck.angle = 90;
					level.deck.x = 2 - (level.deck.height);
					level.deck.y = level.launcher.y - (level.deck.width + 3);
					break;
				case Launcher.POSITION_TOP:
					scoreText.alignment = "right";
					scoreText.angle = 0;
					scoreText.x = level.launcher.x - 52 - 50;
					scoreText.y = 2;
					multiplierText.alignment = "right";
					multiplierText.angle = 0;
					multiplierText.x = level.launcher.x - 52;
					multiplierText.y = 2;
					level.deck.angle = 180;
					level.deck.x = level.launcher.x + level.launcher.width + 3;
					level.deck.y = 2;
					break;
				case Launcher.POSITION_RIGHT:
					scoreText.alignment = "left";
					scoreText.angle = 270;
					scoreText.x = FlxG.width - 37;
					scoreText.y = level.launcher.y - 30 - 50;
					multiplierText.alignment = "left";
					multiplierText.angle = 270;
					multiplierText.x = FlxG.width - 27;
					multiplierText.y = level.launcher.y - 30;
					level.deck.angle = 270;
					level.deck.x = FlxG.width - 8 - level.deck.height;
					level.deck.y = level.launcher.y + (level.launcher.height + 14);
					break;
			}
		}
		
	}

}