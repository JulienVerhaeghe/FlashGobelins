package FlashGobelins.event
{
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		/** Change of a screen. */		
		public static const ZOMBI_DIE:String = "touchZombi";
		
		/** Custom object to pass parameters to the screens. */
		public var params:Object;
			
		public function GameEvent(type:String, _params:Object, bubbles:Boolean=false)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}