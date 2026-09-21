# Laboratório Prático: Troubleshooting no Linux Desktop e Servidores

> **Objetivo:** Demonstrar competência prática no diagnóstico de falhas, análise de performance e administração básica em ambientes Linux utilizados em estações e servidores de apoio corporativo.

---

## Cenário 01: Servidor Web / API Interna Parou de Responder (HTTP 502 / Sem Resposta)

* **Sintoma:** Usuários relatam que o portal de chamados local não abre.
* **Passo 1 (Conectividade Básica):**
  ```bash
  ping -c 3 192.168.10.50
  ```
  *Retornou 0% de perda. Servidor está ativo na rede.*
* **Passo 2 (Verificação de Porta em Escuta):**
  ```bash
  ss -tulpn | grep :80
  ```
  *Nenhum processo escutando na porta 80.*
* **Passo 3 (Status do Serviço Nginx/Apache):**
  ```bash
  systemctl status nginx
  ```
  *Saída:* `Active: failed (Result: exit-code)`.
* **Passo 4 (Análise de Causa no Journald):**
  ```bash
  journalctl -u nginx -n 20 --no-pager
  ```
  *Identificado erro de sintaxe em arquivo de configuração após alteração recente de porta.*
* **Passo 5 (Ação de Correção):**
  Corrigido arquivo de configuração e executado:
  ```bash
  nginx -t && systemctl restart nginx
  ```
* **Passo 6 (Validação):**
  ```bash
  curl -I http://localhost
  # Retornou HTTP/1.1 200 OK
  ```

---

## Cenário 02: Disco Cheio Bloqueando Gravação de Logs e Banco de Dados

* **Sintoma:** Aplicativo reporta erro *"No space left on device"*.
* **Diagnóstico de Partição:**
  ```bash
  df -h
  ```
  *Partição `/var` com 100% de utilização (`Mounted on /var`).*
* **Localização dos Maiores Arquivos/Diretórios:**
  ```bash
  du -sh /var/log/* | sort -hr | head -n 5
  ```
  *Identificado arquivo `syslog.1` e logs antigos de aplicação ocupando 45 GB.*
* **Ação N1:**
  * Limpeza segura de logs antigos arquivados (`.gz`).
  * Truncamento seguro de arquivos de log em uso sem quebrar o descritor de arquivo:
    ```bash
    truncate -s 0 /var/log/app_debug.log
    ```
  * Validação: Espaço livre recuperado para 78% disponível.

---

## Cenário 03: Processo em Loop Consumindo 100% de CPU

* **Diagnóstico com top/ps:**
  ```bash
  top -b -n 1 | head -n 15
  # Ou localizar PID específico:
  ps aux --sort=-%cpu | head -n 5
  ```
* **Interrupção Segura:**
  * Enviar primeiro sinal gracioso: `kill -15 [PID]`
  * Se o processo persistir congelado após 30 segundos: `kill -9 [PID]`
  * Registrar a ocorrência para a equipe de desenvolvimento (N2).
