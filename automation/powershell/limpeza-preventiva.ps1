<#
.SYNOPSIS
    Rotina Segura de Limpeza Preventiva de Arquivos Temporários e Cache.
.DESCRIPTION
    Remove com segurança caches de arquivos temporários do usuário e sistema,
    exibindo estimativa de espaço liberado com confirmação obrigatória.
.NOTES
    Autor: Suporte Técnico N1
    Data: 2026-09-21
    Segurança: Exige confirmação explícita do operador antes de qualquer exclusão.
#>

[CmdletBinding()]
param(
    [switch]$Force
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "     N1 SERVICE DESK — LIMPEZA PREVENTIVA DE DISCO       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Alvos seguros de limpeza
$Targets = @(
    "$env:TEMP",
    "C:\Windows\Temp"
)

Write-Host "`nDiretórios alvos para limpeza de temporários:" -ForegroundColor Yellow
$Targets | ForEach-Object { Write-Host " - $_" }

if (-not $Force) {
    $Confirm = Read-Host "`nDeseja prosseguir com a remoção dos arquivos temporários? (S/N)"
    if ($Confirm -ne 'S' -and $Confirm -ne 's') {
        Write-Host "Operação cancelada pelo operador. Nenhuma alteração realizada." -ForegroundColor Yellow
        exit
    }
}

$DeletedCount = 0
$BytesFreed = 0

foreach ($Folder in $Targets) {
    if (Test-Path $Folder) {
        Write-Host "`nProcessando: $Folder..." -ForegroundColor Gray
        $Files = Get-ChildItem -Path $Folder -Recurse -File -ErrorAction SilentlyContinue
        
        foreach ($File in $Files) {
            try {
                $Size = $File.Length
                Remove-Item -Path $File.FullName -Force -ErrorAction Stop
                $BytesFreed += $Size
                $DeletedCount++
            } catch {
                # Arquivos em uso pelo sistema são ignorados com segurança
            }
        }
    }
}

$MBFreed = [math]::Round($BytesFreed / 1MB, 2)
Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host "Limpeza concluída com sucesso!" -ForegroundColor Green
Write-Host "Arquivos removidos: $DeletedCount"
Write-Host "Espaço em disco liberado: $MBFreed MB"
Write-Host "==========================================================" -ForegroundColor Green
