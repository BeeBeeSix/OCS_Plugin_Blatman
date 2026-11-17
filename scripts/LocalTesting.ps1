# TESTING - Build release DLL and copy to OpenCAD Studio local plugins folder
Set-Location (Split-Path $PSScriptRoot -Parent)

cargo build --release
if ($LASTEXITCODE -ne 0) {
    Write-Error "Cargo build failed."
    Pause
    exit $LASTEXITCODE
}

$d = "$env:APPDATA\OpenCADStudio\plugins\com.beebeesix.ocs-plugin-blatman"
New-Item -ItemType Directory -Path $d -Force | Out-Null

Copy-Item "target\release\ocs_plugin_blatman.dll" -Destination $d -Force
Copy-Item "plugin.toml" -Destination $d -Force

Write-Host "Copied ocs_plugin_blatman.dll and plugin.toml to $d" -ForegroundColor Green
Pause
