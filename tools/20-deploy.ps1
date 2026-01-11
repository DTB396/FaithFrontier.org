[CmdletBinding()]
param(
  [string]$RepoRoot = (Resolve-Path "..").Path,
  [string]$Branch   = "main",
  [string]$Message  = "Automated deploy",
  [string]$RemoteUrl = "",
  [string]$RemoteName = "origin",
  [switch]$AllowBehind
)
$ErrorActionPreference = "Stop"
Set-Location $RepoRoot

Write-Host "`n== DEPLOY PIPELINE =="

# --------------------------------------------------
# 0. Remote configuration & connectivity
# --------------------------------------------------
Write-Host "== DEBUG: Listing all git remotes =="
git remote -v
Write-Host "== DEBUG: Listing all local branches =="
git branch -a
Write-Host "== DEBUG: Listing all remote branches =="
git branch -r

$remotes = git remote
if ($remotes -contains $RemoteName) {
  Write-Host "✔ Remote '$RemoteName' exists. Proceeding."
} elseif ($remotes -contains 'origin') {
  Write-Host "[WARN] Remote '$RemoteName' not found, using 'origin' instead."
  $RemoteName = 'origin'
} elseif ($remotes) {
  $firstRemote = $remotes | Select-Object -First 1
  Write-Host "[INFO] Using first available remote: $firstRemote"
  $RemoteName = $firstRemote
} else {
  if ([string]::IsNullOrWhiteSpace($RemoteUrl)) {
    throw "Missing git remote '$RemoteName'. Provide -RemoteUrl [url] to set it."
  }
  git remote add $RemoteName $RemoteUrl
  Write-Host "[INFO] Added remote '$RemoteName' with URL $RemoteUrl."
}

Write-Host "✔ Remote '$RemoteName' ready."
Write-Host "== NOTE: This repo has both 'main' and 'gh-pages-clean' branches. Current branch: $(git rev-parse --abbrev-ref HEAD) =="

Write-Host "== Remote connectivity check =="
git ls-remote $RemoteName HEAD *> $null
if ($LASTEXITCODE -ne 0) {
  throw "Cannot reach remote '$RemoteName'. Check network/credentials."
}
Write-Host "✔ Remote reachable"

Write-Host "== Fetching remote state =="
git remote -v
Write-Host "✔ Remote reachable"

Write-Host "== Fetching remote state =="
git fetch --prune $RemoteName
if ($LASTEXITCODE -ne 0) {
  throw "Failed to fetch from '$RemoteName'."
}

Write-Host "== Remote branch check =="
$remoteBranch = git ls-remote --heads $RemoteName $Branch
if (-not $remoteBranch) {
  Write-Host "⚠ Remote branch '$RemoteName/$Branch' not found (will create on push)"
} else {
  Write-Host "✔ Remote branch '$RemoteName/$Branch' exists"
}

$currentBranch = (git rev-parse --abbrev-ref HEAD).Trim()
if ($currentBranch -eq "HEAD") {
  throw "Detached HEAD. Checkout a branch before deploy."
}
if ($currentBranch -ne $Branch) {
  $dirty = git status --porcelain
  if ($dirty) {
    throw "Working tree not clean; cannot switch branches safely."
  }
  Write-Host "Switching to branch '$Branch' (was '$currentBranch')"
  git checkout $Branch
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to checkout branch '$Branch'."
  }
}

${upstream} = $(git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>$null)
if (-not $upstream) {
  $upstream = "$RemoteName/$Branch"
}
$counts = git rev-list --left-right --count "$upstream...HEAD" 2>$null
if ($LASTEXITCODE -eq 0 -and $counts) {
  $parts = $counts -split '\s+'
  $behind = [int]$parts[0]
  $ahead = [int]$parts[1]
  if ($behind -gt 0 -and -not $AllowBehind) {
    throw "Branch is behind $upstream by $behind commit(s). Pull/rebase before deploy or pass -AllowBehind."
  }
  Write-Host "✔ Ahead/behind: behind=$behind ahead=$ahead"
} else {
  throw "Unable to compute ahead/behind status."
}

# --------------------------------------------------
# 1. Doctor (repo sanity checks)
# --------------------------------------------------
Write-Host "== Doctor checks =="
pwsh -NoProfile -ExecutionPolicy Bypass `
  -File "$PSScriptRoot\00-doctor.ps1" `
  -RepoRoot $RepoRoot

# --------------------------------------------------
# 2. Fix (config / excludes / normalization)
# --------------------------------------------------
pwsh -NoProfile -ExecutionPolicy Bypass `
  -File "$PSScriptRoot\10-fix.ps1" `
  -RepoRoot $RepoRoot

# --------------------------------------------------
# 3. FRONT MATTER GUARD  ⬅️ ADDITION (CRITICAL)
# --------------------------------------------------
pwsh -NoProfile -ExecutionPolicy Bypass `
  -File "$PSScriptRoot\05-frontmatter-guard.ps1" `
  -RepoRoot $RepoRoot

# --------------------------------------------------
# 4. Build (hard fail if Liquid breaks)
# --------------------------------------------------
Write-Host "`n== Jekyll build =="

bundle exec jekyll clean
bundle exec jekyll build --trace --strict_front_matter


# --------------------------------------------------
# 5. Commit + push (only if changes exist)
# --------------------------------------------------

Write-Host "`n== Git commit and push =="
$hasChanges = $false
try {
    git diff --quiet
    if ($LASTEXITCODE -ne 0) {
        $hasChanges = $true
    }
} catch {
    $hasChanges = $true
}

if ($hasChanges) {
    git add -A
    git commit -m $Message
    $upstream = $(git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>$null)
    if (-not $upstream) {
        git push -u $RemoteName $Branch
    } else {
        git push $RemoteName $Branch
    }
    Write-Host "✔ Changes committed and pushed"
} else {
    Write-Host "✔ No changes to commit"
}

Write-Host "== DEPLOY COMPLETE =="
