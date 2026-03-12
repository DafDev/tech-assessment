# Pourquoi cette application n'est pas prête pour la production

Ce document liste les lacunes actuelles de l'application, tant au niveau des fonctionnalités manquantes qu'au niveau de l'architecture technique.

---

## 1. Fonctionnalités manquantes

### 1.1 Authentification et gestion des accès

Il n'existe actuellement aucun système de connexion fonctionnel côté catalogue public. Toute personne accédant à l'URL peut consulter les formations sans s'identifier. Une gestion des rôles, des sessions utilisateur sécurisées et un flux de connexion/déconnexion complet sont indispensables avant toute mise en production.

### 1.2 Ajout et gestion des formations

Il n'est pas possible d'ajouter, modifier ou supprimer une formation depuis l'interface. Un administrateur doit aujourd'hui passer directement par la base de données. Une interface CRUD complète pour les formations — accessible uniquement aux utilisateurs autorisés — est une priorité.

### 1.3 Inscription des participants à une formation

Un participant ne peut pas s'inscrire lui-même à une session depuis le front-end. La logique métier d'inscription existe dans le domaine (`Session.AddAttendant`), mais aucune interface ni aucun endpoint ne l'expose aux utilisateurs. Cette fonctionnalité est au cœur du produit et son absence rend l'application inutilisable en conditions réelles.

---

## 2. Problèmes d'architecture

### 2.1 Absence de couche Application

L'architecture actuelle fait communiquer directement la couche **Web** avec la couche **Infra** via l'interface `IManageSessions`. Il manque une couche **Application** (parfois appelée *Use Cases* ou *Services applicatifs*) qui devrait :

- orchestrer les cas d'usage métier (s'inscrire à une session, créer une formation, etc.) ;
- isoler le domaine de toute dépendance à l'infrastructure ;
- être le seul point d'entrée vers l'`IManageSessions` et les autres ports sortants.

Sans cette couche, la logique applicative risque de se disperser entre le contrôleur Web et le domaine, rendant l'ensemble difficile à tester et à faire évoluer.

```
Avant (actuel)                Après (cible)
──────────────────────        ──────────────────────────────
Web  →  Infra                 Web  →  Application  →  Infra
         ↑                                ↑
       Domain                           Domain
```

### 2.2 Absence d'API pour la manipulation des données

Aucun endpoint n'existe pour créer, modifier ou supprimer des ressources (formations, sessions, participants). Le seul endpoint disponible (`GET /api/sessions`) est en lecture seule. Une API RESTful — ou équivalente — couvrant l'ensemble des opérations nécessaires doit être conçue et implémentée, idéalement dans la couche Application mentionnée ci-dessus.

### 2.3 Couplage direct entre `SessionContext` et le projet Web

Le `DbContext` est enregistré directement dans `Program.cs` du projet Web. Dans une architecture correctement découplée, l'infrastructure (accès à la base de données, chaînes de connexion) ne devrait pas être configurée dans le point d'entrée du projet de présentation. Cette initialisation devrait être déléguée à la couche Infra ou Application au travers d'une méthode d'extension dédiée.

---

## Résumé

| Problème | Priorité |
|---|---|
| Système de connexion | 🔴 Critique |
| Inscription à une formation | 🔴 Critique |
| CRUD formations (interface admin) | 🟠 Haute |
| Couche Application | 🟠 Haute |
| API de manipulation des données | 🟠 Haute |
| Découplage de la configuration Infra | 🟡 Moyenne |
