package FlashGobelins.interactiveElement
{
	import flash.geom.Point;
	
	import FlashGobelins.event.GameEvent;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.deg2rad;

	public class Personnage extends Sprite 
	{
		//----------------------------------------//
		//			Propriété					  //
		//----------------------------------------//
		/** La ou le personnage apparait */
		private var _etage:int;
		
		/** personnage déja frappé ? */
		protected var _alreadyHit:Boolean;
		
		/** nombre de fois frappé ? */
		protected var _nbHit:int;
		
		/** asset du personnage */
		// @todo remplacé par une animation
		protected var _zombiImage:MovieClip;
		protected var _zombieExplosed:MovieClip
		protected var _type:int
		
		private var _statut:String
		
		protected var _maxhit:Boolean;
		//----------------------------------------//
		//			Constructeur				  //
		//----------------------------------------//
		
		public function Personnage(etage:int,type:int){
			super();
			this._etage = etage;
			this._type  = type;
			
			// par defaut le personnage n'a pas été touché
			_alreadyHit = false;
			
			//savoir si,l'on est sur la scene
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			_maxhit = 1;
		}
		
		private function onAddedToStage(e:Event):void
		{
			//supprimer l'evenement désomais inutil
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			// savoir quand le personnage est touché
			this.addEventListener(TouchEvent.TOUCH,onTouch);
			// créer et afficher l'asset du personnage
			createZombiArt();
		}
		private function onTouch(e:TouchEvent):void
		{
			
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					onHit();
				}
					
				else if(touch.phase == TouchPhase.ENDED)
				{
					
				}
					
				else if(touch.phase == TouchPhase.MOVED)
				{
					
				}
			}
			
		}
		protected function createZombiArt():void
		{
			
			if (_zombiImage == null)
			{
				//par defaut j'affiche une banane
				_zombiImage = new MovieClip(Assets.getAtlas2().getTextures("friend_banana00"), 26);
				Starling.juggler.add(_zombiImage);
				this.addChild(_zombiImage);
			}
			move()
		}
		
		protected function move():void{
			
			var endPointX:Number;
			var endPointY:Number;
			var endPoint:Point;
			//
			var middlePointX:Number;
			var middlePointY:Number;
			var middlePoint:Point;
			//
			var bezierMiddlePoint:Object;
			var passagesPoints:Array;
			//
			var startPointX:Number;
			var startPointY:Number;
			var startPoint:Point;
			switch(_etage)
			{
				case 1:
				{
					
					//
					startPointX = GameConstants.WIDTH - 50;
					startPointY = 600;
					startPoint = new Point(startPointX, startPointY);
					//
					middlePointX = GameConstants.WIDTH/2;
					middlePointY = -100;
					middlePoint = new Point(middlePointX, middlePointY);
					//
					bezierMiddlePoint = {x: middlePointX, y: middlePointY};
					passagesPoints = [bezierMiddlePoint];
					//
					endPointX = -400;
					endPointY = 800;
					endPoint = new Point(endPointX, endPointY);
					
					break;
				}
				case 2:
				{
					startPointX = 50;
					startPointY = 400;
					startPoint = new Point(startPointX, startPointY);
					//
					middlePointX = GameConstants.WIDTH/2;
					middlePointY = -400;
					middlePoint = new Point(middlePointX, middlePointY);
					//
					bezierMiddlePoint = {x: middlePointX, y: middlePointY};
					passagesPoints = [bezierMiddlePoint];
					//
					endPointX = GameConstants.WIDTH + 50;
					endPointY = 800;
					endPoint = new Point(endPointX, endPointY);
					break;
				}
				
					
			}
			
			this.rotation = deg2rad(Math.random() * 360);
			var rotationTo:Number = deg2rad(Math.random() * 360);
			// create a Tween object
			var t:Tween = new Tween(this, 4);
			// move the object position
			t.onUpdate = onPersoUpdate;
			t.onUpdateArgs = [t, this, startPoint, middlePoint, endPoint];
			t.onComplete = this.removeFromParent;
			t.onCompleteArgs = [true];
			t.animate("rotation", rotationTo);
			// add it to the Juggler
			Starling.juggler.add(t);
			
		}
		private function onPersoUpdate(t:Tween, image:DisplayObject, _startPoint:Point, _controlPoint:Point, _endPoint:Point):void {
			var time:Number = t.currentTime / t.totalTime;
			var xpos:Number = ((1 - time) * (1 - time)) * _startPoint.x + 2 * (1 - time) * time * _controlPoint.x + (time * time) * _endPoint.x;
			var ypos:Number = ((1 - time) * (1 - time)) * _startPoint.y + 2 * (1 - time) * time * _controlPoint.y + (time * time) * _endPoint.y;
			image.x = xpos;
			image.y = ypos;
		}
		protected function onHit():void{
			_alreadyHit = true;
			_nbHit++;
			if(_nbHit >= _maxhit){
				
				onDie();
			}
			
		}
		protected function onDie():void{
			//explosion
			removeChild(_zombiImage);
			if(_zombieExplosed){
				addChild(_zombieExplosed);
				Starling.juggler.add(_zombieExplosed);
				Starling.juggler.delayCall(finish,0.3)
			}else{
				finish();
			}
			
		}
		
		private function finish():void
		{
			trace('finish');
			//lancer l'evenement pour prévenir la classe mére q'uil faut changer d'écran
			this.dispatchEvent(new GameEvent(GameEvent.ZOMBI_DIE, {zombi: this},true));
		}
	}
}