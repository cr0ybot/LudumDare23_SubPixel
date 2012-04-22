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
		
		private var grid:GameGrid;
		public var position:uint;
		public var loadPosition:FlxPoint;
		
		public function Launcher(Grid:GameGrid, Position:uint):void
		{
			grid = Grid;
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
			trace(x + ":" + y);
			
			loadGraphic(launcherPNG, true, false, 24, 24, true);
			
			addAnimation("bottom", [0], 0, false);
			addAnimation("left", [1], 0, false);
			addAnimation("top", [2], 0, false);
			addAnimation("right", [3], 0, false);
			
			loadPosition = new FlxPoint();
			
			//updatePosition();
		}
		
		override public function update():void
		{
			super.update();
			
			//updatePosition();
		}
		
		private function snapX():void
		{
			//if (x >= grid.width + grid.x) x = grid.width + grid.x - 1;
			//if (x < grid.x) x = grid.x;
			if (x >= grid.spBounds.x + grid.spBounds.width) x = grid.spBounds.x + grid.spBounds.width;
			if (x < grid.spBounds.x) x = grid.spBounds.x;
			x = x - ((x - grid.x) % SubPixel.SUBPIX_W) - SubPixel.SUBPIX_W - 3;
		}
		private function snapY():void
		{
			//if (y > grid.height) y -= SubPixel.PIXEL_SIZE;
			if (y >= grid.spBounds.y + grid.spBounds.height) y = grid.spBounds.y + grid.spBounds.height;
			if (y < grid.spBounds.y) y = grid.spBounds.y;
			y = y - ((y - grid.y) % SubPixel.PIXEL_SIZE) - 3;
		}
		
		public function updatePosition():void
		{
			/*
			while (position > 3) position -= 4;
			while (position < 0) position += 4;
			*/
			
			switch (position)
			{
				case POSITION_LEFT:
					x = 0;
					//y = FlxG.height / 2 - 12;
					y = FlxG.mouse.y;
					snapY();
					loadPosition.x = x + 6;
					loadPosition.y = y + 3;
					if (!grid.highlightH.visible) grid.highlightH.visible = true;
					if (grid.highlightV.visible) grid.highlightV.visible = false;
					grid.highlightH.x = loadPosition.x;
					grid.highlightH.y = loadPosition.y;
					play("left");
					break;
				case POSITION_TOP:
					//x = FlxG.width / 2 - 12;
					x = FlxG.mouse.x;
					y = 0;
					snapX();
					loadPosition.x = x + 9;
					loadPosition.y = y + 6;
					if (grid.highlightH.visible) grid.highlightH.visible = false;
					if (!grid.highlightV.visible) grid.highlightV.visible = true;
					grid.highlightV.x = loadPosition.x;
					grid.highlightV.y = loadPosition.y;
					play("top");
					break;
				case POSITION_RIGHT:
					x = FlxG.width - 24;
					//y = FlxG.height / 2 - 12;
					y = FlxG.mouse.y;
					snapY();
					loadPosition.x = x + 12;
					loadPosition.y = y + 3;
					if (!grid.highlightH.visible) grid.highlightH.visible = true;
					if (grid.highlightV.visible) grid.highlightV.visible = false;
					grid.highlightH.x = 6;
					grid.highlightH.y = loadPosition.y;
					play("right");
					break;
				default:
				case POSITION_BOTTOM:
					//x = FlxG.width / 2 - 12;
					x = FlxG.mouse.x;
					y = FlxG.height - 24;
					snapX();
					loadPosition.x = x + 9;
					loadPosition.y = y;
					if (grid.highlightH.visible) grid.highlightH.visible = false;
					if (!grid.highlightV.visible) grid.highlightV.visible = true;
					grid.highlightV.x = loadPosition.x;
					grid.highlightV.y = 6;
					play("bottom");
					break;
			}
		}
		
	}

}