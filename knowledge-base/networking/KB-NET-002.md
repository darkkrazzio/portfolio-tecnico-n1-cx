# KB-NET-002: Falha de Resolução de Nomes DNS Corporativos e Públicos

* **ID do Artigo:** KB-NET-002
* **Categoria:** Redes & Conectividade
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O computador consegue pingar endereços de IP direto (ex: ping para 8.8.8.8 responde com sucesso), porém não consegue abrir sites pelo nome ou acessar servidores internos como `srv-arquivos.empresa.local` ou portais web.

## 2. Sintomas
* Navegador acusa erro: *"ERR_NAME_NOT_RESOLVED"*.
* Tentativa de ping por nome resulta em: *"A solicitação ping não pôde encontrar o host..."*.

## 3. Diagnóstico e Investigação N1

1. **Inspecionar Servidores DNS Configurados:**
   ```powershell
   Get-DnsClientServerAddress -AddressFamily IPv4
   ```
   *Verificar se o IP do DNS primário aponta para os controladores de domínio internos (ex: `10.10.1.10`, `10.10.1.11`) ou se foi sobrescrito manualmente por DNS público ou roteador doméstico.*

2. **Testar Resolução Direta com nslookup:**
   ```cmd
   nslookup portal.empresa.local
   # Testar consultando explicitamente o servidor DNS interno:
   nslookup portal.empresa.local 10.10.1.10
   ```

3. **Verificar Arquivo HOSTS Local (Possível interferência ou malware):**
   * Caminho: `C:\Windows\System32\drivers\etc\hosts`.
   * Verificar se há redirecionamentos manuais indevidos apontando para IPs incorretos.

4. **Procedimento de Correção:**
   ```powershell
   # Limpar cache DNS local do Windows
   Clear-DnsClientCache
   
   # Forçar re-registro no DNS do Active Directory
   ipconfig /registerdns
   ```

## 4. Validação
* Executar `nslookup` novamente e validar a resposta autoritativa com o endereço IP correto.
* Testar abertura do portal interno pelo navegador.

## 5. Critérios de Escalonamento (N2 - Infraestrutura)
* O servidor DNS corporativo (`10.10.1.10`) não responde a consultas `nslookup` de nenhuma máquina da rede (possível parada do serviço de DNS Server nos Domain Controllers).
