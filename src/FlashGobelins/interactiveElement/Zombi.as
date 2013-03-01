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
	
	public class Zombi extends Sprite
	{
		private var _type:int;
		private var _etage:int;
		
		/** zombi already hit ? */
		private var _alreadyHit:Boolean;
		/** zombi number of hit ? */
		private var _nbHit:int;
		/** zombi art */
		private var _zombiImage:MovieClip;
		public function Zombi(type:int,etage:int)
		{
						
			
			super();
			this._etage = etage;
			this._type = 1;
			_alreadyHit = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			this.addEventListener(TouchEvent.TOUCH,onTouch);
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
		private function createZombiArt():void
		{
			//selon le type chercher une texture differente
			//@todo switch Case
			// If this is the first time the object is being used.
			if (_zombiImage == null)
			{
				_zombiImage = new MovieClip(Assets.getAtlas2().getTextures("friend_banana00"), 26);
				Starling.juggler.add(_zombiImage);
				this.addChild(_zombiImage);
			}
			move()
		}
		
		

		public function move():void
		{
			
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
					startPointY = 100;
					startPoint = new Point(startPointX, startPointY);
					//
					middlePointX = GameConstants.WIDTH/2;
					middlePointY = -400;
					middlePoint = new Point(middlePointX, middlePointY);
					//
					bezierMiddlePoint = {x: middlePointX, y: middlePointY};
					passagesPoints = [bezierMiddlePoint];
					//
					endPointX = - 50;
					endPointY = 800;
					endPoint = new Point(endPointX, endPointY);
					
					break;
				}
				case 2:
				{
					startPointX = 50;
					startPointY = 200;
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
				case 3:
				{
					//
					startPointX = GameConstants.WIDTH - 50;
					startPointY = 700;
					startPoint = new Point(startPointX, startPointY);
					//
					middlePointX = GameConstants.WIDTH/2;
					middlePointY = 0;
					middlePoint = new Point(middlePointX, middlePointY);
					//
					bezierMiddlePoint = {x: middlePointX, y: middlePointY};
					passagesPoints = [bezierMiddlePoint];
					//
					endPointX = - 50;
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
			t.onUpdate = onzombiUpdate;
			t.onUpdateArgs = [t, this, startPoint, middlePoint, endPoint];
			t.onComplete = this.removeFromParent;
			t.onCompleteArgs = [true];
			t.animate("rotation", rotationTo);
			// add it to the Juggler
			Starling.juggler.add(t);
			
		}
		
		/**
		 * Update Bezier
		 */
		private function onzombiUpdate(t:Tween, image:DisplayObject, _startPoint:Point, _controlPoint:Point, _endPoint:Point):void {
			var time:Number = t.currentTime / t.totalTime;
			var xpos:Number = ((1 - time) * (1 - time)) * _startPoint.x + 2 * (1 - time) * time * _controlPoint.x + (time * time) * _endPoint.x;
			var ypos:Number = ((1 - time) * (1 - time)) * _startPoint.y + 2 * (1 - time) * time * _controlPoint.y + (time * time) * _endPoint.y;
			image.x = xpos;
			image.y = ypos;
		}
		
		public function onHit():void
		{
			//trace('heloZombi');
			//_alreadyHit = true;
			
				onDie()
			
			
		}
		
		public function onDie():void
		{
			trace('onDie');
			//lancer l'evenement pour prévenir la classe mére q'uil faut changer d'écran
			this.dispatchEvent(new GameEvent(GameEvent.ZOMBI_DIE, {zombi: this},true));
		}
		
		/**
		 * @private
		 */ 
		

		public function set etage(value:int):void
		{
			_etage = value;
		}
		
		
	}
}