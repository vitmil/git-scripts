#!/usr/bin/env bash
#
# 🧾 Script: clean-and-replace-file.sh
# 🔧 Scopo: Rimuovere ogni traccia di un file dal repository Git e sostituirlo con una nuova versione pulita
# 📦 Basato sulla guida "Pulizia completa e sostituzione di un file in un repository GitHub"
#

set -e

# === COLORI ===
function info()  { echo -e "\e[34m[INFO]\e[0m $1"; }
function warn()  { echo -e "\e[33m[ATTENZIONE]\e[0m $1"; }
function error() { echo -e "\e[31m[ERRORE]\e[0m $1"; exit 1; }

# === USO ===
if [ -z "$1" ]; then
    echo "Uso: $0 <file_da_pulire>"
    echo "Esempio: $0 setup-global-gitignore.sh"
    exit 1
fi

TARGET_FILE="$1"
REPO_PATH="$(pwd)"
BRANCH_NAME="main"
REMOTE_NAME="origin"

echo "------------------------------------------------------------"
echo "🧹 Pulizia completa del file: $TARGET_FILE"
echo "📂 Repository: $REPO_PATH"
echo "------------------------------------------------------------"

# 1️⃣ Verifica repository Git
if [ ! -d "$REPO_PATH/.git" ]; then
    warn "Nessun repository Git trovato in $REPO_PATH"
    read -p "Vuoi inizializzarlo qui? (s/n): " ans
    if [[ "$ans" =~ ^[Ss]$ ]]; then
        git init || error "Impossibile inizializzare il repository."
    else
        error "Interrotto dall’utente."
    fi
fi

cd "$REPO_PATH"

# 2️⃣ Determina automaticamente il remote URL
REMOTE_URL_DEF="$(git config --get remote.${REMOTE_NAME}.url || true)"

if [ -z "$REMOTE_URL_DEF" ]; then
    warn "Nessun remote '${REMOTE_NAME}' configurato nel repository."
    read -p "Inserisci l’URL del remote GitHub (es: git@github.com:utente/repo.git): " REMOTE_URL_DEF
    [ -z "$REMOTE_URL_DEF" ] && error "Remote URL non specificato. Operazione annullata."
    git remote add "$REMOTE_NAME" "$REMOTE_URL_DEF"
else
    info "Remote trovato: $REMOTE_URL_DEF"
fi

# 3️⃣ Verifica presenza file
if [ ! -f "$TARGET_FILE" ]; then
    warn "Il file '$TARGET_FILE' non esiste nella directory corrente."
    read -p "Vuoi procedere comunque (magari lo aggiungerai dopo)? (s/n): " ans
    [[ "$ans" =~ ^[Ss]$ ]] || error "File mancante. Operazione annullata."
fi

# 4️⃣ Verifica o installa git-filter-repo
if ! command -v git-filter-repo &> /dev/null; then
    info "Installazione di git-filter-repo..."
    sudo apt update -y && sudo apt install -y git-filter-repo || error "Installazione fallita."
fi

# 5️⃣ Rimuove tutte le versioni precedenti del file dalla cronologia
info "Rimozione di tutte le versioni precedenti di '$TARGET_FILE'..."
git filter-repo --path "$TARGET_FILE" --invert-paths || error "Errore durante la pulizia del file."

# 6️⃣ Aggiunge la nuova versione del file (se presente)
if [ -f "$TARGET_FILE" ]; then
    git add "$TARGET_FILE"
    git commit -m "Aggiunta nuova versione pulita di $TARGET_FILE" || warn "Nessuna modifica da committare."
else
    warn "File non trovato dopo la pulizia. Salta commit."
fi

# 7️⃣ Imposta branch e forza il push
info "Impostazione del branch e push forzato..."
git branch -M "$BRANCH_NAME"
git push "$REMOTE_NAME" "$BRANCH_NAME" --force || error "Push forzato fallito."

# ✅ RISULTATO FINALE
echo "------------------------------------------------------------"
echo "✅ Operazione completata con successo!"
echo "📁 File sostituito: $TARGET_FILE"
echo "📦 Repository aggiornato su: $REMOTE_URL_DEF"
echo "------------------------------------------------------------"
echo ""
echo "⚠️  Nota: Chiunque abbia clonato il repo dovrà riallinearsi con:"
echo "    git fetch --all && git reset --hard origin/$BRANCH_NAME"
