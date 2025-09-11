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
