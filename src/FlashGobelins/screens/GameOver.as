package FlashGobelins.screens
{
	
	
	import FlashGobelins.event.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOver extends Sprite
	{
		// fond legerement translucide afin de voir le jeu derriere
		private var _filtre:Quad
		private var _rejouerBtn:Button;
		private var _topScoreBtn:Button;
		private var _dessin:Image;
		
		public function GameOver()
		{
			super();
			_filtre = new Quad(GameConstants.WIDTH,GameConstants.HEIGHT,0x000000);
			_filtre.alpha = 0.8;
			addChild(_filtre);
			
			
			_topScoreBtn = new Button(Assets.getAtlas2().getTexture("bouton_top100001"),'',Assets.getAtlas2().getTexture("bouton_top100000"));
			_topScoreBtn.x = 100;
			_topScoreBtn.y = 340;
			_topScoreBtn.addEventListener(Event.TRIGGERED, _onTopScoreClick);
			this.addChild(_topScoreBtn);
			
			_rejouerBtn = new Button(Assets.getAtlas2().getTexture("bouton_rejouer0001"),'',Assets.getAtlas2().getTexture("bouton_rejouer0000"));
			_rejouerBtn.x = 640;
			_rejouerBtn.y = 340;
			_rejouerBtn.addEventListener(Event.TRIGGERED, _onRejouerClick);
			this.addChild(_rejouerBtn);
			
			
		}
		
		private function _onTopScoreClick():void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "topScore"}, true));
			
			if (!Sounds.muted) Sounds.sndCoffee.play();
			
		}
		
		private function _onRejouerClick(e:Event):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			
			if (!Sounds.muted) Sounds.sndCoffee.play();
		}
	}
}