#!/usr/bin/env pwsh
# FaithFrontier.org: Web Dev PowerShell Utility Script
# This script installs and launches the most useful VS Code extensions and tools for local web analysis, debugging, and inspection.

# 1. Install recommended VS Code extensions
$extensions = @(
    "yandeu.five-server",           # Fast live server with instant reload
    "ms-vscode.live-server",        # Official Live Preview
    "ritwickdey.liveserver",        # Popular Live Server
    "pablogonsan8.wptinspector",    # Web performance/network inspector
    "nikhiljosephk.server-console-log" # Server-side console log in browser
)

Write-Host "Installing recommended VS Code extensions..."
foreach ($ext in $extensions) {
    code --install-extension $ext --force
}

# 2. Suggest best server for this repo (Jekyll static site)
# Five Server and Live Server both work, but Five Server is fastest for static _site output
Write-Host "\nRecommended: Use Five Server for _site directory preview."
Write-Host "To start:"
Write-Host "    npx five-server --port=4000 --open --root=_site"

# 3. Auto-configure .vscode/settings.json for best web dev experience
$settingsPath = ".vscode/settings.json"
if (!(Test-Path ".vscode")) { mkdir ".vscode" | Out-Null }

$settings = @{
    "liveServer.settings.root" = "/_site"
    "fiveServer.root" = "_site"
    "fiveServer.port" = 4000
    "fiveServer.open" = true
    "files.exclude" = @{ "_site" = $false }
    "editor.formatOnSave" = $true
    "editor.codeActionsOnSave" = @{ "source.fixAll" = $true }
}

$settingsJson = $settings | ConvertTo-Json -Depth 5
Set-Content -Path $settingsPath -Value $settingsJson

Write-Host "\n.vscode/settings.json updated for optimal static site workflow."

# 4. Print usage tips
Write-Host "\n--- USAGE TIPS ---"
Write-Host "- Use 'Five Server: Open Project' from VS Code Command Palette for instant preview."
Write-Host "- Use WPT Inspector for network/performance audits."
Write-Host "- Use Server Console Log to view server-side logs in browser DevTools."
Write-Host "- All tools are now ready for FaithFrontier.org Jekyll static site development."
