# Security Audit App

Application Flutter de sécurité réseau avec authentification, tableau de bord et simulations d’audit.

## Fonctionnalités

- Authentification sécurisée avec validation du formulaire
- Interface de connexion moderne en thème sombre
- Tableau de bord avec indicateurs réseau
- Lancement de scans de sécurité
- Recommandations de hardening et sécurité

## Prérequis

- Flutter SDK 3.3+
- Dart SDK compatible
- Android Studio / VS Code

## Démarrage

```bash
flutter pub get
flutter run
```

## Identifiants de démonstration

- Email : admin@security.local
- Mot de passe : motdepasse123

## Structure du projet

- `lib/main.dart` : point d’entrée de l’application
- `lib/pages/login_page.dart` : écran de connexion
- `lib/pages/dashboard_page.dart` : tableau de bord principal
- `lib/services/auth_service.dart` : logique d’authentification
- `lib/theme/app_theme.dart` : thème visuel de l’application

## Objectifs de sécurité

- Validation des entrées utilisateur
- Utilisation de thèmes cohérents et sécurisés
- Protection d’accès au tableau de bord par authentification
- Structure modulaire pour évoluer vers une vraie API de sécurité


