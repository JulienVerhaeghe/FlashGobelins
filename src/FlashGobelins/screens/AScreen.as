package FlashGobelins.screens
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class AScreen extends Sprite
	{
		public function AScreen()
		{
			super();
			//this.visible = false;
		}
		
		public function show(transition:Boolean = true):void
		{
			initialize();
			if(transition){
				this.alpha=0;
				
				var tween:Tween = new Tween(this, 2.0);
				tween.animate("alpha", 1);
				Starling.juggler.add(tween);
			}
			
		}
		
		public function hide(transition:Boolean = true):void
		{
			if(transition){
				var tween:Tween = new Tween(this, 2.0);
				tween.animate("alpha", 0);	
				tween.onComplete = destroy;
				Starling.juggler.add(tween);
					
			}
		}
		public function initialize():void{
			
			this.visible = true;
			
		}
		public function destroy():void{
			parent.removeChild(this);
			
		}
	}
}