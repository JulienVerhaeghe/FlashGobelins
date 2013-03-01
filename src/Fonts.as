package
{
	import FlashGobelins.customObjects.Font;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Fonts
	{
		
		/**
		 * Import des fonts
		 */		
		[Embed(source="../media/fonts/bitmap/fontKomika_37.png")]
		public static const Font_Komika_37:Class;
		
		[Embed(source="../media/fonts/bitmap/Komika_37.fnt", mimeType="application/octet-stream")]
		public static const XML_Komika_37:Class;
		
		[Embed(source="../media/fonts/bitmap/fontKomika_26.png")]
		public static const Font_Komika_26:Class;
		
		[Embed(source="../media/fonts/bitmap/Komika_26.fnt", mimeType="application/octet-stream")]
		public static const XML_Komika_26:Class;
		
		/**
		 * Object font
		 */
		private static var komika_37:BitmapFont;
		private static var komika_26:BitmapFont;
		
		
		public static function getFont(_fontStyle:String):Font
		{
			if (Fonts[_fontStyle] == undefined)
			{
				var texture:Texture = Texture.fromBitmap(new Fonts["Font_" + _fontStyle]());
				var xml:XML = XML(new Fonts["XML_" + _fontStyle]());
				Fonts[_fontStyle] = new BitmapFont(texture, xml);
				TextField.registerBitmapFont(Fonts[_fontStyle]);
			}
			
			return new Font(Fonts[_fontStyle].name, Fonts[_fontStyle].size);
		}
	}
}