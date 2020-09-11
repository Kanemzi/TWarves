[](#presentation)
## Présentation
<img src="https://github.com/SimonROZEC/TWarves/blob/master/banner.png" height="256">

TWarves est un mini-jeu connecté à un chat Twitch et affiché sur l'overlay du streamer.
  
Dans ce jeu, les joueurs incarnent des nains devant travailler dans une mine afin de ramener chez eux le plus d'or possible. Ils peuvent pour cela miner ou bien attaquer/tendre des pièges aux autres nains présents dans la mine afin de voler leurs ressources.
  
A tout moment, un spectateur du stream pourra décider de rejoindre la partie et contrôler un nain en entrant des commandes dans le chat. Il verra ainsi son nain s'animer directement sur le stream avec les autres joueurs présents dans la partie.

## Contrôle du nain
Les commandes permettant de jouer et de contrôler son nain sont les suivante:

`!joinmine` le nain rejoint la mine et commence à miner au filon le plus proche. Si le joueur n'a jamais joué avant, un profil est automatiquement créé.

`!mine [1, 2, 3]` demande au nain de miner à un filon particulier. Si aucun numéro n'est précisé, le nain part miner sur le filon le plus proche.

`!punch @[nom twitch]` demande au nain de frapper un autre nain. Si il parvient à donner un coup, la cible est immobilisée pendant quelques secondes et laisse tomber des pépites au sol. Si la cible parvient à s'enfuir, le nain est fatigué pendant quelques secondes. Si des pépites sont tombées au sol, le nain les ramasse automatiquement.

`!pick` demande au nain de ramasser les pépites tombées au sol. Lorsque toutes les pépites sont ramassées, il part miner sur le filon le plus proche.

`!exitmine` demande au nain de quitter immédiatement la mine avant la fin de son temps autorisé.

## Développement

Le jeu est développé en utilisant le moteur [Godot Engine 3.2](https://github.com/godotengine/godot) et les assets réalisés avec [Aseprite](https://github.com/aseprite/aseprite).

Il est possible de suivre le développement du jeu et de participer aux tests sur la chaîne Twitch [https://www.twitch.tv/kanemzi](https://www.twitch.tv/kanemzi).

## Extension Twitch

Une extension Twitch associée au jeu permet au joueur de consulter le classement des joueurs (nombre de pépites d'or collectées au total).

### Customisation du nain

L'extension permet également au joueur de customiser son nain en achetant de nouveaux éléments (couleurs, barbes, équipements, objets, emotes, ...) avec les pépites d'or qu'il a récolté dans la mine.

La customisation du nain prend effet lorsque celui-ci entre à nouveau dans la mine.

### Système de sauvegarde des données

Dans la version actuelle du jeu, les données sont stockées localement sur la machine faisant tourner le jeu.

Pour des raisons de flexibilité, l'intégralité des données de sauvegarde se trouveront sur le serveur distant dans la version finale du jeu.

Les données du joueur sont sauvegardées lorsque le nain sort de la mine (le nombre de pépites d'or récoltées sont envoyés au serveur)


## To do

*(les lignes en **gras** indiquent les points actuellement en cours de réalisation)*\
*(les lignes en italique sont des idées qui seront implémentées une fois que le jeu sera jouable)*\
*(de nouveaux points peuvent être ajoutés au fur et à mesure des idées ou des bugs trouvés)*

- [ ] Global
  - [x] Implémentation du système de queue
  - [x] Création d'un objet *"Drop"*
     - [x] Physique du drop
- [ ] Minage
  - [x] Affichage du nombre de pépites sur l'UI du nain
  - [x] Animer la récolte de pépites sur l'UI
  - [ ] Balance des différents filons
- [ ] Collecte (état)
  - [x] Les nains peuvent ramasser les pépites au sol
  - [x] Lorsque toutes les pépites ont été prises, le nain part miner sur le filon le plus proche
- [ ] Combat
  - [ ] Animer la perte de pépites sur l'UI
  - [x] Créer l'état d'attaque du nain
    - [x] Déplacement rapide vers la cible
    - [x] Création de particules de poussière aux pieds du nain
    - [x] Animer l'attaque du nain
    - [ ] Le nain n'a qu'une attaque par session dans la mine (à utiliser correctement donc)
    - [x] Affichage d'un marker "Danger" sur le nain pris pour cible
    - [ ] Transition vers l'état de fatigue quand la cible est ratée
  - [x] Créer l'état de stun du nain
    - [x] Animation du stun
    - [x] Le nain retourne miner au filon le plus proche après le stun
    - [x] Si une commande est donnée pendant le stun, elle est prise en compte à la fin du stun
    - [ ] Le nain drop un certain nombre de pépites en entrant dans cet état
    - [ ] Le nombre de pépites droppées dépend de la force du coup (passé en paramètre de la transition)
  - [x] Etat de fatigue
    - [x] Créer l'animation de fatigue
    - [x] Particules de fatigue
    - [x] Si une action est demandée pendant la fatigue, elle est prise en compte à la fin de la fatigue
  - [x] Créer l'objet *"GoldNugget"* (extends Drop)
    - [x] Sprite aléatoire pour chaque pépite
  - [ ] *Augmentation progressive de la force d'attaque pendant que le nain mine*
- [ ] Joueur
  - [x] Sauver les pépites récoltées par le nain lorsqu'il sort de la mine
  - [x] Sauvegarde des données des joueurs lorsque le jeu est quitté (ou qu'un bouton de sauvegarde est pressé)
  - [x] Chargement des données des joueurs lorsque le jeu est lancé
- [ ] *Customisation*
- [ ] Commandes MJ
     - [ ] *Eboulement au niveau d'un filon d'or (les nains touchés sont stun et droppent des pépites)*
     - [ ] *Douche de pépites d'or au niveau d'un filon ou d'un joueur (nombre de pépites précisé ou par défaut)*
- [ ] Serveur distant
     - [x] Base de données
          - [x] Table des joueurs
          - [ ] *Table des éléments de customisation*
          - [ ] *Table des transactions (achats d'éléments de customisation)*
     - [x] Connexion websocket serveur - jeu
          - [x] **Libraries de communication côté client et serveur**
               - [x] **Définition des types de message**
               - [x] **Helpers pour créer les messages**
          - [x] **Refactoring complet du système des joueurs**
               - [ ] Lorsqu'un joueur rejoint la mine, il est créé à partir des données du serveur
                    - [x] Si il s'agit de sa première connexion, ses données sont initialisées sur le serveur et retournées au jeu
               - [x] Lorsqu'un nain quitte la mine, ses données sont envoyées au serveur
                    - [x] Le joueur est supprimé lorsque le nain quitte la mine
     - [ ] Backend extension Twitch
          - [ ] Un utilisateur de l'extension peut récupérer les données liées à son compte
               - [ ] Erreur lorsque l'utilisateur ne s'est jamais connecté au jeu.
          - [x] Un utilisateur peut récupérer les informations de base des premiers joueurs du classement (display_name, golden_nuggets)
     - [ ] Extension Twitch
          - [x] Choix du framework à utiliser (Vue.js ?)
          - [ ] Les données du classement sont mises à jour régulièrement
          - [ ] Les informations du joueur sont mises à jour quand son nain quitte la mine via PubSub
