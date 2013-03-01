package FlashGobelins.interactiveElement
{
	import math.Math2;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class ZombiVegetable extends Personnage
	{
		
		public function ZombiVegetable(etage:int, type:int)
		{
			super(etage, type);
		}
		
		protected override function createZombiArt():void{
			if (_zombiImage == null)
			{
				var sprite:String;
				var spriteExplosed:String;
				spriteExplosed ='tomate_explosion0';
				_type = Math2.shufflin(1,3);
				if(_type == 1){
					sprite = 'friend_tomate';
					
				}else{
					sprite = 'friend_citron'
				}
				//par defaut j'affiche une banane
				_zombiImage = new MovieClip(Assets.getAtlas2().getTextures(sprite), 24);
				_zombieExplosed = new MovieClip(Assets.getAtlas2().getTextures(spriteExplosed), 24);
				Starling.juggler.add(_zombiImage);
				this.addChild(_zombiImage);
			}
			move()
		}
	}
}