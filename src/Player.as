package  
{
	/**
	 * ...
	 * @author Cory Hughart
	 */
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Player extends FlxSprite 
	{
		[Embed(source = "../assets/player.gif")] private var playerPNG:Class;
		
		public function Player(X:Number, Y:Number) 
		{
			super(X, Y);
			
			loadGraphic(playerPNG, true, true, 3, 4, true);
			
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [0, 1], 4, true);
			addAnimation("jump", [2], 0, false);
			
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, true);
			FlxControl.player1.setMovementSpeed(50, 0, 20, 200, 50, 0);
			
			//JUMPING
			FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_RELEASED, 50, FlxObject.ANY, 250, 200);
			
			//GRAVITY
			FlxControl.player1.setGravity(0, 100);
			
			facing = FlxObject.RIGHT;
			
			play("idle");
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching == FlxObject.DOWN && FlxG.keys.SPACE)
			{
				play("jump");
			}
			else if (Math.abs(velocity.x) > 0 && touching == FlxObject.DOWN)
			{
				play("walk");
			}
			else
			{
				play("idle");
			}
		}
		
	}

}