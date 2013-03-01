package FlashGobelins.interactiveElement
{
	import math.Math2;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class ZombiMeat extends Personnage
	{
		public function ZombiMeat(etage:int, type:int)
		{
			super(etage,type);
	
		}
		
		protected override function createZombiArt():void{
			if (_zombiImage == null)
			{
				var sprite:String;
				_type = Math2.shufflin(1,3);
				if(_type == 1){
					sprite = 'friend_steak';
				}else{
					sprite = 'friend_saucisse'
				}
				//par defaut j'affiche une banane
				_zombiImage = new MovieClip(Assets.getAtlas2().getTextures(sprite), 24);
				Starling.juggler.add(_zombiImage);
				this.addChild(_zombiImage);
			}
			move()
		}
		
		protected override function onHit():void{
			_alreadyHit = true;
			var sprite:String;
			if(_type == 1){
				sprite = 'steak_blesse';
			}else{
				sprite = 'saucisse_blesse'
			}
			//par defaut j'affiche une banane
			_zombiImage = null;
			_zombiImage = new MovieClip(Assets.getAtlas2().getTextures(sprite), 24);
			Starling.juggler.add(_zombiImage);
			_nbHit++;
			if(_nbHit >= 2){
				
				onDie();
			}
			
		}
	}
}