**ATTENZIONE**: crearsi una copia di backup del file sul quale vogliamo ripulire la history.
Il file verrà elimianto dal file system locale


**procedura completa e aggiornata** per eliminare **tutta la history** del file `setup-global-gitignore.sh` dal tuo repository
👉 [`https://github.com/vitmil/git_scripts`](https://github.com/vitmil/git_scripts).

---

## 🧹 PROCEDURA COMPLETA — RIMOZIONE FILE DALLA HISTORY

### 1️⃣ Posizionati nella cartella del tuo repo locale

```bash
cd /usr/local/bin/git_scripts
```

---

### 2️⃣ Installa `git-filter-repo` (se non presente)

```bash
sudo apt install git-filter-repo
```

oppure, se non disponibile:

```bash
pip install git-filter-repo
```

---

### 3️⃣ Rimuovi **tutta la cronologia** del file

Esegui nella **radice del repo**:

```bash
git filter-repo --path setup-global-gitignore.sh --invert-paths
```

✅ Questo comando:

* Cancella *ogni versione passata* del file `setup-global-gitignore.sh`
* Mantiene intatto tutto il resto del repository

---

### 4️⃣ Pulisci i riferimenti interni (opzionale ma consigliato)

```bash
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

---

### 5️⃣ Configura (o ricontrolla) il remoto GitHub

Verifica se è già impostato:

```bash
git remote -v
```

Se non vedi nulla, aggiungi il remoto del tuo repository GitHub:

```bash
git remote add origin https://github.com/vitmil/git_scripts.git
```

Controlla che sia registrato correttamente:

```bash
git remote -v
```

Dovresti ottenere:

```
origin  https://github.com/vitmil/git_scripts.git (fetch)
origin  https://github.com/vitmil/git_scripts.git (push)
```

---

### 6️⃣ Sovrascrivi la history remota (⚠️ operazione distruttiva)

Esegui:

```bash
git push origin --force --all
git push origin --force --tags
```

🔴 Attenzione:
Questo **riscrive tutta la cronologia remota**, quindi chiunque usi quel repo dovrà fare un nuovo clone:

```bash
git clone https://github.com/vitmil/git_scripts.git
```

---

### 7️⃣ (Facoltativo) Verifica che il file non esista più nella history

```bash
git log -- setup-global-gitignore.sh
```

👉 Non deve restituire alcun risultato.

---

### ✅ RISULTATO FINALE

* Il file `setup-global-gitignore.sh` **non esiste più** nel passato né nel presente del repo.
* Tutta la cronologia è “ripulita”.
* Il tuo GitHub è aggiornato e coerente con la nuova versione pulita.

---

Vuoi che ti prepari anche uno **script Bash automatico** (`clean_file_history.sh`) che esegue tutta questa sequenza in un solo comando (chiedendoti solo il nome del file e l’URL del repo)?

