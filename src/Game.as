package
{
	import flash.media.SoundMixer;
	
	import FlashGobelins.event.NavigationEvent;
	import FlashGobelins.screens.AScreen;
	import FlashGobelins.screens.Accueil;
	import FlashGobelins.screens.Didaticiel;
	import FlashGobelins.screens.InGame;
	import FlashGobelins.screens.TopScore;
	import FlashGobelins.ui.SoundButton;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Game extends Sprite
	{
		
		
		private var _currentPage:AScreen;
		private var _contentHolder:Sprite;
		private var _soundButton:SoundButton;
		
		public function Game()
		{
			//verifier que la scene est sur le stage
			this.addEventListener(Event.ADDED_TO_STAGE,_addedToStage);
		}
		
		private function _addedToStage(e:Event):void
		{	
			this.removeEventListener(Event.ADDED_TO_STAGE,_addedToStage);
			//On ecoute quand on veut hanger d'écran
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, _onChangeScreen);
			
			initScreen();
		}
		
		private function _onChangeScreen(event:NavigationEvent):void
		{
			//on enleve la page actuelle de la display list, on arrete son fonctionnement et on la met a null 
			_currentPage.hide(true);
			
			switch (event.params.id)
			{
				// selon l'information récuperé dans les parametres de l'event, on lance une page spécifique
				case "play":
					var inGame:InGame = new InGame();
					inGame.miseAZero();
					inGame.show(true);
					_currentPage = inGame;
					_contentHolder.addChild(inGame);
					break;
				case "didacticiel":
					var didacticiel:Didaticiel = new Didaticiel();
					topScore.show(true);
					_currentPage = didacticiel;
					_contentHolder.addChild(didacticiel);
					break;
				case "topScore":
					var topScore:TopScore = new TopScore();
					topScore.show(true);
					_currentPage = topScore;
					_contentHolder.addChild(topScore);
					break;
				case "accueil":
					var accueil:Accueil = new Accueil();
					accueil.show(true);
					_currentPage = accueil;
					_contentHolder.addChild(accueil);
					break;
			}
			
		}
		/**
		 * Afficher les elements de l'écran d'acceuil et de l'ui
		 * Et créer les écrans principaux
		 */		
		private function initScreen():void
		{
			//
			_contentHolder = new Sprite();
			addChild(_contentHolder);
			//écran d'accueil
			var accueil:Accueil = new Accueil();
			this._contentHolder.addChild(accueil);
			this._currentPage = accueil;
			
			//boutton dédié au son (arreter / lancer)
			_soundButton = new SoundButton();
			_soundButton.x = 25;
			_soundButton.y = 25;
			_soundButton.addEventListener(Event.TRIGGERED,onSoundBtnClick);
			this.addChild(_soundButton);
			
			//lancer directement le son
			Sounds.sndBgMain.play(0, 999)
			
		}
		
		private function onSoundBtnClick(e:Event):void
		{
			if (Sounds.muted)
			{
				Sounds.muted = false;
				
				Sounds.sndBgMain.play(0, 999);
				
				_soundButton.showUnmuteState();
			}
			else
			{
				Sounds.muted = true;
				SoundMixer.stopAll();
				
				_soundButton.showMuteState();
			}		
		}
	}
}