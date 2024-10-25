# Ce projet a été réalisé dans un cadre éducatif et ne doit pas être détourné. Les éléments visuels contenues dans ce document sont utilisées à des fins pédagogiques et appartiennent à leurs propriétaires respectifs. 
PS : Soyez gentil, le projet à été fait en quelques heures...


---


## 📄 Documentation Technique

### **1. Introduction**

Bienvenue dans la doc' technique de l'application **jo-2024** ! L'idée est simple : permettre aux utilisateurs de choisir des offres (Solo, Duo, Famille), de passer commande, et hop, ils reçoivent leurs tickets avec QR codes. Ce document vous explique tout, depuis la sécurité jusqu'à l'archi, et même quelques suggestions pour les évolutions futures. Spoiler : il y en a plein.

### **2. Architecture de l'Application**

- **Frontend** : React.js
- **Backend** : Django 5.1.2 (avec DRF – parce que c'est toujours mieux)
- **Base de Données** : PostgreSQL (solide, fiable)
- **Authentification** : JWT (parce que c'est moderne)
- **Gestion des Fichiers Statics** : Whitenoise
- **QR Codes** : La bibliothèque `qrcode` fait tout le boulot
- **Déploiement** : On vise du Heroku, AWS ou DigitalOcean... au choix.

### **3. Sécurité**

#### **a. Authentification et Autorisation**

- **JWT (JSON Web Tokens)** : Gère la sécurité des endpoints de l'API. Les tokens d’accès et de rafraîchissement permettent une gestion des sessions utilisateurs, facile et sûre.
- **Permissions** :
  - **Utilisateurs Authentifiés** : Ils ont accès aux offres, commandes, tout ça.
  - **Admins** : Accès total. Ils peuvent tout faire, gérer les offres, les commandes, etc.

#### **b. Protection des Données**

- **Chiffrement** : HTTPS (en prod') pour sécuriser les transferts de données. Bah oui.
- **Hashing des Mots de Passe** : Pas de surprises, Django fait ça avec des algos solides.
- **Validation des Entrées** : Les serializers font le ménage dans les données qui arrivent.

#### **c. Meilleures Pratiques Implémentées**

- **Sécurité Django** : On utilise les middlewares standards (CSRF, XSS) pour se protéger.
- **Whitenoise** : Gestion des fichiers statiques, simple mais efficace.
- **Gestion des Secrets** : Avec `python-decouple`, les trucs sensibles ne traînent pas dans le code.

### **4. Technologies Utilisées**

- **Frontend** :
  - **React.js** : La star du frontend.
  - **Axios** : Pour papoter avec le backend via des requêtes HTTP.
  - **React Router** : Pour bouger entre les pages.
  - **Bootstrap** ou **Material-UI** : Pour un design sympa et responsive.
  
- **Backend** :
  - **Django 5.1.2** : Le cœur de l'appli.
  - **Django REST Framework** : Pour faire une API REST en béton.
  - **PostgreSQL** : La base de données qu'on aime.
  - **JWT via djangorestframework-simplejwt** : Pour gérer l’authentification.
  - **Whitenoise** : Gérer les fichiers statiques ? Check.
  - **qrcode** : Pour créer les QR codes des tickets.
  - **Gunicorn** : Pour déployer proprement.
  - **django-filter** : Filtrer les requêtes, facile.
  - **django-cors-headers** : Pour gérer les CORS et les requêtes cross-origin.

### **5. Schéma de la Base de Données**

#### **Modèles Principaux**

- **Offer**
  - `id` (AutoField)
  - `title` (CharField)
  - `description` (TextField)
  - `price` (DecimalField)
  - `created_at` (DateTimeField)
  - `updated_at` (DateTimeField)

- **Order**
  - `id` (AutoField)
  - `customer` (ForeignKey vers `User`)
  - `total_price` (DecimalField)
  - `status` (CharField avec choix)
  - `created_at` (DateTimeField)
  - `updated_at` (DateTimeField)

- **OrderItem**
  - `id` (AutoField)
  - `order` (ForeignKey vers `Order`)
  - `offer` (ForeignKey vers `Offer`)
  - `quantity` (PositiveIntegerField)
  - `price` (DecimalField)

- **Ticket**
  - `id` (AutoField)
  - `order_item` (ForeignKey vers `OrderItem`)
  - `event_name` (CharField)
  - `ticket_number` (CharField unique)
  - `issued_at` (DateTimeField)
  - `qr_code` (ImageField)

### **6. Endpoints de l'API**

#### **Authentification**

- **Inscription**
  - **URL** : `/api/register/`
  - **Méthode** : POST
  - **Description** : Crée un nouvel utilisateur. Easy.

- **Obtenir Token JWT**
  - **URL** : `/api/token/`
  - **Méthode** : POST
  - **Description** : Pour récupérer ton jeton d'accès.

- **Rafraîchir Token JWT**
  - **URL** : `/api/token/refresh/`
  - **Méthode** : POST
  - **Description** : Pour rafraîchir ton token d’accès quand il expire.

#### **Offres**

- **Lister les Offres**
  - **URL** : `/api/offers/`
  - **Méthode** : GET
  - **Description** : Voir toutes les offres disponibles. Facile.

- **Créer une Offre** (Admin)
  - **URL** : `/api/offers/`
  - **Méthode** : POST
  - **Description** : Ajouter une nouvelle offre. Réservé aux admins !

- **Détails, Mise à Jour, Suppression d'une Offre** (Admin)
  - **URL** : `/api/offers/<id>/`
  - **Méthode** : GET, PUT, DELETE

#### **Commandes**

- **Passer une Commande**
  - **URL** : `/api/checkout/`
  - **Méthode** : POST
  - **Description** : Commander des tickets.

- **Lister les Commandes d'un Utilisateur**
  - **URL** : `/api/orders/`
  - **Méthode** : GET
  - **Description** : Voir les commandes passées.

- **Admin : Gérer les Commandes**
  - **URL** : `/api/admin/orders/`
  - **Méthode** : GET, POST, PUT, DELETE

#### **Tickets**

- **Lister les Tickets d'un Utilisateur**
  - **URL** : `/api/tickets/`
  - **Méthode** : GET
  - **Description** : Voir ses tickets, tout simplement.

- **Admin : Gérer les Tickets**
  - **URL** : `/api/admin/tickets/`
  - **Méthode** : GET, POST, PUT, DELETE

#### **Frontend**

- **URL Principales** :
  - **Accueil** : `/`
  - **Inscription** : `/signup`
  - **Connexion** : `/login`
  - **Offres** : `/offers`
  - **Commande** : `/checkout`
  - **Tickets** : `/tickets`
  - **Admin** : `/admin/`

### **7. Sécurité Frontend**

- **Tokens JWT** : Le frontend récupère et stocke les tokens JWT pour gérer les sessions de manière sécurisée.
- **CSRF Protection** : La sécurité d'abord !
- **HTTPS** : Toujours activer en prod'.

### **8. Évolutions Futures**

#### **a. Sécurité**

- **Rate Limiting** : Limiter les tentatives pour empêcher les attaques brutales.
- **OAuth** : Ajouter Google, Facebook, etc. pour des connexions rapides.
- **Audits de Sécurité** : Réguliers, pour éviter les surprises.

#### **b. Fonctionnalités**

- **Notifications par Email** : Confirmer les commandes et envoyer les tickets directement.
- **Suivi des Transactions** : Pour ne jamais perdre de vue ce qui a été payé.
- **Événements** : Associer chaque ticket à un événement spécifique.

---

## 📘 Manuel d'Utilisation

### **1. Introduction**

Salut et bienvenue dans le manuel d’utilisation de l’app **jo-2024**. Que tu sois un utilisateur lambda ou un admin, ce guide est là pour te simplifier la vie. Prêt à découvrir comment tout fonctionne ? C'est parti !

### **2. Prérequis**

Pas besoin d’un doctorat en informatique ici, juste quelques trucs essentiels pour utiliser l’application :
- Un navigateur web qui tient la route (genre Chrome, Firefox, Safari, ou Edge – oui, même Edge).
- Une connexion Internet qui marche (pas besoin de la fibre, mais bon, c’est mieux).
- Un compte utilisateur ou admin pour accéder aux fonctionnalités. Facile, non ?

### **3. Inscription et Connexion**

#### **a. Inscription**

1. **Va sur la page d'inscription**
   - Ouvre ton navigateur et tape `http://localhost:3000/signup` (ou l'URL magique du site déployé, si ça te parle plus).

2. **Remplis le formulaire**
   - **Nom d'utilisateur** : En gros, Prénom et nom.
   - **Email** : Un email valide, sinon... pas de compte !
   - **Mot de passe** : Choisis un truc que t'oublieras pas, mais sécurisé quand même (au moins 8 caractères, etc.).

3. **Envoie le tout**
   - Clique sur **S'inscrire** et hop, c'est fait.

4. **Confirmation**
   - Si tout roule, tu seras redirigé direct vers la page de connexion. Sinon, vérifie que t'as bien tout rempli.

#### **b. Connexion**

1. **Va sur la page de connexion**
   - File sur `http://localhost:3000/login` (ou la version en ligne, encore une fois).

2. **Connecte-toi**
   - **Nom d'utilisateur** ou **Email** : Celui que t'as choisi.
   /!\ En raison d'un bug avec React, j'ai dû modifier quelques paramètres... Du coup, la connexion se fait simplement avec le mail pour le moment. Voilà... Cela dit, dans l'admin il y a bien un nom d'utilisateur qui est généré.
   
   - **Mot de passe** : Le fameux.

3. **Tadam !**
   - Si tout va bien, tu pourras passer commande.

### **4. Utilisation de l’Application**

#### **a. Voir les Offres**

1. **Accéder aux Offres**
   - Direction `http://localhost:3000/offers` pour voir toutes les offres dispo (Solo, Duo, Famille... tu connais).

2. **Détails d'une Offre**
   - Clique sur une offre pour avoir plus d’infos. Prix, description, tout ça quoi.

#### **b. Passer une Commande**

1. **Sélectionner les Offres**
   - Choisis tes offres préférées (Solo, Duo, Famille) et ajoute-les au panier.

2. **Accéder à la Page de Checkout**
   - Va sur `http://localhost:3000/checkout` pour finaliser tout ça.

3. **Remplir le formulaire**
   - Ajoute les offres au panier, choisis les quantités... tu connais la chanson.

4. **Valider la Commande**
   - Clique sur **Passer la commande** et laisse la magie opérer.

5. **Confirmation**
   - Si tout se passe bien, tu recevras une confirmation de commande et tu pourras voir tes tickets.

#### **c. Voir et Télécharger tes Tickets**

1. **Liste de tes Tickets**
   - Tous tes tickets sont sur `http://localhost:3000/tickets`. Tu les retrouves là, tranquille.

2. **Télécharger/Scanner un QR Code**
   - Chaque ticket est lié à un QR code. Tu peux les télécharger ou les scanner directement pour l’événement.

### **5. Utilisation de l'Interface Admin**

#### **a. Accéder à l’Interface Admin**

1. **Ouvrir l’Admin**
   - Sur ton navigateur, direction `http://localhost:8000/admin/`.

2. **Connexion Admin**
   - Tes identifiants admin te donnent accès au Saint Graal : le tableau de bord admin.

#### **b. Gérer les Offres**

1. **Voir les Offres**
   - Dans le menu admin, clique sur **Offers** pour voir tout ce qui est dispo.

2. **Ajouter une Offre**
   - Clique sur **Add Offer** et remplis les infos. Facile.

3. **Modifier une Offre**
   - Choisis une offre et fais les modifs nécessaires.

4. **Supprimer une Offre**
   - Sélectionne l’offre et clique sur supprimer si tu veux faire le ménage.

#### **c. Gérer les Commandes**

1. **Accéder aux Commandes**
   - Clique sur **Orders** dans le menu admin pour voir toutes les commandes passées.

2. **Détails des Commandes**
   - En un clic, tu peux voir tous les détails : les articles commandés, les tickets générés, etc.

3. **Mettre à jour le statut**
   - Passe une commande de "pending" à "completed" d'un simple clic. Magique.

#### **d. Gérer les Tickets**

1. **Accéder aux Tickets**
   - Dans le menu admin, clique sur **Tickets** pour voir tous les tickets.

2. **Détails d’un Ticket**
   - Un clic suffit pour voir les détails et le QR code lié au ticket.

3. **Modifier ou Supprimer un Ticket**
   - Pareil qu'avec les offres : un clic pour modifier ou supprimer.

#### **e. Gérer les Utilisateurs**

1. **Voir les Utilisateurs**
   - Clique sur **Users** dans le menu admin.

2. **Ajouter un Utilisateur**
   - Un nouvel utilisateur à ajouter ? Clique sur **Add User**.

3. **Modifier ou Supprimer un Utilisateur**
   - Besoin de faire du ménage ? C'est par ici.

### **6. Résolution des Problèmes**

#### **a. Problèmes de Migrations**

- **Erreur** : Tu vois des erreurs de migration ? Genre "relation api_offer does not exist".
- **Solution** : Lance un bon vieux `python manage.py migrate` pour t’assurer que tout est bien en place.

#### **b. Problèmes d’Authentification**

- **Erreur** : Impossible de se connecter ou de récupérer un token JWT ?
- **Solution** : Vérifie les identifiants, et assure-toi que les endpoints `/api/token/` et `/api/token/refresh/` marchent.

#### **c. Problèmes avec les Fichiers Statics**

- **Erreur** : Les fichiers statiques ne s’affichent pas correctement.
- **Solution** : Fais un `python manage.py collectstatic` pour les rassembler et vérifie ta config’ dans `settings.py`.

#### **d. Problèmes Frontend**

- **Erreur** : Les offres ne s’affichent pas ? 
- **Solution** : Assure-toi que le frontend est bien connecté à l'API backend et que les tokens JWT sont bien gérés. Un coup d’œil aux logs du navigateur peut t'aider.

### **7. FAQ**

#### **Q1 : Comment réinitialiser la base de données sans tout casser ?**

**Réponse** : Sauvegarde d’abord, et applique des migrations incrémentielles. Pas de suppression brutale du schéma !

#### **Q2 : Comment ajouter de nouvelles offres depuis le frontend ?**

**Réponse** : Utilise l'admin. Pour que ça se fasse côté frontend, il faudrait implémenter des endpoints sécurisés.

#### **Q3 : Pourquoi mes QR codes ne s'affichent-ils pas dans les tickets ?**

**Réponse** : Vérifie la config de `MEDIA_URL` et `MEDIA_ROOT` dans `settings.py`, et assure-toi que les fichiers QR sont bien générés.

#### **Q4 : Que faire si je vois une erreur "relation 'api_offer' does not exist" ?**

**Réponse** : Ta table `api_offer` n'existe pas. Fais un `python manage.py migrate` pour appliquer les migrations. Si ça coince encore, regarde la doc technique.

#### **Q5 : Comment gérer les permissions utilisateurs ?**

**Réponse** : Les groupes et permissions Django sont là pour ça. Les admins ont tout pouvoir via l’interface admin, les utilisateurs standard ont des accès limités.