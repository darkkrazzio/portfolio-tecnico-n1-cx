# KB-BRW-001: Resolução de Falhas de Certificado, Cache Corrompido e Páginas Inacessíveis no Edge / Chrome

* **ID do Artigo:** KB-BRW-001
* **Categoria:** Softwares de Navegação (Edge / Chrome)
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O usuário não consegue acessar sistemas internos da empresa via navegador, recebendo mensagens como: *"Sua conexão não é particular"* (`NET::ERR_CERT_AUTHORITY_INVALID`), tela em branco contínua ou botões que não disparam ações na página web.

## 2. Diagnóstico e Resolução Rápida N1

1. **Validação de Data e Hora do Sistema Operacional:**
   * Uma das causas mais frequentes de erro de SSL/TLS é o relógio do computador desincronizado.
   * Verificar se a data, hora e fuso horário estão corretos (Horário de Brasília: UTC-03:00).
   * Forçar sincronização via PowerShell:
     ```powershell
     w32tm /resync
     ```

2. **Isolamento via Janela Anônima / InPrivate:**
   * Solicitar que o usuário pressione `Ctrl + Shift + N`.
   * Se a página abrir normalmente na janela privada, a falha decorre de:
     * Cache de sessão corrompido;
     * Conflito com extensão instalada (ex: bloqueadores de pop-up ou plugins legados).

3. **Limpeza Seletiva de Cache de Navegação:**
   * No Edge/Chrome: `Ctrl + Shift + Delete`.
   * Intervalo de tempo: "Últimas 24 horas" ou "Todo o período".
   * Selecionar: "Cookies e outros dados do site" e "Imagens e arquivos em cache".
   * *Atenção:* Não marcar a opção de senhas salvas para não prejudicar as credenciais do usuário.

4. **Instalação da Cadeia de Certificados Corporativos (Root CA Interna):**
   * Se o erro for persistente apenas em servidores `.empresa.local`, verificar se a máquina recebeu a Autoridade Certificadora Raiz corporativa via GPO (`certmgr.msc` -> Autoridades de Certificação Raiz Confiáveis).

## 3. Validação
* Atualizar a página com `Ctrl + F5` (Hard Refresh) e confirmar o cadeado de segurança verde/válido na barra de endereços.
