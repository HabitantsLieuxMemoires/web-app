Habitants, Lieux, Mémoires
========================

Habitants, Lieux, Mémoires est une plateforme ouvert de récit collectif de la Rive Droite de Bordeaux.

 Ce site participatif a pour vocation de décrire la Rive Droite de l'agglomération bordelaise, son histoire, ses lieux et, surtout, ses habitants.

## Présentation

Au même titre que le site en lui-même, le code source a pour but d'être ouvert à tous les contributeurs potentiels. Référez vous à la section [Contribuer](#contribuer) pour plus de détails.

## Prérequis

Pour pouvoir contribuer et améliorer la plateforme, les prérequis suivants doivent être installés sur votre poste :  

* [Vagrant](http://www.vagrantup.com) >= 1.6
* [Ansible](http://www.ansible.com) >= 1.7

### Vagrant

Vagrant est un gestionnaire de machines virtuelles permettant de créer, et configurer ces dernières de manière reproductible et portable. En utilisant Vagrant pour développer sur la plateforme Habitants Lieux Mémoires, vous êtes sûr d'avoir un environnement de développement identique et portable entre tous vos postes. 

Les dépendances du projet seront ainsi installées sur la machine virtuelle et ne pollueront pas votre ordinateur. De plus, la plateforme étant optimisée pour un environnement Ubuntu Server, vous pouvez quand même développer sur un poste Windows, OSX ou toute autre distribution Linux. 

Veuillez vous référer au site web de Vagrant pour plus de détails sur le fonctionnement de cet outil.

### Ansible

Ansible est un outil de provisioning, de configuration et d'orchestration automatisé d'ordinateurs.

Il permet d'installer et de configurer les dépendances de vos projets sur de nombreux ordinateurs en parallèle, de faciliter le déploiement de vos applications et d'orchestrer l'exécution de tâches distantes. Ansible se base sur le protocol SSH et ne requiert aucune dépendance sur les ordinateurs à ciblés.

Vagrant est compatible en natif avec Ansible pour la configuration de machines virtuelles et c'est le choix que nous avons fait lors du développement de Habitants, Lieux, Mémoires.

Veuillez vous référer au site web de Ansible pour plus de détails sur le fonctionnement de cet outil.

## Architecture

Habitants, Lieux, Mémoires est architecturé autour de 3 composants : 

* [Rails](http://rubyonrails.org/)  4.0.8
* [MongoDB](http://www.mongodb.org/) >= 2.6
* [ElasticSearch](http://www.elasticsearch.org/) >= 1.2

### Rails

Rails est un framework web permettant de créer des applications orientées base de données suivant le pattern MVC (Model-View-Controller).

La [documentation](http://rubyonrails.org/documentation/) de Rails est un moyen de simple de comprendre le fonctionnement de ce dernier et de le mettre en application. Si vous êtes novices, n'hésitez pas à suivre le cours gratuit fourni par [Codeschool](https://www.codeschool.com) disponible à cette [adresse](https://www.codeschool.com/courses/rails-for-zombies-redux).

### MongoDB

MongoDB est une base de données orientée documents. Sa principale force est d'être scalable (faculté de pouvoir monter en charge et à maintenir les performances lors de pics d'utilisation).

Dans le cadre du projet Habitants, Lieux, Mémoires c'est sa capacité à stocker des données sans schéma prédéfini (indispensable pour un gestionnaire de contenu collaboratif) qui a été jugée primordiale.

Pour les novices, un [shell interactif](http://try.mongodb.org/) a été créé pour faciliter la compréhension du fonctionnement de MongoDB. N'hésitez pas à y faire un tour pour en savoir plus.

### ElasticSearch

ElasticSearch est un moteur de recherche basé sur [Lucene](http://lucene.apache.org/).

Il est par nature distribué, scalable et accessible via une interface HTTP REST. Son gros avantage est de bénéficier de la puissance d'indexation et de recherche de Lucene. 

Il est utilisé par le projet Habitants, Lieux, Mémoires dans l'optique de fournir un moteur de recherche d'articles réactif, performant et évolutif. 

## Développer

Dans le but de pouvoir commencer à contribuer à HLM, il est nécessaire d'initialiser l'environnement de développement sur Vagrant, de configurer Rails sur la machine virtuelle et enfin de lancer le serveur.

Le provisioning de la machine virtuelle via Ansible nécessite l'installation de roles hébergés sur le site communautaire [Ansible Galaxy](https://galaxy.ansible.com). Ces derniers permettent de bénéficier du travail de nombreux contributeurs concernant l'installation et la configuration des logiciels/librairies les plus connus.

Pour ce faire, lancez un interpréteur de commandes (Terminal pour UNIX, Cmd our Powershell sur Windows), déplacez-vous à la racine du projet et exécutez la commande : 

```
ansible-galaxy -r provisioning/dependencies.ini
```

Pour lancer la machine virtuelle Vagrant :

```
vagrant up
```

**La première exécution de cette commande peut être longue. En effet, elle initialise la machine virtuelle depuis une image de base téléchargée depuis le site de Vagrant puis la configure en utilisant Ansible qui va télécharger et configurer toutes les dépendances du projet (compilation de Ruby, installation de MongoDB et ElasticSearch...)  ** 

Une fois votre machine virtuelle configurée et lancée, vous pouvez vous y connecter en exécutant la commande : 

```
vagrant ssh
```

Vous êtes maintenant connecté(e) via SSH à votre machine virtuelle. Vous pouvez exécuter toutes les commandes que vous voulez puis vous déconnecter en tapant ```exit```.

Il est maintenant nécessaire d'installer Rails pour pouvoir lancer le serveur web. Pour ce faire, exécutez les commandes suivantes. Si vous rencontrez une erreur, n'hésitez pas à créer une *Issue* (via le menu situé à votre droite).

```
cd /vagrant
gem install bundler
rbenv rehash
bundle install
rbenv rehash
```

[Rbenv](https://github.com/sstephenson/rbenv) est un gestionnaire de versions de Ruby permettant de fixer une version pour un projet et de garantir que cette dernière sera la même une fois en production.

Une fois ces commandes exécutées, Rails est installé, les services MongoDB et ElasticSearch sont démarrés. 

Pour lancer le serveur web, executez la commande ```bin/rails server```. Vous pouvez maintenant accèder au site web d'Habitants, Lieux, Mémoires en tapant l'addresse ```http://0.0.0.0:3000``` dans votre navigateur.

Par défault, le site est vide et donc inutilisable. Pour créer des utilisateurs, articles et commentaires, exécutez les commandes suivantes :

```
bin/rake db:reset
bin/rake searchkick:reindex:all
```

Et voilà, vous être prêt à contribuer à la plateforme Habitants, Lieux, Mémoires. 

Toutes ces commandes ne sont à exécuter **qu'une fois par poste** pour initialiser l'environnement de dévéloppement. Les prochaines fois, assurez-vous que la machine virtuelle n'est pas éteinte (```vagrant up```) puis lancez le serveur.

## Contribuer

Pour contribuer au projet, merci de passer par le méchanisme natif de [Pull Requests](https://help.github.com/articles/using-pull-requests/) de GitHub. 

Nous essaierons de fusionner vos modifications dans les plus brefs délais si elles sont jugées satisfaisantes et qu'elles apportent une plus-value au projet.

## Licence

Habitants, Lieux, Mémoires utilise la licence [Creative Commons 3.0](http://creativecommons.org/licenses/by-sa/3.0/fr/)

