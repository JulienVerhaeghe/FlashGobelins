package FlashGobelins.screens
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import FlashGobelins.customObjects.DataUser;
	import FlashGobelins.event.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;


	public class TopScore extends AScreen
	{
		//fond
		private var _bg:Image;
		//visuel de la page
		private var _title:Image;
		//sprite qui va contenir un textField décoré
		private var score:TextFieldScore;
		//score du joueur
		private var _scoreJoueur:int;
		private var _infoRequest:XML;
		
		private var _retourAccueil:Button;
		
		public function TopScore()
		{
			super();
			//this._scoreJoueur = score;
			drawTopScore();
			//envoyerScore();
			chercherTopScore();
			
		}
		
		private function drawTopScore():void
		{
			_bg = new Image(Assets.getTexture('BgTopScore'));
			addChild(_bg);
			
			_retourAccueil = new Button(Assets.getAtlas2().getTexture("bouton_accueil0001"),'',Assets.getAtlas2().getTexture("bouton_accueil0000"));
			_retourAccueil.addEventListener(starling.events.Event.TRIGGERED,onRetourTrigger);
			//@todo remplacé le scale x par une autre imag de la bonne taille
			_retourAccueil.scaleX = _retourAccueil.scaleY = 0.8;
			_retourAccueil.x = GameConstants.WIDTH - _retourAccueil.width - 20;
			_retourAccueil.y = GameConstants.HEIGHT - _retourAccueil.height - 15;
			addChild(_retourAccueil);
			
			
		}
		
		private function onRetourTrigger(e:starling.events.Event):void
		{
			//lancer l'evenement pour prévenir la classe mére q'uil faut changer d'écran
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "accueil"}, true));
			
			if (!Sounds.muted) Sounds.sndCoffee.play();
		}
		
		private function envoyerScore():void
		{
			//creer la requete
			var variables:URLVariables = new URLVariables();
			variables.project_name = GameConstants.PROJECT_NAME;
			variables.user_name = 'Julien';
			variables.score = 450;
			
			exportBDD(variables,GameConstants.URL_SET_SCORE);
		}
		
		private function chercherTopScore():void
		{
			//creer la requete
			var variables:URLVariables = new URLVariables();
			variables.project_name = GameConstants.PROJECT_NAME;
			variables.max_row = 10;
			
			//cherher les topScores
			PHPrequest(variables,GameConstants.URL_GET_SCORE);
			
			
		}
		
		//---fonction qui permet d'envoyer des informations au serveur dans le but de recevoir un xml
		// destination : adresse du serveur
		// info 	   : object urlvariable qui contient les infos à envoyer
		protected function PHPrequest(info:URLVariables,destination:String):void{
			//------Création de l'objet URLRequest
			var requete:URLRequest = new URLRequest(destination);
			
			//lui demandé de l'envois via la methode POST (ne pas utiliser l'URL)
			requete.method = URLRequestMethod.POST;
			requete.data = info;
			
			var url:URLLoader = new URLLoader();
			//listener
			url.addEventListener(flash.events.Event.COMPLETE,onPHPComplete ,false, 0, true);
			url.addEventListener(IOErrorEvent.IO_ERROR,_onError,false, 0, true);
			url.load(requete); 
			
			
		}
		//-----Prevenir que le formulaire est terminé et recuperer les information
		protected function onPHPComplete(e:flash.events.Event = null):void{
			//les informations sont recuperées
			_infoRequest = XML(e.target.data);
			//prevenir que la requéte est terminé
			//this.dispatchEvent(new Event(FormulaireEvent.FIN_REQUETE));
			afficherScore();
			
			
		}
		
		private function afficherScore():void
		{
			var scoreConteneur:Sprite = new Sprite();
			scoreConteneur.x = 400;
			scoreConteneur.y = 180;
			addChild(scoreConteneur);
			for(var i:int;i<10;i++){
				if(uint(_infoRequest.content.item[i].score)<DataUser.currentScore){
					
				}else{
					var textField:TextFieldScore = new TextFieldScore( _infoRequest.content.item[i].user_name,_infoRequest.content.item[i].score);
					textField.y = i * 50;
					scoreConteneur.addChild(textField);	
				}
			}
		}
		//-----envois formulaire 
		
		//---fonction qui permet d'envoyer des informations au serveur 
		// dans le but de les mettre dans une base de données
		// destination : adresse du serveur
		// info 	   : object urlvariable qui contient les infos à envoyer
		protected function exportBDD(info:URLVariables,destination:String):void{
			
			//Création de l'objet URLRequest
			var requete:URLRequest = new URLRequest(destination);
			//lui demander de l'envoyer via la methode POST (et non pas GET)
			requete.method = URLRequestMethod.POST;
			requete.data = info;
			
			//créer un url loader qui va permetre de passer l'objet au serveur
			var url:URLLoader = new URLLoader();
			
			//--listener
			//quand il est terminé
			url.addEventListener(flash.events.Event.COMPLETE,_onComplete, false, 0, true);
			//en cas d'erreur
			url.addEventListener(IOErrorEvent.IO_ERROR,_onError, false, 0, true);
			
			url.load(requete); // envois des données
			
		}
		//---Prevenir que le formulaire est envoyé
		private function _onComplete(e:flash.events.Event = null):void{
		
			_infoRequest = XML(e.target.data);
			//prevenir que la requéte est terminé
			//this.dispatchEvent(new Event(FormulaireEvent.FIN_REQUETE));
			
			trace(_infoRequest);
			
		}
		//---Gestion erreurs 
		private function _onError(event:IOErrorEvent):void{
			
			//afficher un message d'erreur et envoyer un mail
			//à l'administrateur pour prévenir l'existence d'une erreur
			trace("ioErrorHandler: " + event);
		}
	}
}