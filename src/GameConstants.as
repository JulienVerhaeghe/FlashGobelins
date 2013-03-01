package
{
	

	public class GameConstants
	{
		// Player properties -----------------------------------------
		
		/** Player's initial spare lives. */		
		public static const PLAYER_LIVES:int = 3;
		/** Taille de l'écran */
		public static const WIDTH:int= 1024;
		public static const HEIGHT:int= 768;
		
		/** Disposition des éléments */
		public static const BTN_PLAY_X:int = 736;
		public static const BTN_PLAY_Y:int = 25;
		
		/** Statut possible d'un personnage */
		public static const IS_HIT:String = 'isHit';
		public static const IS_DEAD:String = 'isDead';
		public static const IS_OK:String = 'isOK';
		
		/** Info necessaire à la connection à la bdd */
		public static const PROJECT_NAME:String = 'FridgeOfTheDeath';
		public static const URL_GET_SCORE:String = 'http://www.cordechasse.fr/gobelins/CRM12/scripts/getTopScores.php';
		public static const URL_SET_SCORE:String = 'http://www.cordechasse.fr/gobelins/CRM12/scripts/setScore.php';
		public static const GAME_LIVES:int = 3; 
		
		
	}
}