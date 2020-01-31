## Présentation
<img src="https://github.com/SimonROZEC/TWarves/blob/master/banner.png" height="256">

TWarves est un mini-jeu connecté à un chat Twitch et affiché sur l'overlay du streamer.
  
Dans ce jeu, les joueurs incarnent des nains devant travailler dans une mine afin de ramener chez eux le plus d'or et de trésors possible. Ils peuvent pour cela miner ou bien attaquer/tendre des pièges aux autres nains présents dans la mine afin de voler leurs ressources.
  
A tout moment, un spectateur du stream pourra décider de rejoindre la partie et contrôler un nain en entrant des commandes dans le chat. Il verra ainsi son nain s'animer directement sur le stream avec les autres joueurs présents dans la partie.

## Développement

Le jeu est développé en utilisant le moteur [Godot Engine 3.1](https://github.com/godotengine/godot) et les assets réalisés avec [Aseprite](https://github.com/aseprite/aseprite).

Il est possible de suivre le développement du jeu et de participer aux tests sur la chaîne Twitch [https://www.twitch.tv/kanemzi](https://www.twitch.tv/kanemzi).

## To do

*(les lignes en **gras** indiquent les points actuellement en cours de réalisation)*\
*(les lignes en italique sont des idées qui seront implémentées une fois que le jeu sera jouable)*\
*(de nouveaux points peuvent être ajoutés au fur et à mesure des idées ou des bugs trouvés)*

- [ ] Global
  - [x] Implémentation du système de queue
  - [ ] Création d'un objet *"Drop"*
     - [ ] Physique du drop
- [ ] Minage
  - [x] Affichage du nombre de pépites sur l'UI du nain
  - [x] Animer la récolte de pépites sur l'UI
  - [ ] Balance des différents filons
  - [ ] Créer la classe *"Treasure"* (extends Drop)
  - [ ] Ajout des probabilités de drop des trésors dans les filons
  - [ ] Création d'une classe listant tous les trésors non obtenus pour le moment
  - [ ] Les trésors ne sont pas collectés immédiatement mais droppés au sol
- [ ] Collecte (état)
  - [ ] Les nains peuvent ramasser les pépites au sol
  - [ ] Lorsque toutes les pépites ont été prises, le nain part miner sur le filon le plus proche
  - [ ] Les nains peuvent ramasser les trésors au sol
- [ ] Combat
  - [ ] Animer la perte de pépites sur l'UI
  - [ ] Créer l'état d'attaque du nain
    - [ ] Déplacement rapide vers la cible
    - [ ] Création de particules de poussière aux pieds du nain
    - [ ] Animer l'attaque du nain
    - [ ] Le nain n'a qu'une attaque par session dans la mine (à utiliser correctement donc)
    - [ ] Affichage d'un marker "Danger" sur le nain pris pour cible
    - [ ] Transition vers l'état de fatigue quand la cible est ratée
  - [ ] Créer l'état de stun du nain
    - [ ] Animation du stun
    - [ ] Sauvegarde de l'état précédent pour y retourner après la période de stun
    - [ ] Le nain drop un certain nombre de pépites en entrant dans cet état
    - [ ] Le nombre de pépites droppées dépend de la force du coup (passé en paramètre de la transition)
    - [ ] Le nain drop tous ses trésors en entrant dans cet état
  - [ ] Etat de fatigue
    - [ ] Créer l'animation de fatigue
    - [ ] Particules de fatigue
    - [ ] Si une action est demandée pendant la fatigue, elle est prise en compte à la fin de la fatigue
  - [ ] Créer l'objet *"GoldNugget"* (extends Drop)
    - [ ] Sprite aléatoire pour chaque pépite
  - [ ] *Augmentation progressive de la force d'attaque pendant que le nain mine*
- [ ] Joueur
  - [x] Sauver les pépites récoltées par le nain lorsqu'il sort de la mine
  - [ ] Sauver les trésors trouvés par le nain lorsqu'il sort de la mine
  - [x] Sauvegarde des données des joueurs lorsque le jeu est quitté (ou qu'un bouton de sauvegarde est pressé)
  - [x] Chargement des données des joueurs lorsque le jeu est lancé
- [ ] Customisation
- [ ] Commandes MJ
