package FlashGobelins.ui
{
	import starling.display.Button;
	import starling.textures.Texture;
	
	public class PauseButton extends Button
	{
		public function PauseButton(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
		}
	}
}