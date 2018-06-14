Technique g�n�rative pour la Qualit�

Objectifs du projet
G�n�rer de fa�on automatique gr�ce � Haskell des pages HTML � partir d'un graphe au format .dot

Fonctionnement du projet :
	Le projet est divis� en deux fichiers Haskell:
	"Parseur.hs" va parcourir le fichier dot et le d�couper en deux listes de String (Question et R�ponse) qui seront exploitables par le module 
	"CreateHtml2.hs" qui va exploiter ces deux listes et construire les fichiers HTML 

Pr�requis :
- Installer GHC qui va permettre de compiler et d'ex�cuter les fichiers Haskell (https://www.haskell.org/platform/)
- Le fichier repr�sentant le graphe doit obligatoirement s'appeler "Qualite.dot"
- Pour visualiser le graphe sous forme graphique plut�t que textuelle, installer GraphViz (http://www.graphviz.org/download/),
	puis lancer une invite de commande, se placer dans le r�pertoire contenant le fichier dot (commande cd) ou bien faire maj+clic droit dans le r�pertoire
	en question et cliquer sur "Ouvrir la fen�tre PowerShell i�i".
	Enfin, �crire la commande "dot -Tpng Qualite.dot -o Qualite.png" (Si le fichier s'appelle "Qualite.dot"), ce qui va cr�er le fichier Qualite.png



Lancement du projet :
- Double cliquer sur le fichier "Parseur.hs" pour lancer GHC qui va compiler les fichiers Haskell
- Taper la commande "main" qui va lancer la fonction main de Parseur.hs et va cr�er les fichiers HTML
