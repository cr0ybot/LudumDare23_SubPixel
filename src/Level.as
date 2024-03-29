package  
{
	/**
	 * Generates random grid of pixels (each made up of 3 spList)
	 * 
	 * @author Cory Hughart
	 */
	
	import flash.geom.Rectangle;
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
	public class Level extends FlxGroup
	{
		public static const NEXT_NUM:uint = 6;
		
		public var multiplier:uint = 1;
		
		public var spList:Vector.<SubPixel>;
		public var grid:GameGrid;
		public var launcher:Launcher;
		public var nextColors:Vector.<uint>;
		public var currentSP:SubPixel;
		public var spCollisionRow:Vector.<SubPixel>;
		public var glow:FlxSprite;
		public var deck:Deck;
		
		/*
		public var charge:FlxSound = FlxG.play(SoundLibrary.CHARGE);
		public var shoot:FlxSound = FlxG.play(SoundLibrary.SHOOT);
		public var match:FlxSound = FlxG.play(SoundLibrary.MATCH);
		public var fail:FlxSound = FlxG.play(SoundLibrary.FAIL);
		public var misc:FlxSound = FlxG.play(SoundLibrary.MISC);
		*/
		
		/**
		 * Has the subpixel been launched?
		 */
		private var launched:Boolean = false;
		private var launchGlow:Boolean = false;
		
		//private var lastShotSuccess:Boolean = false;
		
		/**
		 * 
		 * @param	Stage	Level Stage... TODO
		 */
		public function Level(Stage:uint) 
		{
			
			spList = new Vector.<SubPixel>();
			
			grid = new GameGrid(Stage);
			add(grid);
			add(grid.highlightH);
			add(grid.highlightV);
			
			launcher = new Launcher(grid, Launcher.POSITION_LEFT);
			add(launcher);
			
			nextColors = new Vector.<uint>();
			generateColors();
			
			var x:int, y:int, width:uint, height:uint;
			
			width = height = GameGrid.SPGRID_SIZE * SubPixel.PIXEL_SIZE;
			x = (FlxG.width / 2) - (width / 2);
			y = (FlxG.height / 2) - (height / 2);
			
			// random pixel grid
			for (var i:uint = 0; i < GameGrid.SPGRID_SIZE; i++) // loop through rows
			{
				for (var j:uint = 0; j < GameGrid.SPGRID_SIZE; j++) // loop through columns
				{
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
			
			grid.spBounds = generateBounds();
			
			currentSP = generateNextSubPixel();
			
			deck = new Deck(nextColors);
			add(deck);
			
			glow = new FlxSprite(0, 0, SpriteLibrary.GLOW);
			glow.visible = false;
		}
		
		override public function update():void
		{
			super.update();
			
			if (!launched)
			{
				if (FlxG.mouse.justPressed())
				{
					launchGlow = true;
					glow.color = currentSP.color;
					glow.alpha = 0;
					add(glow);
					glow.visible = true;
					
					//charge.play();
					FlxG.play(SoundLibrary.CHARGE);
				}
				
				if (launchGlow)
				{
					if (glow.alpha != 1)
					{
						glow.alpha += 0.1;
					}
					else
					{
						launchGlow = false;
					}
				}
				
				if (FlxG.mouse.justReleased())
				{
					launched = true;
					launchGlow = false;
					remove(glow);
					
					spCollisionRow = getCollisionRow();
					
					//shoot.play();
					FlxG.play(SoundLibrary.SHOOT);
				}
				
				currentSP.x = launcher.loadPosition.x;
				currentSP.y = launcher.loadPosition.y;
				if (glow.visible)
				{
					glow.x = currentSP.x - 6;
					glow.y = currentSP.y - 6;
				}
				launcher.updatePosition();
			}
			else
			{
				animateLaunch();
			}
		}
		
		private function animateLaunch():void
		{
			// when launched subpixel collides with row, do stuff
			if (FlxG.overlap(currentSP, spCollisionRow[0])) // TODO: catch when overlap doesnt work and sp goes flying off grid
			{
				for (var i:uint = 0; i < spCollisionRow.length; i++)
				{
					spCollisionRow[i].move(1, launcher.position);
					if (i < spCollisionRow.length - 1)
					{
						// if subpixel does not run into another, end the loop
						if (!FlxG.overlap(spCollisionRow[i], spCollisionRow[i + 1])) break;
					}
				}
				
				// clear array to prep for next one
				spCollisionRow.length = 0;
				
				spList.push(currentSP);
				currentSP = generateNextSubPixel();
				
				// update spBounds so launcher can reach new branches
				grid.spBounds = generateBounds();
				
				checkForMatches();
				
				//launched = false;
			}
			else // if launched subpixel hasn't collided, move it towards goal
			{
				currentSP.move(1, launcher.position);
			}
		}
		
		private function checkForMatches():void
		{
			//var foundMatch:Boolean = false;
			var foundMatches:uint = 0;
			
			trace("--------------");
			
			var boundsH:uint = grid.spBounds.y + grid.spBounds.height;
			for (var i:uint = grid.spBounds.y; i <= boundsH; i += SubPixel.PIXEL_SIZE)
			{
				var spRow:Vector.<SubPixel> = spList.filter(
					function filterRow(item:SubPixel, index:int, vector:Vector.<SubPixel>):Boolean
					{
						if (item.y == i) return true;
						else return false;
					});
				
				trace("spRow length: " + spRow.length);
				
				if (spRow.length > 2)
				{
					// sort list so it's in order from left to right
					spRow.sort(sortByX);
					
					for (var j:uint = 2; j < spRow.length; j++)
					{
						// if this group of three are all different colors...
						if (spRow[j].color != spRow[j - 1].color && spRow[j].color != spRow[j - 2].color && spRow[j - 1].color != spRow[j - 2].color) // index out of range (144 / 12)
						{
							trace("different colors: " + (j - 2) + "-" + j);
							
							// if this group is also sequential/successive (no gaps)...
							var conTest:Number = (spRow[j].x + SubPixel.SUBPIX_W) - spRow[j - 2].x;
							trace("testing continuity, should be 18: " + conTest);
							if (conTest == SubPixel.PIXEL_SIZE) // checking the total width to see if it matches the pixel size
							{
								trace("match!: " + (j - 2) + "-" + j);
								
								// we found a match! what do we do with it?
								// delete them for now, maybe animate later
								spRow.slice(j - 2, j + 1).forEach(removeFromSPList);
								if (j < spRow.length - 3)
								j += 2; // move j ahead so it isnt looking for subpixels we just destroyed
								
								//foundMatch = true;
								foundMatches++;
							}
						}
					}
				}
			}
			
			//lastShotSuccess = foundMatch;
			
			if (foundMatches > 0)
			{
				//match.play();
				FlxG.play(SoundLibrary.MATCH);
				
				for (var k:uint = 0; k < foundMatches; k++)
				{
					increaseScore(k + 1);
					multiplier++
				}
			}
			else multiplier = 1;
			
			deck.updateDeck(nextColors);
			
			launched = false;
		}
		
		private function removeFromSPList(SP:SubPixel, Index:int, vector:Vector.<SubPixel>):void
		{
			spList.some(
				function removeIt(item:SubPixel, index:int, vector2:Vector.<SubPixel>):Boolean
				{
					if (item.x == SP.x && item.y == SP.y)
					{
						trace("removing subpixel at " + Index);
						spList.splice(index, 1);
						remove(item, true);
						return true;
					}
					else return false;
				});
		}
		
		private function getCollisionRow():Vector.<SubPixel>
		{
			var collisionRow:Vector.<SubPixel> = new Vector.<SubPixel>();
			if (launcher.position == Launcher.POSITION_BOTTOM || launcher.position == Launcher.POSITION_TOP)
			{
				for (var i:uint = 0; i < spList.length; i++)
				{
					if (spList[i].x == currentSP.x) collisionRow.push(spList[i]);
				}
				// sort the array according to y position, ascending
				collisionRow.sort(sortByY);
				// reverse if we want decending
				if (launcher.position == Launcher.POSITION_BOTTOM) collisionRow.reverse();
			}
			else
			{
				for (var j:uint = 0; j < spList.length; j++)
				{
					if (spList[j].y == currentSP.y) collisionRow.push(spList[j]);
				}
				// sort the array according to x position, ascending
				collisionRow.sort(sortByX);
				// reverse if we want decending
				if (launcher.position == Launcher.POSITION_RIGHT) collisionRow.reverse();
			}
			
			return collisionRow;
		}
		
		private function sortByX(sp1:SubPixel, sp2:SubPixel):Number
		{
			if (sp1.x > sp2.x) return 1;
			if (sp1.x == sp2.x) return 0;
			if (sp1.x < sp2.x) return -1;
			return 0
		}
		private function sortByY(sp1:SubPixel, sp2:SubPixel):Number
		{
			if (sp1.y > sp2.y) return 1;
			if (sp1.y == sp2.y) return 0;
			if (sp1.y < sp2.y) return -1;
			return 0
		}
		
		private function generateBounds():Rectangle
		{
			var rectX:int, rectY:int, rectX2:int, rectY2:int;
			rectX = spList[0].x;
			rectY = spList[0].y;
			rectX2 = spList[0].x;
			rectY2 = spList[0].y;
			
			for (var i:uint = 1; i < spList.length; i++)
			{
				if (spList[i].x < rectX) rectX = spList[i].x;
				if (spList[i].y < rectY) rectY = spList[i].y;
				if (spList[i].x > rectX2) rectX2 = spList[i].x;
				if (spList[i].y > rectY2) rectY2 = spList[i].y;
			}
			
			var rect:Rectangle = new Rectangle(rectX, rectY, rectX2 - rectX, rectY2 - rectY);
			return rect;
		}
		
		private function generateNextSubPixel():SubPixel
		{
			var sp:SubPixel = new SubPixel(launcher.loadPosition.x, launcher.loadPosition.y, nextColors.shift());
			add(sp);
			generateColors();
			return sp;
		}
		
		private function generateColors():void
		{
			while (nextColors.length < NEXT_NUM)
			{
				nextColors.push(SubPixel.randomRGB());
			}
		}
		
		private function increaseScore(Value:uint = 1):void
		{
			FlxG.score += Value * multiplier;
		}
		
	}

}