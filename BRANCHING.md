# Branching Strategy & Release Process

This document outlines the branching strategy, versioning, and release process for Meal Planner.

## Table of Contents
- [Branching Model](#branching-model)
- [Branch Types](#branch-types)
- [Versioning](#versioning)
- [Release Process](#release-process)
- [Hotfix Process](#hotfix-process)
- [Tagging](#tagging)

## Branching Model

We follow a simplified **GitHub Flow** with long-lived `main` and optional `develop` branches.

```
main (production-ready)
  ↑
  └── feature branches
  └── fix branches
  └── hotfix branches
```

### Core Branches

#### `main`
- **Purpose**: Production-ready code
- **Protection**: Protected branch, requires PR reviews
- **Deployment**: Auto-deploys to production (future)
- **Naming**: `main`

#### `develop` (Optional)
- **Purpose**: Integration branch for next release
- **Protection**: Protected, requires PR reviews
- **Use**: When you want to test multiple features together before release
- **Naming**: `develop`

## Branch Types

### Feature Branches
**Purpose**: New features or enhancements

**Naming**: `feature/<short-description>`
- ✅ `feature/recipe-search`
- ✅ `feature/user-auth`
- ✅ `feature/shopping-list`
- ❌ `feature/123` (use descriptive names)

**Workflow**:
```bash
# Create from main (or develop)
git checkout main
git pull origin main
git checkout -b feature/recipe-search

# Make changes, commit often
git add .
git commit -m "feat: add recipe search API endpoint"

# Push and create PR
git push origin feature/recipe-search
```

**Merge**: Via PR with squash or merge commit

### Bug Fix Branches
**Purpose**: Fix bugs in upcoming release

**Naming**: `fix/<short-description>` or `bugfix/<issue-number>-<description>`
- ✅ `fix/recipe-delete-error`
- ✅ `bugfix/42-login-validation`

**Workflow**: Same as feature branches

### Hotfix Branches
**Purpose**: Critical fixes for production

**Naming**: `hotfix/<version>` or `hotfix/<critical-issue>`
- ✅ `hotfix/0.1.1`
- ✅ `hotfix/security-vulnerability`

**Workflow**:
```bash
# Create from main
git checkout main
git pull origin main
git checkout -b hotfix/0.1.1

# Fix the issue
git add .
git commit -m "fix: resolve critical database connection issue"

# Merge to main AND develop (if exists)
# Create PR, tag new version
```

### Documentation Branches
**Purpose**: Documentation-only changes

**Naming**: `docs/<description>`
- ✅ `docs/api-guide`
- ✅ `docs/update-readme`

### Refactoring Branches
**Purpose**: Code improvements without behavior changes

**Naming**: `refactor/<description>`
- ✅ `refactor/extract-recipe-service`
- ✅ `refactor/simplify-api-routes`

### Chore Branches
**Purpose**: Maintenance, dependency updates, config changes

**Naming**: `chore/<description>`
- ✅ `chore/update-dependencies`
- ✅ `chore/ci-improvements`

## Versioning

We follow **[Semantic Versioning](https://semver.org/)** (SemVer):

```
MAJOR.MINOR.PATCH
```

### Version Increments

#### MAJOR (1.0.0 → 2.0.0)
- Breaking API changes
- Incompatible data format changes
- Removal of deprecated features
- **Example**: Restructuring database schema

#### MINOR (0.1.0 → 0.2.0)
- New features (backward compatible)
- New API endpoints
- Significant enhancements
- **Example**: Adding user authentication

#### PATCH (0.1.0 → 0.1.1)
- Bug fixes
- Security patches
- Performance improvements
- **Example**: Fixing recipe deletion bug

### Pre-release Versions
- Alpha: `0.2.0-alpha.1`
- Beta: `0.2.0-beta.1`
- Release Candidate: `0.2.0-rc.1`

### Version 0.x.x
- **Current Status**: Pre-1.0 (API may change)
- **Stability**: Breaking changes allowed in MINOR versions
- **Production**: Not recommended until 1.0.0

## Release Process

### 1. Planning
- Create milestone for version (e.g., `v0.2.0`)
- Assign issues/PRs to milestone
- Update ROADMAP.md

### 2. Development
```bash
# Feature development
git checkout -b feature/new-feature
# ... develop and test ...
git push origin feature/new-feature
# Create PR → merge to main
```

### 3. Pre-Release Checklist
- [ ] All milestone issues resolved
- [ ] All tests passing
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped in Directory.Build.props
- [ ] Migration scripts tested (if applicable)

### 4. Create Release
```bash
# Ensure main is up to date
git checkout main
git pull origin main

# Create and push tag
git tag -a v0.2.0 -m "Release version 0.2.0"
git push origin v0.2.0
```

### 5. GitHub Release
1. Go to Releases → Draft a new release
2. Choose tag (v0.2.0)
3. Generate release notes
4. Add highlights from CHANGELOG.md
5. Attach build artifacts (optional)
6. Publish release

### 6. Post-Release
- [ ] Announce in Discussions
- [ ] Close milestone
- [ ] Create next milestone
- [ ] Update project board

## Hotfix Process

For critical production issues:

### 1. Create Hotfix Branch
```bash
git checkout main
git checkout -b hotfix/0.1.1
```

### 2. Fix and Test
```bash
# Make the fix
git commit -m "fix: critical security vulnerability in auth"

# Test thoroughly
dotnet test
```

### 3. Update Version & Changelog
- Bump PATCH version in Directory.Build.props
- Add entry to CHANGELOG.md under new version

### 4. Merge and Tag
```bash
# Push hotfix
git push origin hotfix/0.1.1

# Create PR to main
# After merge:
git checkout main
git pull origin main
git tag -a v0.1.1 -m "Hotfix: Security patch"
git push origin v0.1.1
```

### 5. Back-merge to Develop (if exists)
```bash
git checkout develop
git merge main
git push origin develop
```

## Tagging

### Tag Format
- Release: `v0.1.0`, `v1.0.0`
- Pre-release: `v0.2.0-beta.1`

### Tag Message Format
```bash
git tag -a v0.2.0 -m "Release version 0.2.0

- Feature: Recipe search
- Feature: User authentication
- Fix: Recipe deletion bug

See CHANGELOG.md for full details."
```

### Creating Tags
```bash
# Annotated tag (preferred)
git tag -a v0.2.0 -m "Release version 0.2.0"

# Push specific tag
git push origin v0.2.0

# Push all tags
git push origin --tags
```

### Deleting Tags
```bash
# Delete local tag
git tag -d v0.2.0

# Delete remote tag
git push origin --delete v0.2.0
```

## Commit Message Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Adding tests
- `chore`: Maintenance
- `ci`: CI/CD changes

### Examples
```bash
feat(api): add recipe search endpoint

Implements full-text search across recipe names and ingredients.

Closes #42

---

fix(ui): resolve recipe card hover animation

The card transform was causing z-index issues.

---

docs: update installation instructions

Added steps for dev container setup.

---

chore(deps): bump EF Core to 10.0.1
```

## Branch Protection Rules

### `main` Branch
- ✅ Require pull request reviews (1 approver)
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Require conversation resolution
- ✅ Require signed commits (optional)
- ✅ Include administrators
- ❌ Allow force pushes
- ❌ Allow deletions

### `develop` Branch (if used)
- ✅ Require pull request reviews (1 approver)
- ✅ Require status checks to pass
- ✅ Allow force pushes (for maintainers only)

## Workflow Diagrams

### Feature Development
```
main ─────●─────────●────────────●──→
           \         \            /
            \         \          /
             ●─●─●─●──●  (feature/my-feature)
                       \
                        ●─●─● (PR review)
```

### Hotfix
```
main ─────●─────────●────────●───●──→
                              \   /
                               \ /
                                ● (hotfix/0.1.1)
```

## Questions?

See [CONTRIBUTING.md](CONTRIBUTING.md) or ask in [Discussions](https://github.com/isaacrlevin/MealPlanner/discussions).

---

Last Updated: November 2025
