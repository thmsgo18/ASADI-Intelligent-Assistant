# ASADI - Assistant Éducatif Intelligent Propulsé par l'IA

**[English version](README.md)**

> **Projet de Fin de Licence** - Informatique
> 
> Ce projet constitue un projet de fin d'études de Licence en Informatique, démontrant l'intégration de technologies d'IA modernes avec des frameworks de développement web traditionnels.

## Table des matières

- [Vue d'ensemble](#vue-densemble)
- [Fonctionnalités principales](#fonctionnalités-principales)
- [Architecture](#architecture)
- [Technologies](#technologies)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Structure du projet](#structure-du-projet)
- [Documentation](#documentation)
- [Gestion de version](#gestion-de-version)
- [Contribution](#contribution)

## Vue d'ensemble

**ASADI** (AI-Assisted System for Document Intelligence) est une plateforme éducative intelligente construite avec Django qui exploite les technologies d'IA avancées pour fournir une assistance contextuelle aux étudiants et aux enseignants. Le système implémente une architecture **RAG (Retrieval-Augmented Generation)** utilisant **ChromaDB** comme base de données vectorielle et s'intègre avec des **modèles de langage de grande taille (LLM)** modernes pour délivrer des réponses précises et contextuelles.

La plateforme permet aux utilisateurs d'interagir avec des documents éducatifs via des requêtes en langage naturel, tout en offrant des fonctionnalités avancées telles que la génération de quiz, l'apprentissage basé sur des scénarios et la gestion d'espaces de travail pour organiser le contenu éducatif.

## Fonctionnalités principales

### Interface conversationnelle alimentée par l'IA
- **Système RAG** : Combine la recherche sémantique avec l'IA générative pour des réponses précises
- **Base de données vectorielle** : Utilise ChromaDB pour le stockage et la recherche efficace des embeddings de documents
- **Intégration LLM** : Alimenté par les modèles GPT d'OpenAI via LlamaIndex
- **Filtrage contextuel** : Filtrage basé sur les espaces de travail pour fournir des réponses contextuelles pertinentes

### Gestion des documents
- Téléchargement et organisation de documents éducatifs (PDF, Word, etc.)
- Découpage automatique des documents et vectorisation
- Organisation multi-espaces de travail pour différents cours ou sujets
- Versionnage et suivi des documents

### Historique des prompts et conversations
- Sauvegarde et gestion des fils de conversation
- Révision des interactions passées et de leur contexte
- Partage de prompts entre utilisateurs
- Export de l'historique des conversations

### Génération de quiz et évaluation
- Création de quiz alimentée par l'IA à partir du contenu des documents
- Support de plusieurs types de questions
- Notation automatique et feedback
- Suivi de la progression et analyses de performance

### Apprentissage basé sur des scénarios
- Création de scénarios d'apprentissage interactifs
- Séquences guidées de questions-réponses
- Suivi de la progression des étudiants
- Système de feedback et d'évaluation

### Gestion des utilisateurs
- Contrôle d'accès basé sur les rôles (Étudiants, Enseignants, Administrateurs)
- Backend d'authentification utilisateur personnalisé
- Suivi de l'activité des utilisateurs
- Gestion des profils

### Organisation par espaces de travail
- Création d'espaces de travail dédiés pour différentes matières
- Association de documents avec des espaces de travail spécifiques
- Filtrage des réponses de l'IA basé sur le contexte de l'espace de travail
- Partage collaboratif des espaces de travail

## Architecture

ASADI suit une architecture moderne **Modèle-Vue-Template (MVT)** avec des composants IA supplémentaires :

```
┌─────────────────┐
│Interface Utilisateur│
│   (Templates)   │
└────────┬────────┘
         │
┌────────▼────────┐
│  Vues Django    │
│   & URLs        │
└────────┬────────┘
         │
    ┌────┴────┬──────────────┬──────────────┐
    │         │              │              │
┌───▼────┐ ┌─▼──────┐ ┌────▼─────┐ ┌─────▼──────┐
│ Models │ │ Moteur │ │ ChromaDB │ │ LLM (GPT)  │
│        │ │  RAG   │ │(Vectoriel)│ │ LlamaIndex │
└────────┘ └────────┘ └──────────┘ └────────────┘
```

### Pipeline RAG
1. **Ingestion de documents** : Les documents sont téléchargés et traités
2. **Découpage** : Les documents sont divisés en chunks sémantiques
3. **Embedding** : Les chunks sont convertis en vecteurs d'embeddings avec Sentence Transformers
4. **Stockage** : Les embeddings sont stockés dans ChromaDB
5. **Traitement des requêtes** : Les requêtes utilisateur sont converties en embeddings et comparées aux vecteurs stockés
6. **Récupération de contexte** : Les chunks pertinents sont récupérés par similarité
7. **Génération de réponse** : Le LLM génère des réponses contextuelles en utilisant les chunks récupérés

## Technologies

### Backend
- **Django 5.2** - Framework web
- **Python 3.8+** - Langage de programmation
- **SQLite** - Base de données relationnelle (développement)
- **ChromaDB** - Base de données vectorielle pour les embeddings

### IA & Apprentissage automatique
- **LlamaIndex** - Framework d'orchestration LLM
- **OpenAI GPT** - Modèle de langage de grande taille
- **Sentence Transformers** - Modèles d'embedding de texte
- **all-mpnet-base-v2** - Modèle d'embedding
- **LangChain** - Framework d'application LLM

### Frontend
- **HTML5 / CSS3** - Balisage et stylisation
- **JavaScript** - Interactivité côté client
- **Bootstrap** - Framework de design responsive

### Outils supplémentaires
- **BeautifulSoup4** - Parsing HTML
- **NLTK** - Traitement du langage naturel
- **httpx** - Client HTTP asynchrone

## Installation

### Prérequis
- Python 3.8 ou supérieur
- pip (gestionnaire de paquets Python)
- Git
- Outil d'environnement virtuel (venv ou virtualenv)

### Instructions d'installation

1. **Cloner le dépôt**
```bash
git clone https://github.com/thmsgo18/asadi.git
cd asadi
```

2. **Créer et activer un environnement virtuel**
```bash
# Sur macOS/Linux
python3 -m venv venv
source venv/bin/activate

# Sur Windows
python -m venv venv
venv\Scripts\activate
```

3. **Installer les dépendances**
```bash
pip install -r requirements.txt
```

4. **Configurer les variables d'environnement**
```bash
# Créer un fichier .env à la racine du projet
cp .env.example .env
# Éditer .env avec votre configuration (clés API, paramètres de base de données, etc.)
```

5. **Appliquer les migrations de base de données**
```bash
python manage.py makemigrations
python manage.py migrate
```

6. **Créer un superutilisateur (admin)**
```bash
python manage.py createsuperuser
```

7. **Collecter les fichiers statiques**
```bash
python manage.py collectstatic
```

8. **Lancer le serveur de développement**
```bash
python manage.py runserver
```

L'application sera disponible à l'adresse `http://127.0.0.1:8000/`

### Configuration de ChromaDB

La base de données vectorielle sera automatiquement initialisée lors du premier téléchargement de document. La base de données est stockée dans le répertoire `chroma_db/`.

## Utilisation

### Pour les étudiants
1. **S'inscrire/Se connecter** à votre compte
2. **Parcourir les espaces de travail disponibles** pour accéder aux supports de cours
3. **Poser des questions** via l'interface de prompt
4. **Passer des quiz** générés à partir du contenu des cours
5. **Compléter des scénarios** pour un apprentissage guidé

### Pour les enseignants
1. **Créer des espaces de travail** pour vos cours
2. **Télécharger des documents** (notes de cours, PDFs, etc.)
3. **Générer des quiz** automatiquement à partir du contenu
4. **Créer des scénarios** pour l'apprentissage interactif
5. **Suivre la progression** et les performances des étudiants

### Pour les administrateurs
1. **Gérer les utilisateurs** et les permissions
2. **Configurer les espaces de travail** et les documents
3. **Surveiller l'utilisation** et les performances du système
4. **Accéder au panel d'administration** à `/admin`

## Structure du projet

```
ASADI/
├── ASADI/                  # Configuration Django principale
│   ├── settings.py         # Paramètres du projet
│   ├── urls.py             # Routage des URLs
│   ├── views.py            # Vues globales
│   └── static/             # Fichiers statiques (CSS, JS)
├── documents/              # Application de gestion des documents
│   ├── models.py           # Modèles de documents
│   ├── views.py            # Vues des documents
│   └── utils.py            # Utilitaires pour les documents
├── prompts/                # Gestion des conversations
│   ├── models.py           # Modèles Prompt/Question/Réponse
│   └── views.py            # Vues de l'interface de chat
├── quiz/                   # Gestion des quiz
│   ├── models.py           # Modèles de quiz
│   ├── views.py            # Vues des quiz
│   └── questions/          # Templates de questions
├── scenario/               # Apprentissage basé sur des scénarios
│   ├── models.py           # Modèles de scénarios
│   └── views.py            # Vues des scénarios
├── utilisateurs/           # Gestion des utilisateurs
│   ├── models.py           # Modèle utilisateur personnalisé
│   ├── backends.py         # Backend d'authentification
│   └── views.py            # Vues utilisateur
├── workspace/              # Gestion des espaces de travail
│   ├── models.py           # Modèles d'espaces de travail
│   └── views.py            # Vues des espaces de travail
├── src/                    # Fonctionnalités IA/RAG principales
│   ├── api.py              # Intégration API LLM
│   ├── reponse.py          # Génération de réponses
│   ├── ingererDonnee.py    # Ingestion de documents
│   ├── split.py            # Découpage de documents
│   └── extractions.py      # Utilitaires d'extraction de données
├── chroma_db/              # Stockage de la base de données vectorielle
├── documentation/          # Documentation du projet
│   ├── Cahier des charges.pdf
│   ├── Manuel d'utilisation.pdf
│   ├── Manuel d'installation.pdf
│   ├── Conception détaillée.pdf
│   ├── Rapport de tests.pdf
│   └── Rapport final.pdf
├── media/                  # Fichiers téléchargés par les utilisateurs
├── manage.py               # Script de gestion Django
└── requirements.txt        # Dépendances Python
```

## Documentation

Une documentation complète est disponible dans le répertoire `documentation/` :

- **Cahier des charges.pdf** - Spécifications et exigences du projet
- **Manuel d'utilisation.pdf** - Manuel utilisateur
- **Manuel d'installation.pdf** - Guide d'installation
- **Conception détaillée.pdf** - Documentation de conception détaillée
- **Rapport de tests.pdf** - Rapport de tests
- **Rapport final.pdf** - Rapport final du projet
- **Technique.pdf** - Documentation technique
- **Cahier de recette.pdf** - Documentation de recette

## Gestion de version

Ce projet utilise un double système de gestion de version :
- **Git/GitHub** - Gestion de version principale ([github.com/thmsgo18/asadi](https://github.com/thmsgo18/asadi))
- **SVN** - Gestion de version historique pour la compatibilité institutionnelle

## Auteurs

- [Thomas Gourmelen](https://github.com/thmsgo18)
- [Ali Traore](https://github.com/Taliii7)
- [Valentin Ponnoussamy](https://github.com/Yvngval)
- [Malik Djaffer Abdel](https://github.com/malik439)

---

**Pour plus d'informations, veuillez consulter la documentation complète dans le répertoire `documentation/`.**
