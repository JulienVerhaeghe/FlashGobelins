package FlashGobelins.screens
{
	import FlashGobelins.customObjects.Font;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class TextFieldScore extends Sprite
	{
		private var _etoile:Image;
		private var _score:String;
		private var _pseudo:String;
		private var _textScore:TextField;
		private var _textPseudo:TextField;
		public function TextFieldScore(pseudo:String,score:String)
		{
			super();
			_etoile = new Image(Assets.getAtlas2().getTexture("etoile0000"));
			_etoile.x = 10;
			_etoile.y = 10;
			addChild(_etoile);
			var font:Font  = Fonts.getFont("Komika_26");
			_textPseudo = new TextField(150, 75, pseudo, font.fontName, font.fontSize, 0x555555);
			addChild(_textPseudo);
			
			_textScore = new TextField(150, 75, score , font.fontName, font.fontSize, 0xffffff);
			_textScore.x = 200;
			addChild(_textScore);
			
		}
	}
}