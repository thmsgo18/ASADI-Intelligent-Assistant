#!/bin/bash
# Script pour synchroniser entre SVN et Git

# Couleurs pour les messages
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[ATTENTION]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERREUR]${NC} $1"
}

# Vérifier les arguments
if [ "$#" -lt 1 ]; then
    print_error "Usage: $0 [svn-to-git|git-to-svn|status]"
    exit 1
fi

# Obtenir le répertoire actuel
CURRENT_DIR=$(pwd)

# Vérifier si nous sommes dans un dépôt SVN
if [ ! -d ".svn" ]; then
    print_error "Ce n'est pas un dépôt SVN. Exécutez ce script depuis la racine de votre projet ASADI."
    exit 1
fi

# Vérifier si nous sommes dans un dépôt Git
if [ ! -d ".git" ]; then
    print_error "Ce n'est pas un dépôt Git. Exécutez ce script depuis la racine de votre projet ASADI."
    exit 1
fi

# Fonction pour synchroniser de SVN vers Git
sync_svn_to_git() {
    print_message "Synchronisation de SVN vers Git..."
    
    # Mise à jour SVN
    print_message "Mise à jour SVN..."
    svn update
    
    # Vérifier si des modifications sont en attente dans SVN
    SVN_STATUS=$(svn status | grep -v "^?" | wc -l)
    if [ "$SVN_STATUS" -gt 0 ]; then
        print_warning "Des modifications non committées sont présentes dans SVN. Veuillez d'abord les committer."
        svn status
        exit 1
    fi
    
    # Ajouter tous les fichiers à Git
    print_message "Ajout des fichiers à Git..."
    git add .
    
    # Vérifier s'il y a des modifications à committer
    GIT_STATUS=$(git status --porcelain | wc -l)
    if [ "$GIT_STATUS" -eq 0 ]; then
        print_message "Aucune modification à synchroniser."
        exit 0
    fi
    
    # Committer dans Git
    print_message "Commit dans Git..."
    git commit -m "Synchronisation depuis SVN - $(date)"
    
    # Pousser vers GitHub
    print_message "Push vers GitHub..."
    git push
    
    print_message "Synchronisation SVN vers Git terminée avec succès!"
}

# Fonction pour synchroniser de Git vers SVN
sync_git_to_svn() {
    print_message "Synchronisation de Git vers SVN..."
    
    # Mise à jour Git
    print_message "Mise à jour Git..."
    git pull
    
    # Vérifier si des modifications sont en attente dans Git
    GIT_STATUS=$(git status --porcelain | wc -l)
    if [ "$GIT_STATUS" -gt 0 ]; then
        print_warning "Des modifications non committées sont présentes dans Git. Veuillez d'abord les committer."
        git status
        exit 1
    fi
    
    # Mise à jour SVN
    print_message "Mise à jour SVN..."
    svn update
    
    # Ajouter tous les fichiers à SVN (sauf ceux ignorés)
    print_message "Ajout des fichiers à SVN..."
    svn status | grep "^?" | awk '{print $2}' | xargs -I{} svn add {} --parents
    
    # Vérifier s'il y a des modifications à committer
    SVN_STATUS=$(svn status | grep -v "^?" | wc -l)
    if [ "$SVN_STATUS" -eq 0 ]; then
        print_message "Aucune modification à synchroniser."
        exit 0
    fi
    
    # Committer dans SVN
    print_message "Commit dans SVN..."
    svn commit -m "Synchronisation depuis Git - $(date)"
    
    print_message "Synchronisation Git vers SVN terminée avec succès!"
}

# Fonction pour afficher le statut des deux dépôts
show_status() {
    print_message "Statut SVN:"
    svn status
    
    echo ""
    print_message "Statut Git:"
    git status
}

# Exécuter la commande demandée
case "$1" in
    svn-to-git)
        sync_svn_to_git
        ;;
    git-to-svn)
        sync_git_to_svn
        ;;
    status)
        show_status
        ;;
    *)
        print_error "Commande inconnue: $1"
        print_error "Usage: $0 [svn-to-git|git-to-svn|status]"
        exit 1
        ;;
esac

exit 0
