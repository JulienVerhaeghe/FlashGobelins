package FlashGobelins.pool
{
	import FlashGobelins.interactiveElement.Zombi;

	public class PoolZombi
	{
		private var _create:Function;
		private var _clean:Function;
		private var _min_size:int;
		private var _max_size:int;
		private var _size:int = 0;
		private var _list:vector.<Zombi> = new Vector.<Zombi>;
		/** If this pool has been disposed. */
		private var disposed:Boolean = false;
		
		private var length:int;
		
		/**
		 * @param create This is the Function which should return a new Object to populate the Object pool
		 * @param clean This Function will recieve the Object as a param and is used for cleaning the Object ready for reuse
		 * @param minSize The initial size of the pool on Pool construction
		 * @param maxSize The maximum possible size for the Pool
		 *
		 */
		public function PoolZombi(create:Function, clean:Function = null, min_size:int = 5, max_size:int = 10)
		{
			this._create = create;
			this._clean = clean;
			this._min_size = min_size;
			this._max_size = max_size;
			
			// Create minimum number of objects now. Later in run-time, if required, more objects will be created < maximum number.
			for(var i:int = 0;i < min_size; i++) add();
		}
		
		private function add():void
		{
			_list[length++] = _create();
			_size++;	
		}
		
		/**
		 * Sets the minimum _size for the Pool.
		 *
		 */
		public function set min_size(num:int):void
		{
			_min_size = num;
			if(_min_size > _max_size) _max_size = _min_size;
			if(_max_size < _list.length) _list.splice(_max_size, 1);
			_size = _list.length;
		}
		
		/**
		 * Gets the minimum _size for the Pool.
		 *
		 */
		public function get min_size():int
		{
			return _min_size;
		}
		
		/**
		 * Sets the maximum _size for the Pool.
		 *
		 */
		public function set max_size(num:int):void
		{
			_max_size = num;
			if(_max_size < _list.length) _list.splice(_max_size, 1);
			_size = _list.length;
			if(_max_size < _min_size) _min_size = _max_size;
		}
		
		/**
		 * Returns the maximum _size for the Pool.
		 *
		 */
		public function get max_size():int
		{
			return _max_size;
		}
		
		/**
		 * Checks out an Object from the pool.
		 *
		 */
		public function checkOut():Zombi
		{
			if(length == 0) {
				if(_size < max_size) {
					_size++;
					return _create();
				} else {
					return null;
				}
			}
			
			return _list[--length];
		}
		
		/**
		 * Checks the Object back into the Pool.
		 * @param item The Object you wish to check back into the Object Pool.
		 *
		 */
		public function checkIn(item:Zombi):void
		{
			if(_clean != null) _clean(item);
			_list[length++] = item;
		}
		
		/**
		 * Disposes the Pool ready for GC.
		 *
		 */
		public function dispose():void
		{
			if(disposed) return;
			
			disposed = true;
			
			_create = null;
			_clean = null;
			_list = null;
		}
	}
}