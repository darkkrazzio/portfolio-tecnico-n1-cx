# KB-WIN-001: Solução de Falhas no Spooler de Impressão Local Travado

* **ID do Artigo:** KB-WIN-001
* **Categoria:** Sistema Operacional / Windows
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O usuário envia documentos para impressão, mas nada é impresso. A fila exibe mensagens como *"Imprimindo"*, *"Erro - Enviando para impressora"* ou a impressora aparece como *"Offline"* sem motivo aparente.

## 2. Sintomas
* Documentos ficam presos na fila de impressão e não podem ser excluídos pelo usuário comum.
* Janela de propriedades da impressora congela.
* Mensagem de erro: *"O serviço de Spooler de Impressão não está em execução"*.

## 3. Ambiente
* Windows 10 Pro / Enterprise (todas as versões), Windows 11 (22H2 / 23H2).
* Impressoras locais via USB ou mapeadas por IP via porta TCP/IP local.

## 4. Causa Provável
Trabalho de impressão com arquivo corrompido (comum em PDFs com fontes não incorporadas ou grandes volumes) travando a fila em `C:\Windows\System32\spool\PRINTERS`.

## 5. Pré-requisitos
* Acesso remoto à estação via Quick Assist / TeamViewer / AnyDesk ou terminal com elevação administrativa.

## 6. Procedimento Passo a Passo

### Opção 1: Linha de Comando (Prompt Administrativo / PowerShell)
Execute a sequência abaixo no PowerShell executado como Administrador:

```powershell
# 1. Parar o serviço de Spooler
Stop-Service -Name Spooler -Force

# 2. Deletar os arquivos temporários presos na fila
Remove-Item -Path "C:\Windows\System32\spool\PRINTERS\*" -Force

# 3. Reiniciar o serviço de Spooler
Start-Service -Name Spooler

# 4. Validar se o serviço subiu e está em execução
Get-Service -Name Spooler
```

### Opção 2: Interface Gráfica
1. Pressione `Win + R`, digite `services.msc` e pressione Enter.
2. Localize **Spooler de Impressão (Print Spooler)**, clique com botão direito e selecione **Parar**.
3. Pressione `Win + R`, digite `spool\printers` e exclua todos os arquivos contidos na pasta (extensões `.SHD` e `.SPL`).
4. Retorne a `services.msc` e clique em **Iniciar**.

## 7. Validação
1. Abra o Bloco de Notas (`notepad`), digite um texto de teste.
2. Imprima na impressora afetada.
3. Peça ao usuário para acompanhar e confirmar se as folhas foram ejetadas corretamente.

## 8. Prevenção
* Orientar o usuário a não enviar múltiplos cliques repetidos de impressão quando um documento demorar a carregar.
* Manter o driver da impressora atualizado com a versão PCL6 ou PostScript recomendada pelo fabricante.

## 9. Critérios de Escalonamento (N2)
* O serviço para sozinho repetidamente (possível corrupção de DLL de driver de terceiros).
* Impressora conectada a servidor de impressão de rede (Print Server central) fora do escopo local.

## 10. Palavras-chave
spooler, impressora travada, fila de impressao, erro de impressao, shd, spl, windows
