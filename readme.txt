Technique générative pour la Qualité

Objectifs du projet
Générer de façon automatique grâce à Haskell des pages HTML à partir d'un graphe au format .dot

Fonctionnement du projet :
	Le projet est divisé en deux fichiers Haskell:
	"Parseur.hs" va parcourir le fichier dot et le découper en deux listes de String (Question et Réponse) qui seront exploitables par le module 
	"CreateHtml2.hs" qui va exploiter ces deux listes et construire les fichiers HTML 

Prérequis :
- Installer GHC qui va permettre de compiler et d'exécuter les fichiers Haskell (https://www.haskell.org/platform/)
- Le fichier représentant le graphe doit obligatoirement s'appeler "Qualite.dot"
- Pour visualiser le graphe sous forme graphique plutôt que textuelle, installer GraphViz (http://www.graphviz.org/download/),
	puis lancer une invite de commande, se placer dans le répertoire contenant le fichier dot (commande cd) ou bien faire maj+clic droit dans le répertoire
	en question et cliquer sur "Ouvrir la fenêtre PowerShell içi".
	Enfin, écrire la commande "dot -Tpng Qualite.dot -o Qualite.png" (Si le fichier s'appelle "Qualite.dot"), ce qui va créer le fichier Qualite.png



Lancement du projet :
- Double cliquer sur le fichier "Parseur.hs" pour lancer GHC qui va compiler les fichiers Haskell
- Taper la commande "main" qui va lancer la fonction main de Parseur.hs et va créer les fichiers HTML
