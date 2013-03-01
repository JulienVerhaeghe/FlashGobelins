package FlashGobelins.screens
{
	import FlashGobelins.event.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	public class Accueil extends AScreen
	{
		//image de fond
		private var _bg:Image;
		private var _logo:Image;
		private var _playBtn:Button;
		private var _top10Btn:Button;
		
		public function Accueil()
		{
			super();
			//this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE,_onAddedToStage);
		}
		
		private function _onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,_onAddedToStage);
			drawScreen();
			
		}
		
		private function drawScreen():void
		{
			
			// Elements généraux
			
			
			_bg = new Image(Assets.getTexture("BgWelcome"));
			_playBtn = new Button(Assets.getAtlas2().getTexture("bouton_jouer0000"),'',Assets.getAtlas2().getTexture("bouton_jouer0001"));
			_top10Btn = new Button(Assets.getAtlas2().getTexture("bouton_top100001"),'',Assets.getAtlas2().getTexture("bouton_top100000"));
			this.addChild(_bg);
			_playBtn.x =  GameConstants.BTN_PLAY_X
			_playBtn.y = GameConstants.BTN_PLAY_Y;
			_playBtn.addEventListener(Event.TRIGGERED,onPlayBtnTriger);
			
			_top10Btn.x =  GameConstants.BTN_PLAY_X
			_top10Btn.y = GameConstants.BTN_PLAY_Y + 125;
			_top10Btn.addEventListener(Event.TRIGGERED,onTop10BtnTriger);
			
			this.addChild(_playBtn);
			this.addChild(_top10Btn);
		}
		
		private function onTop10BtnTriger():void
		{
			//lancer l'evenement pour prévenir la classe mére q'uil faut changer d'écran
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "topScore"}, true));
			
			if (!Sounds.muted) Sounds.sndCoffee.play();
		}
		
		private function onPlayBtnTriger():void
		{
			//lancer l'evenement pour prévenir la classe mére q'uil faut changer d'écran
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			
			if (!Sounds.muted) Sounds.sndCoffee.play();
		}
	}
}