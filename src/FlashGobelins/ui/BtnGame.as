package FlashGobelins.ui
{
	import starling.display.Button;
	import starling.textures.Texture;
	
	public class BtnGame extends Button
	{
		public function BtnGame(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
		}
	}
}