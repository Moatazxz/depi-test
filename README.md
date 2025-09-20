# Git Basics Guide

This guide covers the most important Git concepts and commands for beginners.

---

## 1. Create Repository
A repository (repo) is a storage space for your project and its version history.

- **On GitHub/GitLab/Bitbucket**: Create a repo from the web interface.
- **Locally**:
  ```bash
  git init
  ```
  This creates a hidden `.git` folder which stores Git history.

---

## 2. Clone Repository
Cloning makes a copy of a remote repository on your machine.

```bash
git clone https://github.com/user/repo.git
```

- Creates a folder with all project files and history.
- Sets the remote connection automatically (usually called `origin`).

---

## 3. Configure Git (User, Email, and Token)
- **Personal Access Token (PAT)** (GitHub example):
  - Go to **Settings → Developer settings → Personal access tokens**.
  - Use the token instead of your password when pushing code:
    ```bash
    git push https://<TOKEN>@github.com/user/repo.git
    ```

- **Set your username and email**:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your@email.com"
  ```

---

## 4. Git Architecture (Workflow Areas)
Git has four main areas:

1. **Working Directory** → where you edit files.
2. **Staging Area** → preparation area before committing.
3. **Local Repository** → where commits are stored on your machine.
4. **Remote Repository** → shared repo on GitHub/GitLab.

**Flow:**
```
Working Dir → git add → Staging → git commit → Local Repo → git push → Remote Repo
```

---

## 5. Key Git Commands
- **Add files to staging**:
  ```bash
  git add <file>
  ```
- **Commit to local repo**:
  ```bash
  git commit -m "Message"
  ```
- **Push to remote repo**:
  ```bash
  git push
  ```
- **Pull changes from remote**:
  ```bash
  git pull
  ```

---

## 6. Commit ID
Every commit has a unique **SHA-1 hash (Commit ID)**.

- Example: `a1b2c3d4`
- Can be used to checkout or reset to a specific commit:
  ```bash
  git checkout a1b2c3d4
  ```

---

## 7. Check Commit History
View commit history:
```bash
git log
```

Useful options:
- `git log --oneline` → compact view.
- `git log --graph --all` → visual branch graph.

---

## 8. Pull Before Push
Always run:
```bash
git pull
```
before `git push`.

This ensures your local repo is up-to-date and prevents conflicts if other developers have pushed changes.

---

## 9. Branches
Branches allow parallel development.

- **List branches**:
  ```bash
  git branch
  ```
- **Create new branch**:
  ```bash
  git branch <BRANCH_NAME>
  ```
- **Switch to branch**:
  ```bash
  git checkout <BRANCH_NAME>
  ```
- **Create + switch (shortcut)**:
  ```bash
  git checkout -b <BRANCH_NAME>
  ```

---

## 10. Merge
Merging combines work from one branch into another.

**Steps:**
1. Go to the target branch (the branch that will receive the changes):
   ```bash
   git checkout main
   ```
2. Merge the source branch:
   ```bash
   git merge <BRANCH_NAME>
   ```

- If no conflicts → merge completes directly.
- If conflicts → Git will ask you to resolve them.

After merging, push the updated branch:
```bash
git push origin main
```

**Clean up old branches:**
```bash
git branch -d <BRANCH_NAME>
```

---

## Best Practices
- Write **meaningful commit messages**.
- Use `.gitignore` to exclude logs, secrets, or build artifacts.
- Commit small changes often instead of big ones.
- Use **Pull Requests (PRs)** for teamwork to enable code reviews.
- Visualize repo history:
  ```bash
  git log --oneline --graph --all
  ```

======
=====

## 1) Merge Conflicts — What They Are & How to Solve

**What:** A merge conflict happens when Git can’t automatically combine changes (usually the same lines edited on two branches, or edit vs delete/rename).  
**How to solve (pattern):**  
1) Run the merge → conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`) appear.  
2) Open files, choose the final content.  
3) `git add <files>` to mark resolved.  
4) `git commit` (finishes the merge).

### Demo A — “Same line” conflict
```bash
# setup
mkdir lab-merge-conflict-a && cd lab-merge-conflict-a
git init -b main
printf "Owner: Team
" > info.txt
git add . && git commit -m "init"

# diverge
git switch -c feature
printf "Owner: Feature
" > info.txt
git commit -am "feature: change owner"

git switch main
printf "Owner: Main
" > info.txt
git commit -am "main: change owner"

# merge → conflict
git merge feature
# open info.txt, decide the final line (e.g. "Owner: Main & Feature")
# then:
git add info.txt
git commit -m "merge: resolve owner line"
```

### Demo B — “Modify vs delete” conflict
```bash
cd .. && mkdir lab-merge-conflict-b && cd lab-merge-conflict-b
git init -b main
echo "data" > data.txt
git add . && git commit -m "init data"

git switch -c feat-edit
echo "feature edit" >> data.txt
git commit -am "feat: edit data"

git switch main
git rm data.txt
git commit -m "main: delete data"

git merge feat-edit   # conflict: modified in one branch, deleted in the other
# option 1: keep deletion
#   git rm data.txt
#   git commit -m "resolve: keep deletion"
# option 2: keep modified file
#   git add data.txt
#   git commit -m "resolve: keep modified"
```

**Key takeaways**
- Conflicts are normal; fix them deliberately.  
- After editing, **always** `git add` to mark resolved before committing.

---

## 2) Merge Types

### a) Fast-forward merge (no merge commit)
**When:** The target branch hasn’t moved since you branched; your branch is a straight line ahead.  
**Result:** `main` pointer just “fast-forwards” to your feature tip. No merge commit.

#### Demo — Fast-forward
```bash
cd .. && mkdir lab-merge-ff && cd lab-merge-ff
git init -b main
echo base > app.txt
git add . && git commit -m "base"

git switch -c feature
echo a >> app.txt; git commit -am "feat: a"
echo b >> app.txt; git commit -am "feat: b"

git switch main
git merge --ff-only feature   # fast-forward
git log --oneline --graph --decorate --all
```

**Diagram**
```
main: A - B - C
              \ x - y   (feature)
fast-forward ⇒ A - B - C - x - y   (main moves forward, no merge commit)
```

### b) Three-way (recursive) merge (creates a merge commit)
**When:** Both branches advanced; you need a real merge.  
**Result:** A merge commit with two parents becomes the new tip of the target branch.

#### Demo — Three-way merge
```bash
cd .. && mkdir lab-merge-3w && cd lab-merge-3w
git init -b main
echo base > f.txt
git add . && git commit -m "base"

git switch -c feature
echo feat1 >> f.txt; git commit -am "F1"
echo feat2 >> f.txt; git commit -am "F2"

git switch main
echo main1 >> f.txt; git commit -am "M1"
echo main2 >> f.txt; git commit -am "M2"

git merge feature     # creates a merge commit (may or may not conflict)
git log --oneline --graph --decorate --all
```

**Key takeaways**
- **Fast-forward**: clean, linear, no extra commit.  
- **Three-way**: preserves true branching history; creates a merge commit.

---

## 3) Rebase (and how it rewrites history)

**What:** “Replay” your feature commits **on top of** another branch, creating **new** commit IDs. Keeps history *linear*.  
**Rule of thumb:** Don’t rebase branches others already pulled (history rewrite). If you must, push with `--force-with-lease`.

### Demo — Rebase feature onto main
```bash
cd .. && mkdir lab-rebase && cd lab-rebase
git init -b main
echo base > f.txt
git add . && git commit -m "base"

git switch -c feature
echo f1 >> f.txt; git commit -am "F1"
echo f2 >> f.txt; git commit -am "F2"

git switch main
echo m1 >> f.txt; git commit -am "M1"
echo m2 >> f.txt; git commit -am "M2"

git switch feature
git rebase main              # resolve if needed, then: git rebase --continue

# after rebase, feature is linear on top of main
git switch main
git merge --ff-only feature  # fast-forward merge
git log --oneline --graph --decorate --all
```

---

## 4) Merge vs Rebase — When to Use Which

- **Merge**
  - ✅ Preserves real branching history
  - ✅ Safe for shared branches (no rewrite)
  - ❌ Log can be “busy”
  - Use when: integrating long-lived branches, shared work

- **Rebase**
  - ✅ Linear, clean history
  - ❌ Rewrites commits (new SHAs)
  - Use when: cleaning up feature history before merging, personal/short-lived branches  
  - If already pushed: `git push --force-with-lease`

---

## 5) Workflows

### a) Release flow (lightweight)
- `main` = production  
- Create `release/x.y` from `main` → stabilize (only bug fixes)  
- Merge `release/x.y` back into `main` (tag release) and into `develop`/active line if you have one  
- Create `hotfix/x.y.z` from `main` for urgent fixes → merge back

#### Demo (minimal)
```bash
cd .. && mkdir lab-release-flow && cd lab-release-flow
git init -b main
echo v1 > app.txt; git add .; git commit -m "v1"

git switch -c release/1.1
echo "fix-rc" >> app.txt; git commit -am "release: fix"

git switch main
git merge --no-ff release/1.1 -m "release 1.1"
git tag v1.1
```

### b) Git Flow (classic)
- `main`: production  
- `develop`: integration  
- `feature/*` branches off `develop`, merges back to `develop`  
- `release/*` from `develop` to stabilize, then merge to `main` and back to `develop`  
- `hotfix/*` from `main`, merges back to both

#### Demo (sketch)
```bash
cd .. && mkdir lab-gitflow && cd lab-gitflow
git init -b main
git switch -c develop
echo dev > app.txt; git add .; git commit -m "seed develop"

git switch -c feature/login
echo login >> app.txt; git commit -am "feature: login"
git switch develop
git merge --no-ff feature/login -m "merge: login"

git switch -c release/1.0
echo "release notes" >> notes.md; git add .; git commit -m "prep release"
git switch main
git merge --no-ff release/1.0 -m "release 1.0"
git tag v1.0
git switch develop
git merge --no-ff release/1.0 -m "back-merge release"
```

---

## 6) Pull Requests (PRs) & Protecting Branches

**PR:** Propose changes; discuss, review, run CI, then merge.  
**Prevent direct merges:** Protect the branch (e.g., `main`) to **require PRs**, **approvals**, and **passing checks**.  
**Reviewers/checks:** Add reviewers; connect CI (e.g., GitHub Actions); require green status before merge.

> On personal accounts: collaborators on **private** repos have write access; still **enforce PR + checks** via branch protection to block direct pushes/merges.

---

## Session 3 Details

### 1) Fork
**What:** Your own copy of someone else’s repo under your account. You can experiment freely, then open a PR back.

**Post‑fork best practice**
```bash
# after forking on GitHub and cloning your fork:
git remote -v                  # origin points to YOUR fork
git remote add upstream https://github.com/ORIGINAL/REPO.git
git fetch upstream
git switch main
git merge upstream/main        # or: git rebase upstream/main
```

### 2) Contributions & Roles (high level)
- **Personal repo:** add “collaborators.” Private personal repos give collaborators **write** access (no read‑only granularity).  
- **Organization repos:** finer roles: **read, triage, write, maintain, admin**; best practice is to grant via **teams**.  
- Protect important branches to **require PRs** and **checks**.

### 3) `.gitignore` — Protect secrets & junk
**What:** List patterns of files to **ignore** (untracked) so they don’t get committed (logs, build outputs, env files).

#### Demo
```bash
cd .. && mkdir lab-ignore && cd lab-ignore
git init -b main
mkdir logs build
echo "secret=123" > .env
echo "debug" > logs/app.log
echo "bin" > build/out.bin

cat > .gitignore <<'EOF'
# env & secrets
.env
# builds & logs
build/
logs/
*.log
EOF

git add .gitignore && git commit -m "add .gitignore"
git status                 # ignored files won't appear

# if something is already tracked and you want to untrack it:
git rm -r --cached build/
git commit -m "stop tracking build/"
```

### 4) Git Squash — Clean many commits into one

#### Demo A — `rebase -i` (before merge)
```bash
cd .. && mkdir lab-squash-a && cd lab-squash-a
git init -b main
echo base > f.txt; git add .; git commit -m "base"
git switch -c feature
echo 1 >> f.txt; git commit -am "step1"
echo 2 >> f.txt; git commit -am "step2"

git rebase -i HEAD~2
# in editor: keep first "pick", change second to "squash"
# write one final message

git switch main
git merge --ff-only feature
```

#### Demo B — Squash on merge (no history rewrite)
```bash
cd .. && mkdir lab-squash-b && cd lab-squash-b
git init -b main
echo base > f.txt; git add .; git commit -m "base"
git switch -c feature
echo a >> f.txt; git commit -am "a"
echo b >> f.txt; git commit -am "b"
git switch main
git merge --squash feature
git commit -m "feature squashed into one"
```

> If you rebased/squashed **after pushing**, update remote with:  
> `git push --force-with-lease`.

### 5) Git Stash — Save work temporarily (tracked + optional untracked)

**Default:** Stashes **tracked** changes (staged + unstaged).  
**Include untracked:** `-u`, **include ignored:** `-a`.  
**Restore:** `apply` (keep stash) or `pop` (apply & remove).

#### Demo
```bash
cd .. && mkdir lab-stash && cd lab-stash
git init -b main
echo start > notes.txt
git add . && git commit -m "init"

echo "edit" >> notes.txt
touch scratch.md           # untracked
git stash push -u -m "WIP tracked+untracked"
git switch -c quick-fix
git stash pop              # bring WIP here
```
