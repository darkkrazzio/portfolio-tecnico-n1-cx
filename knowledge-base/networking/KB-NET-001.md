# KB-NET-001: Estação Sem Conectividade de Rede (Cabo / Wi-Fi / IP APIPA 169.254.x.x)

* **ID do Artigo:** KB-NET-001
* **Categoria:** Redes & Conectividade
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O usuário relata estar sem acesso à internet, à intranet corporativa e às pastas de rede. O ícone de rede na barra de tarefas exibe um globo com símbolo de bloqueio ou exclamação amarela.

## 2. Sintomas
* Erro no navegador: *"DNS_PROBE_FINISHED_NO_INTERNET"* ou *"Sem conexão"*.
* Ao rodar `ipconfig`, o endereço IPv4 aparece na faixa `169.254.x.x` (Endereçamento APIPA).

## 3. Causa Provável
* Cabo de rede desconectado ou danificado, porta do switch desabilitada (Port Security por troca de MAC), falha de negociação DHCP com o servidor, ou adaptador de rede em estado travado.

## 4. Fluxo Lógico de Diagnóstico N1

```text
1. Verificação Física (LEDs acendem na placa e no patch cord?)
   ├── NÃO ──► Trocar patch cord / Reconectar em outra tomada de rede na mesa
   └── SIM  ──► Seguir para camada lógica

2. Diagnóstico TCP/IP via Prompt / PowerShell:
   > ipconfig /all
```

### Comandos de Resolução no Terminal:
```cmd
:: 1. Liberar a concessão DHCP atual
ipconfig /release

:: 2. Solicitar nova concessão de IP ao servidor DHCP
ipconfig /renew

:: 3. Limpar cache do resolvedor DNS
ipconfig /flushdns

:: 4. Testar loopback (pilha TCP/IP interna)
ping 127.0.0.1

:: 5. Testar o Gateway Padrão recebido
ping 192.168.10.1
```

Se o adaptador persistir travado:
```powershell
# Reiniciar o adaptador de rede Ethernet
Restart-NetAdapter -Name "Ethernet"
```

## 5. Validação
* Confirmar se o IP atribuído pertence à sub-rede corporativa (ex: `192.168.10.xxx` com máscara `/24` e Gateway funcional).
* Efetuar ping para DNS externo e interno:
  ```cmd
  ping 1.1.1.1
  ping intranet.empresa.local
  ```

## 6. Critérios de Escalonamento (N2 - Redes)
* Múltiplos computadores da mesma baia/andar apresentando o mesmo IP APIPA simultaneamente (possível falha de switch ou esgotamento de escopo no servidor DHCP).
* Porta de rede com luz âmbar constante sem negociação de link (possível cabo rompido no cabeamento estruturado que exige certificação por Field Support).
