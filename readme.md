# Installation environnement ORO-COMMERCE:
## Pre requis :
- postgresql qui est  deja initialisé avec une base de données vide


## Installation :
Il suffit de lancer l'image docker php-with-nginx : cette image crée une application oro demo dans un repertoire pepsneir 
## Configuration : 
Les fichiers de configuration sur ce depot sont le fichier php.conf qui correspend a la configuration php necessaire pour l'optimisation de l'execution de l'app . Et le fichier nginx.conf qui represente la config nginx pour l'app avec un domaine qui doit correspendre au ingresse qui devra etre crée vers l'image deployé 