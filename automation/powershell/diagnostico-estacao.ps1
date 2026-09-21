<#
.SYNOPSIS
    Script de Diagnóstico Rápido e Coleta de Evidências Técnicas N1.
.DESCRIPTION
    Coleta informações essenciais da estação (SO, Hardware, Conectividade, DNS,
    Espaço em Disco e Serviços Chave) sem efetuar alterações no sistema.
.NOTES
    Autor: Suporte Técnico N1 / Customer Experience Lab
    Data: 2026-09-21
    Uso: Execução segura em modo somente leitura (Read-Only).
#>

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "       N1 SERVICE DESK — DIAGNÓSTICO DE ESTAÇÃO          " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Informações Básicas da Estação
$OS = Get-CimInstance Win32_OperatingSystem
$CS = Get-CimInstance Win32_ComputerSystem

Write-Host "`n[1. DADOS DO COMPUTADOR]" -ForegroundColor Yellow
Write-Host "Hostname:        $($CS.Name)"
Write-Host "Fabricante/Mod:  $($CS.Manufacturer) - $($CS.Model)"
Write-Host "Sistema Operac:  $($OS.Caption) (Build $($OS.BuildNumber))"
Write-Host "Último Reboot:   $($OS.LastBootUpTime)"
Write-Host "Usuário Logado:  $($CS.UserName)"

# 2. Memória RAM e Espaço em Disco
Write-Host "`n[2. RECURSOS DE ARMAZENAMENTO E MEMÓRIA]" -ForegroundColor Yellow
$TotalRAM = [math]::Round($CS.TotalPhysicalMemory / 1GB, 2)
$FreeRAM  = [math]::Round($OS.FreePhysicalMemory / 1MB, 2)
Write-Host "Memória RAM:     $FreeRAM GB livres de $TotalRAM GB totais"

Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $TotalDisk = [math]::Round($_.Size / 1GB, 2)
    $FreeDisk  = [math]::Round($_.FreeSpace / 1GB, 2)
    $PercFree  = [math]::Round(($_.FreeSpace / $_.Size) * 100, 1)
    
    $StatusColor = if ($PercFree -lt 15) { "Red" } else { "Green" }
    Write-Host "Unidade $($_.DeviceID)     $FreeDisk GB livres de $TotalDisk GB ($PercFree% livre)" -ForegroundColor $StatusColor
}

# 3. Configurações de Rede IPv4
Write-Host "`n[3. ADAPTADORES DE REDE & IP]" -ForegroundColor Yellow
Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null } | ForEach-Object {
    Write-Host "Interface:       $($_.InterfaceAlias)"
    Write-Host "IPv4 Address:    $($_.IPv4Address.IPAddress)"
    Write-Host "Gateway:         $($_.IPv4DefaultGateway.NextHop)"
    Write-Host "Servidores DNS:  $($_.DNSServer.ServerAddresses -join ', ')"
}

# 4. Teste de Conectividade Básica (Ping)
Write-Host "`n[4. TESTES DE CONECTIVIDADE]" -ForegroundColor Yellow
$Targets = @("127.0.0.1", "1.1.1.1", "google.com")

foreach ($Target in $Targets) {
    $Test = Test-Connection -ComputerName $Target -Count 1 -Quiet
    if ($Test) {
        Write-Host "Ping para $Target`: [SUCESSO]" -ForegroundColor Green
    } else {
        Write-Host "Ping para $Target`: [FALHA]" -ForegroundColor Red
    }
}

# 5. Status de Serviços Críticos de Suporte
Write-Host "`n[5. SERVIÇOS CRÍTICOS DO WINDOWS]" -ForegroundColor Yellow
$Services = @("Spooler", "wuauserv", "Dhcp", "Dnscache", "LanmanWorkstation")

foreach ($SvcName in $Services) {
    $Svc = Get-Service -Name $SvcName -ErrorAction SilentlyContinue
    if ($Svc) {
        $Color = if ($Svc.Status -eq "Running") { "Green" } else { "Red" }
        Write-Host "Serviço $($Svc.DisplayName) ($SvcName): [$($Svc.Status)]" -ForegroundColor $Color
    }
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "Diagnóstico finalizado. Copie estas evidências para o ticket." -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
