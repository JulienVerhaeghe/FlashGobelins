package FlashGobelins.interactiveElement
{
	import math.Math2;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class NiceVegetable extends Personnage
	{
		public function NiceVegetable(etage:int, type:int)
		{
			super(etage, type);
		}
		protected override function createZombiArt():void{
			if (_zombiImage == null)
			{
				var sprite:String;
				var type:int = Math2.shufflin(1,3);
				if(type == 1){
					sprite = 'friend_orange';
				}else{
					sprite = 'friend_banana'
				}
				//par defaut j'affiche une banane
				_zombiImage = new MovieClip(Assets.getAtlas2().getTextures(sprite), 24);
				Starling.juggler.add(_zombiImage);
				this.addChild(_zombiImage);
			}
			move()
		}
	}
}