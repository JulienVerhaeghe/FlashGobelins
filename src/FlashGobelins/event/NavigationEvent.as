package FlashGobelins.event
{
	import starling.events.Event;

	public class NavigationEvent extends Event
	{
		/** Change of a screen. */		
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		/** Custom object to pass parameters to the screens. */
		public var params:Object;
		
		public function NavigationEvent(type:String, _params:Object, bubbles:Boolean=false)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}