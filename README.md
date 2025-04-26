# Game

Ce jeu a été fait dans le cadre du cours Projet PFA en utilisant le modèle ECS (que vous pourrez retrouver dans le README à l'intérieur du répertoire suivant).

# Structure des répertoires

Ajouter du squelette pris lors du TP3.

* `ressource` :  répertoire contenant les images contenu dans le jeu :
  - `files` : contient 2 fichier texte permettant de stocker le nom des images et de pouvoir les utiliser après.
  - `images` : contient toutes les images principales pour le jeu.
  - `player/gojo` : contient les images du player permettant de faire l'animation du player.

* `src` : répertoire contenant le code source du jeu :
  - `composant` : contient les fichiers des composant utilisés pour le jeu.
  - `core` : contient les fichiers utilisés pour le maintient du jeu dans son ensemble.
  - `systems` : contient les systèmes utilisés pour tous ce qui va être de l'affichage et des déplacements du player.
  - `game.ml` : contient la boucle principale permettant au jeu de fonctionner.
