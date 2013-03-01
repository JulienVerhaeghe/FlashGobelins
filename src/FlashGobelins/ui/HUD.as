package FlashGobelins.ui
{
	import FlashGobelins.customObjects.Font;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	
	public class HUD extends Sprite
	{

		
		
		
		
		/** Font for score value. */		
		private var fontScoreValue:Font;
		
		/** Font for Time label. */		
		private var fontTimeLabel:Font;
		
		/** Font for Time value. */		
		
		private var timeText:TextField;
		private var scoreText:TextField;
		private var _lifeText:TextField;
		private var _chronoAsset:Image;
		private var _fontAsset:Image;
		private var _fondScore:Image;
		private var _fondVie:Image;
		public function HUD()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);

			// la ou on va afficher le temps
			
			_creerChrono();
			// fond du tableau de bord
			_creerFondAsset();
			
			_creerScore();
			
			_creerVie();		
			
		}
		
		private function _creerVie():void
		{
			//fond du score
			_fondVie = new Image(Assets.getAtlas2().getTexture("vie0000"));
			_fondVie.x = 10;
			_fondVie.y = 30;
			addChild(_fondVie);

			// vie
			_lifeText = new TextField(150, 75, String(GameConstants.GAME_LIVES), fontScoreValue.fontName, fontScoreValue.fontSize, 0x335533);
			_lifeText.x = 15;
			_lifeText.y = 70;		
			
			this.addChild(_lifeText);
		}
		
		private function _creerScore():void
		{
			//fond du score
			fontScoreValue = Fonts.getFont("Komika_26");
			_fondScore = new Image(Assets.getAtlas2().getTexture("bulle_score0000"));
			_fondScore.x = 150;
			addChild(_fondScore);
			
			// score
			scoreText = new TextField(150, 75, "0", fontScoreValue.fontName, fontScoreValue.fontSize, 0xffffff);
			scoreText.x = 200;
			scoreText.y = 50;
			
			this.addChild(scoreText);
			
		}
		
		private function _creerFondAsset():void
		{
			_fontAsset = new Image(Assets.getAtlas2().getTexture("fond_elements0000"));
			_fontAsset.y = height - _fontAsset.height;
			_fontAsset.x = -10;
			addChild(_fontAsset);
		}
		
		private function _creerChrono():void
		{
			_chronoAsset = new Image(Assets.getAtlas2().getTexture("timer0000"));
			_chronoAsset.x = GameConstants.WIDTH - _chronoAsset.width + 10;
			addChild(_chronoAsset);
			
			// Get fonts for score labels and values.
			// Times
			var fontTimeValue:Font = Fonts.getFont("Komika_37");
			timeText = new TextField(150, 75, "60", fontTimeValue.fontName, fontTimeValue.fontSize, 0xffffff);
			timeText.x = GameConstants.WIDTH - 120;
			timeText.y =  50;
			this.addChild(timeText);
			
		}
		
		public function setTime(time:int):void{
			timeText.text = String(time);
		}
		
		public function setScore(score:int):void{
			scoreText.text = String(score);
		}
		
		public function setLives(lives:int):void{
			_lifeText.text = String(lives);
		}
	}
}