package FlashGobelins.screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	
	public class Didaticiel extends AScreen
	{
		private var _btnNext:Button;
		private var _btnPrevious:Button;
		private var _btnSkip:Button;
		private var _bg:Image;
		private var _masque:Image;
		private var _imgDidactiel:Image;
		public function Didaticiel()
		{
			super();
			//this._btnNext=new Button();
			//this.__btnPrevious=new Button();
			//this._btnSkip=new Button();
			_btnNext.x = 50;
			_btnPrevious.y = _btnNext.y = 500;
			_btnPrevious.x = 600;
			_btnSkip.x = GameConstants.WIDTH/2;
			_btnSkip.y = 600;
			addListener();
			
		}
		
		private function addListener():void
		{
			_btnNext.addEventListener(Event.TRIGGERED,onBtnNext);
			_btnPrevious.addEventListener(Event.TRIGGERED,onBtnPrevious);
			_btnSkip.addEventListener(Event.TRIGGERED,onBtnSkip);
		}
		
		private function onBtnPrevious():void
		{
			
			
		}
		
		private function onBtnSkip():void
		{
			
			
		}
		
		private function onBtnNext():void
		{
		
			
		}
		
		public override function destroy():void{
			super.destroy();
			_btnNext.removeEventListener(Event.TRIGGERED,onBtnNext);
			_btnPrevious.removeEventListener(Event.TRIGGERED,onBtnPrevious);
			_btnSkip.removeEventListener(Event.TRIGGERED,onBtnSkip);
		}
	}
}