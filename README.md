# CONSIGNES DU JEU DE PISTE

## INTRODUCTION

* Ajourd'hui, vous êtes un entraineur d'une petite équipe
de foot. Avec peu de joueurs et sans sponsor vous allez
devoir vous dépasser pour recruter les meilleurs des
meilleurs avec votre budget de départ et celui que vous
récupérerez grâce à vos futurs sponsors.

* Vos talents de négociations, votre ruse et votre
maitrise du terminal vous seront d'une grande aide durant
cette epreuve !

* Afin de vous épaulez pour résoudre les défis vous pourrez
compter sur votre ami "man" qui, grâce à sa connaissance
étendue des commandes linux sauras vous procurer de
précieuses informations.

``` bash
man man
```
 
## STEP 1 : MY TEAM

* Pour commencer il vous faut créer votre fichier
d'équipe. Nom de l'équipe, mail de contact, slogan
(Le mail sera votre mail digital-grenoble)

```
==> Le fichier doit être : my_team.txt
==> Le contenu du fichier doit être du format :
```

``` bash
Name=NOM_DE_VOTRE_EQUIPE
Motto=SLOGAN_DE_VOTRE_EQUIPE
Email=VOTRE@ADRESSE_MAIL
```

* Ensuite executer le script :

``` bash
./subscribe_team.sh
```

* Si le script vous indiques SUCCESS, passez à l'étape 2,
sinon l'étape n'est pas valide et vous devez vériier
les consignes.

## STEP 2 : MY SPONSORS

* Vous êtes désormais posesseur d'une équipe ! La prochaine
étape va vous permettre de trouver des sponsors et donc du
budget.

* Dans le dossier sponsors, vous trouverez plusieurs
fichier Sponsors, à vous de déterminer lesquels vous
rapporterons le plus d'argents, mais attention les règles
de la compétition vous permettent de recruter un maximum
de 4 sponsors !

* Une fois vos choix effectués vous devez déplacer les
fichiers .sponsor correspondant dans le dossier My_Sponsors

* Lorsque vous avez 3 fichiers *.sponsor dans le dossier
My_Sponsors vous pouvez executer le script :

``` bash
./validate_sponsors.sh
```

* Si le script vous indiques SUCCESS, passez à l'étape 3,
sinon l'étape n'est pas	valide et vous devez vérifier
les consignes.

## STEP 3 : MY PLAYERS

* Vous avez désormais un budget pour recruter vos joueurs,
tout comme les sponsors vous devez chercher les joueurs
avec le meilleurs niveau et correspondant avec votre budget.

* 15 Joueurs maximum peuvent être recruté, pour ce faire,
vous devez déplacer les joueurs du dossier Players au
dossier My_Players. (il faudra créer le répertoire My_Players)

* Enfin executez le script :

``` bash
recruite_players.sh
```

* Si le script vous affiche SUCCESS, passez à l'étape 4,
sinon relisez bien les consignes.

## STEP 4 : MY FIRST COMPETITION

* Grâce à votre équipe fraichement formé, vous devez désormais 
participer à une compétition locale.

* Pour inscrire votre équipe, il faut copier vos joueurs dans
les répertoire Local_Competition/My_Team

* Enfin executez le script :

``` bash
play_local_competition.sh
```
* Si le script vous affiche SUCCESS, passez à l'étape 5,
sinon relisez bien les consignes.

## STEP 5 : MY EUROPEAN COMPETITION

* Grâce à votre victoire dans la première compétition, vous pouvez désormais 
participer à une compétition européenne.

* Pour inscrire votre équipe, il faut copier vos joueurs dans
les répertoire European_Competition/My_Team

* Enfin executez le script :

``` bash
play_european_competition.sh
```

* Suivez les instructions affichées par le script, Si le script vous 
affiche SUCCESS bravo vous avez terminé ce jeu ! Sinon relisez bien 
les consignes.
