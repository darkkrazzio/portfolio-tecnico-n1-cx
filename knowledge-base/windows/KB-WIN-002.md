# KB-WIN-002: Diagnóstico e Mitigação de Lentidão Extrema (Disco 100% e CPU Alta)

* **ID do Artigo:** KB-WIN-002
* **Categoria:** Sistema Operacional / Windows
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O usuário relata que o computador está extremamente lento, travando ao abrir planilhas ou alternar entre janelas do navegador e chamadas do Teams.

## 2. Sintomas
* O Gerenciador de Tarefas acusa uso constante de Disco em 100% ou CPU acima de 90%.
* Tempo de resposta longo para cliques e digitação com atraso (*input lag*).

## 3. Ambiente
* Windows 10 e Windows 11 Enterprise em notebooks e desktops.

## 4. Causa Provável
* Processos de indexação em loop (`SearchIndexer.exe`), Windows Update travado em download em segundo plano (`TiWorker.exe`), antivírus corporativo realizando varredura completa fora de horário agendado, ou falta de memória RAM gerando paginação excessiva (*paging file*).

## 5. Procedimento de Diagnóstico e Resolução N1

1. **Identificar o Processo Causador:**
   * Pressione `Ctrl + Shift + Esc` (Gerenciador de Tarefas) e ordene pela coluna **Disco** ou **CPU**.
   * Identifique se o vilão é um aplicativo de usuário (ex: Chrome com 50 abas) ou processo do sistema (`System`, `SysMain`, `Windows Update`).

2. **Se o problema for o serviço SysMain (SuperFetch antigo em discos mecânicos/híbridos):**
   ```powershell
   # Verificar status
   Get-Service -Name SysMain
   # Se necessário pausar temporariamente para teste
   Stop-Service -Name SysMain
   ```

3. **Limpeza Segura de Arquivos Temporários:**
   ```powershell
   # Limpar cache temp de usuário
   Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
   # Limpar cache temp do sistema
   Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
   ```

4. **Verificação de Integridade de Arquivos de Sistema (SFC):**
   ```cmd
   sfc /scannow
   ```

5. **Verificação de Saúde do Disco (SMART):**
   ```powershell
   Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, MediaType, OperationalStatus, HealthStatus
   ```

## 6. Validação com o Usuário
* Solicitar que o usuário abra os dois aplicativos principais de trabalho simultaneamente.
* Observar se o uso de disco estabiliza abaixo de 10-20% em repouso.

## 7. Quando Escalar para N2/Field Support
* Status de saúde do disco retornar `Unhealthy` ou `Pred Fail` (necessidade de substituição física imediata do SSD/HD por Field Services).
