package FlashGobelins.interactiveElement
{
	import math.Math2;

	public class PersonnageFabrique
	{
		public function PersonnageFabrique()
		{
		}
		
		public function createRandomPersonnage():Personnage{
			var type:int = Math2.shufflin(1,4);
			var personnage:Personnage;
			switch(type)
			{
				case 1:
				{
					personnage = createNiceVegetable();
					break;
				}
				
				case 2:
				{
					personnage = createZombiMeat();
					break;
				}
				case 3:
				{
					personnage = createZombiVegetable();
					break;
				}
					
				default:
				{
					break;
				}
			}
			return personnage
		}
		
		public function createNiceVegetable():NiceVegetable{
			var personnage:NiceVegetable = new NiceVegetable(Math2.randomiseBetween(1,3),Math2.randomiseBetween(1,2));
			return personnage;
		}
		
		public function createZombiMeat():ZombiMeat{
			var personnage:ZombiMeat = new ZombiMeat(Math2.randomiseBetween(1,3),Math2.randomiseBetween(1,2));
			return personnage;
		}
		
		public function createZombiVegetable():ZombiVegetable{
			var personnage:ZombiVegetable = new ZombiVegetable(Math2.randomiseBetween(1,3),Math2.randomiseBetween(1,2));
			return personnage;
		}
		
		
		
		
	}
}