package  
{
	/**
	 * ...
	 * @author Cory Hughart
	 */
	
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		
		private var startButton:FlxButton;
		
		public function MenuState() 
		{
			
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
			startButton = new FlxButton(20, 10, "Start", startGame);
			add(startButton);
		}
		
		private function startGame():void
		{
			//FlxG.mouse.hide();
			FlxG.switchState(new PlayState);
		}
		
	}

}