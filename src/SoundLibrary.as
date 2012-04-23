package  
{
	/**
	 * ...
	 * @author Cory Hughart
	 */
	public class SoundLibrary 
	{
		[Embed(source="../assets/charge.mp3")] public static const CHARGE:Class;
		[Embed(source="../assets/shoot.mp3")] public static const SHOOT:Class;
		[Embed(source="../assets/match.mp3")] public static const MATCH:Class;
		[Embed(source="../assets/fail.mp3")] public static const FAIL:Class;
		[Embed(source="../assets/misc.mp3")] public static const MISC:Class;
		
		public function SoundLibrary() 
		{
			
		}
		
	}

}