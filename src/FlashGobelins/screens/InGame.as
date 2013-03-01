package FlashGobelins.screens
{

	import FlashGobelins.customObjects.DataUser;
	import FlashGobelins.customObjects.Font;
	import FlashGobelins.event.GameEvent;
	import FlashGobelins.interactiveElement.Personnage;
	import FlashGobelins.interactiveElement.PersonnageFabrique;
	import FlashGobelins.interactiveElement.Zombi;
	import FlashGobelins.interactiveElement.ZombiMeat;
	import FlashGobelins.interactiveElement.ZombiVegetable;
	import FlashGobelins.ui.HUD;
	import FlashGobelins.ui.PauseButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;


	public class InGame extends AScreen
	{
		
		private var _score:int;
		private var _nbLives:int;
		private var _nbSeconde:int;
		private var _gameOverScreen:GameOver;
		private var _pause:PauseButton;
		
		//topDepart
		private var _topDepartText:TextField;
		private var _nbSecondeBeforeLaunch:int = 5;
		
		//element présent dans le jeu
		private var _milk:Image;
		private var _brocoli:Image;
		
		//plan ou les personnages sont ajouté
		private var _characterLayer:Sprite;
		//plan ou le lait et le brocoli sont
		private var _assetLayer:Sprite;
		
		private var _zombiFactory:PersonnageFabrique;
		
		// ------------------------------------------------------------------------------------------------------------
		// HUD
		// ------------------------------------------------------------------------------------------------------------
		
		/** HUD Container. */		
		private var hud:HUD;
		
		
		// ------------------------------------------------------------------------------------------------------------
		// INTERFACE OBJECTS
		// ------------------------------------------------------------------------------------------------------------
		
		//elements affichés
		private var _bg:Image;

		private var _pauseButton:PauseButton;
		
		/** GameOver Container. */
		//private var gameOverContainer:GameOverContainer;
		
		
		private var _gamePaused:Boolean;
		public function InGame()
		{
			super();
			this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			_nbLives = GameConstants.GAME_LIVES;
		}
		
		private function onAddedToStage(e:Event):void
		{
	
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			drawGame();
			topDepart();
		}
		
		private function topDepart():void
		{
			if(_nbSecondeBeforeLaunch != 0){
				Starling.juggler.delayCall(topDepart,1);
				_nbSecondeBeforeLaunch--;
				_topDepartText.text = String(_nbSecondeBeforeLaunch);
			}else{
				removeChild(_topDepartText);
				initGame()
			}
		}
		
		
		
	
		
		private function initGame():void
		{	
			_nbSeconde = 60;
			_launchChrono();
			_characterLayer.addEventListener(GameEvent.ZOMBI_DIE,onZombiDie);
			
			//my factory
			_zombiFactory = new PersonnageFabrique();
			// Game tick
			this.addEventListener(Event.ENTER_FRAME, _onGameTick);
			
		}
		
		private function _launchChrono():void
		{
			if(_nbSeconde != 0){
				Starling.juggler.delayCall(_launchChrono,1);
				_nbSeconde--;
				hud.setTime(_nbSeconde);
			}else{
				gameOver();
			}
		}
		
		
		private function gameOver():void
		{
			DataUser.currentScore = _score;
			if(DataUser.bestScore < _score) DataUser.bestScore = _score;
			miseAZero();
			_gameOverScreen = new GameOver();
			addChild(_gameOverScreen);
		}
		
		
		
		
		private function onZombiDie(e:GameEvent):void
		{
			trace('onZombiDie');
			_characterLayer.removeChild(e.params.zombi as Personnage);
			if( e.params.zombi is ZombiVegetable){
				_score += 10;
				trace('veggi');
			} else if(e.params.zombi is ZombiMeat) {
				_score += 30;
				trace('meaty');
			} else {
				trace('fuck');
				_score -= 5;
				removeALife();
			}
			
			hud.setScore(_score);
		}		
		
		private function removeALife():void
		{
			_nbLives--;
			hud.setLives(_nbLives);
			if(_nbLives <=0){
				gameOver();
			}
		}		
		
		private function _onGameTick(e:Event):void
		{
			if (!_gamePaused){
				if(Math.random()>0.95){
					var perso:Personnage = _zombiFactory.createRandomPersonnage();
					perso.scaleX = perso.scaleY = 0.5 + Math.random()*0.5;
					_characterLayer.addChild(perso);
				}
			}
		}
	
		//METTRE à zero les listener et le son
		public function miseAZero():void
		{
			this.removeEventListener(GameEvent.ZOMBI_DIE,onZombiDie);
			// Game tick
			this.removeEventListener(Event.ENTER_FRAME, _onGameTick);
		}
		
		private function drawGame():void
		{
			//fond
			this._bg = new Image(Assets.getTexture("BgLayer1"));
			addChild(_bg);
			
			//compter de départ
			//afficher le textField qui affiche le nombre de seconde
			var font:Font  = Fonts.getFont("Komika_37");
			_topDepartText = new TextField(150, 75, "5", font.fontName, font.fontSize, 0xDEA803);
			_topDepartText.x = (GameConstants.WIDTH - _topDepartText.width)>>1;
			_topDepartText.y = (GameConstants.HEIGHT - _topDepartText.height)>>1;
			_topDepartText.scaleX = _topDepartText.scaleY = 1.5;
			addChild(_topDepartText);
			
			
			
			
			this._characterLayer = new Sprite();
			addChild(_characterLayer);
			this._assetLayer = new Sprite();
			this._assetLayer.touchable = true;
			addChild(_assetLayer)
			_brocoli = new Image(Assets.getAtlas2().getTexture("brocolie0000"));
			_milk = new Image(Assets.getAtlas2().getTexture("lait0000"));
			
			_milk.y = 200;
			_brocoli.x = GameConstants.WIDTH - 275;
			_brocoli.y = 350;
			_assetLayer.addChild(_brocoli);
			_assetLayer.addChild(_milk);
			//hud
			this.hud = new HUD();
			
			hud.y = GameConstants.HEIGHT-140;
			this.addChild(this.hud);
		}
		
		
		
		
		private function zombiCreate():void
		{
			var zombi:Zombi = new Zombi(1,Math.ceil(Math.random()*3));
			_characterLayer.addChild(zombi);
			
		}
		
		
		
		
		
		
	}
}