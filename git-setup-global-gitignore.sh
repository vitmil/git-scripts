#!/usr/bin/env bash
#
# Script per configurare un .gitignore globale su Ubuntu
# ----------------------------------------------

set -e

GITIGNORE_PATH="$HOME/.gitignore_global"

echo "Creazione del file globale Git ignore in: $GITIGNORE_PATH ..."
cat > "$GITIGNORE_PATH" <<'EOF'
# ============================================
# SISTEMA OPERATIVO (Linux / Ubuntu)
# ============================================
*~
*.swp
*.swo
*.tmp
*.bak
*.orig
.DS_Store
.Trash*
.cache/
.local/
.config/
Thumbs.db
ehthumbs.db
lost+found/
.nfs*

# ============================================
# LOG, BACKUP E TEMPORANEI
# ============================================
*.log
*.pid
*.seed
*.pid.lock
*.out
*.err
*.retry
*.lock
*.gz
*.zip
*.tar
*.tar.gz
*.7z
*.bak
*.old
*.backup
*.save
*.temp
*.orig
*.copy
*.rsync
*.dump

# ============================================
# EDITOR E IDE
# ============================================
.vscode/
.history/
*.code-workspace
.idea/
*.iml
*.swp
*.swo
.session.vim
.netrwhist
*~
\#*\#
.\#*
.nanorc

# ============================================
# PYTHON
# ============================================
__pycache__/
*.py[cod]
*.pyo
*.pyd
*.pytest_cache/
.pytest_cache/
.tox/
.venv/
env/
venv/
ENV/
Pipfile.lock
poetry.lock

# ============================================
# NODE / JAVASCRIPT
# ============================================
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
package-lock.json

# ============================================
# TERRAFORM
# ============================================
.terraform/
.terraform.lock.hcl
terraform.tfstate
terraform.tfstate.*
crash.log
override.tf
override.tf.json
*_override.tf
*_override.tf.json
#terraform.tfvars
#terraform.tfvars.json
#*.auto.tfvars
*.tfplan
*.backup
*.tfbackend

# ============================================
# KUBERNETES / HELM / EKS
# ============================================
.kube/
.kubeconfig
kubeconfig*
helm-release.yaml
helm-values.yaml
charts/
templates/*.bak
manifests/tmp/
tmp/
*.rke2.yaml
*.eksctl.yaml
*.token
*.secret
*.config
secrets.yaml
secrets.yml
secret.yaml
secret.yml
clusterrolebinding.yaml
kustomization.yaml.backup
kustomization.yaml.tmp

# ============================================
# AWS / CLOUD
# ============================================
.aws/
.aws/*
*.pem
*.key
*.csr
*.crt
*.json
*.csv
credentials
credentials.*
config
config.*

# ============================================
# GITHUB ACTIONS / CI-CD
# ============================================
.github/workflows/*.bak
.github/workflows/*.tmp
.github/secrets.yml
.github/secrets.yaml
*.env.local
*.env.example

# ============================================
# FILE PERSONALI O SENSIBILI (case-insensitive)
# ============================================

# Password e segreti (in qualsiasi posizione e sottocartella)
**/*[Pp][Aa][Ss][Ss][Ww][Oo][Rr][Dd]*
**/*[Ss][Ee][Cc][Rr][Ee][Tt][Ss]?*

# File di informazioni personali (qualsiasi estensione)
**/*[Vv][Ii][Mm][Ii]*.[TtMm][XxDd][TtMmDd]*
**/*[Vv][Ii][Nn][Ff][Oo]*.[TtMm][XxDd][TtMmDd]*

bkp/

# Tutti i files che hanno "vimi" nel nome (case-insensitive)
*vimi*

# ============================================
# NOTE
# ============================================
# - [A-Z] e [a-z] sostituiti con [Aa] per essere case-insensitive
# - **/ garantisce che vengano ignorati anche in sottocartelle
# - * prima e dopo i nomi cattura prefissi e suffissi (es. my_password.txt)
# - il ? dopo [Ss] in [Ss][Ee][Cc][Rr][Ee][Tt][Ss]? rende la "s" finale opzionale

# ============================================
# CONFIGURAZIONI LOCALI
# ============================================
.env
.env.*
.envrc
local.settings.json
config.local.*
settings.local.*
credentials.json
credentials.yml
*.vault.yml
*.vault.json

# ============================================
# CARTELLE PERSONALI
# ============================================
/Documents/
/Downloads/
/Music/
/Pictures/
/Videos/
/Desktop/
/tmp/
/mnt/
/media/
/run/

# ============================================
# DATABASE / CACHE
# ============================================
*.db
*.sqlite
*.sqlite3
*.db-journal
*.ldb
*.mdb
*.sql
*.dump

# ============================================
# FILE DI SISTEMA / MISC
# ============================================
*.bak
*.tmp
*.swp
*.swo
*.swn
*.un~
*.~
*.lock
*.retry
EOF

# Imposta la configurazione globale
echo "Configurazione di Git per usare il file globale..."
git config --global core.excludesfile "$GITIGNORE_PATH"

echo "✅ Configurazione completata!"
echo "Git ora utilizza il file globale: $GITIGNORE_PATH"
echo
echo "Per verificare:"
echo "  git config --global --get core.excludesfile"
echo
echo "Puoi modificare il file in qualsiasi momento con:"
echo "  nano $GITIGNORE_PATH"
