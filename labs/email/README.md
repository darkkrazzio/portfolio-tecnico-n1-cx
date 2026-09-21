# Laboratório Prático: Mensageria Corporativa, E-mail & Microsoft 365

> **Objetivo:** Troubleshooting prático em ambientes de mensageria corporativa, fluxo de e-mails, protocolos (IMAP, POP3, Exchange Online), SPF/DKIM e cliente Outlook.

---

## 1. Falha de Envio de E-mails com Anexo (Erro 552 / Mensagem Não Entregue)

* **Sintoma:** O usuário recebe um relatório de não entrega (*Non-Delivery Report - NDR*) com o código: *"552 5.3.4 Message size exceeds fixed maximum message size"*.
* **Diagnóstico N1:**
  * O arquivo anexo possui 42 MB, ultrapassando o limite padrão de transporte de e-mails (geralmente fixado em 25 MB ou 35 MB no Exchange).
* **Solução N1 Orientada ao Usuário:**
  * Orientar o colaborador com empatia: explicar que o e-mail não foi projetado para transferência de arquivos grandes.
  * Demonstrar como fazer upload do arquivo na pasta corporativa do OneDrive/SharePoint e enviar apenas o link de compartilhamento seguro com permissão de visualização.
  * Validação: O destinatário recebeu o link e acessou o arquivo instantaneamente.

---

## 2. Investigação de E-mails Falsos / Suspeita de Phishing

* **Sintoma:** Usuário desconfia de um e-mail recebido dizendo ser do "Suporte Bancário" solicitando atualização de certificado digital.
* **Ação N1:**
  1. Orientar o colaborador a **não clicar em nenhum link nem baixar anexos**.
  2. Coleta dos Cabeçalhos da Mensagem (*Internet Headers*):
     * No Outlook: Arquivo -> Propriedades -> Cabeçalhos de Internet.
  3. Análise dos registros:
     * Campo `Return-Path` diferente do remetente exibido.
     * Resultado do `Authentication-Results`: `spf=fail`, `dkim=fail`.
  4. Encaminhamento do arquivo `.eml` compactado para o time de Segurança da Informação (SOC - N3).
  5. Registro do ticket de alerta preventivo.
