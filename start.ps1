param(
  [ValidateRange(1, 65535)]
  [int]$Port = 8080
)

$listener = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue
if ($listener) {
  Write-Error "El puerto $Port ya esta en uso. Ejecuta .\start.ps1 -Port 8081."
  exit 1
}

Write-Host "Portfolio disponible en http://localhost:$Port"
py -m http.server $Port --bind 127.0.0.1 --directory $PSScriptRoot
