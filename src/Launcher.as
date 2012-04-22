package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Cory Hughart
	 */
	public class Launcher extends FlxSprite
	{
		[Embed(source = "../assets/launcher.png")] private var launcherPNG:Class;
		
		public static const POSITION_BOTTOM:uint = 0x00;
		public static const POSITION_LEFT:uint = 0x01;
		public static const POSITION_TOP:uint = 0x10;
		public static const POSITION_RIGHT:uint = 0x11;
		
		private var position:uint;
		
		public function Launcher(Position:uint):void
		{
			position = Position;
			trace(position.toString(16));
			var X:int, Y:int;
			
			switch (position)
			{
				case POSITION_LEFT:
					X = 0;
					Y = FlxG.height / 2 - 12;
					break;
				case POSITION_TOP:
					X = FlxG.width / 2 - 12;
					Y = 0;
					break;
				case POSITION_RIGHT:
					X = FlxG.width - 24;
					Y = FlxG.height / 2 - 12;
					break;
				default:
				case POSITION_BOTTOM:
					X = FlxG.width / 2 - 12;
					Y = FlxG.height - 24;
					break;
			}
			
			super(X, Y);
			//x = X;
			//y = Y;
			trace(x + ":" + y);
			
			/*
			loadRotatedGraphic(launcherPNG, 4);
			
			addAnimation("bottom", [0], 0, false);
			addAnimation("left", [1], 0, false);
			addAnimation("top", [2], 0, false);
			addAnimation("right", [3], 0, false);
			
			updateRotation();
			*/
			
			loadGraphic(launcherPNG, true, false, 24, 24, true);
			//origin.x = 12;
			//origin.y = 12;
			
			addAnimation("bottom", [0], 0, false);
			addAnimation("left", [1], 0, false);
			addAnimation("top", [2], 0, false);
			addAnimation("right", [3], 0, false);
			
			updatePosition();
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.UP) position = POSITION_TOP;
			if (FlxG.keys.RIGHT) position = POSITION_RIGHT;
			if (FlxG.keys.DOWN) position = POSITION_BOTTOM;
			if (FlxG.keys.LEFT) position = POSITION_LEFT;
			
			updatePosition();
		}
		
		private function updatePosition():void
		{
			/*
			while (position > 3) position -= 4;
			while (position < 0) position += 4;
			*/
			
			switch (position)
			{
				case POSITION_LEFT:
					x = 0;
					y = FlxG.height / 2 - 12;
					play("left");
					break;
				case POSITION_TOP:
					x = FlxG.width / 2 - 12;
					y = 0;
					play("top");
					break;
				case POSITION_RIGHT:
					x = FlxG.width - 24;
					y = FlxG.height / 2 - 12;
					play("right");
					break;
				default:
				case POSITION_BOTTOM:
					x = FlxG.width / 2 - 12;
					y = FlxG.height - 24;
					play("bottom");
					break;
			}
		}
		
	}

}