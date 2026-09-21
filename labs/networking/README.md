# Laboratório Prático: Redes Corporativas, TCP/IP e Diagnóstico de Conectividade

> **Objetivo:** Demonstrar domínio de conceitos de redes (TCP/IP, IPv4, Sub-redes, DNS, DHCP, Gateways, NAT, VLANs, Roteamento e Portas) sob a perspectiva diagnóstica do Suporte N1.

---

## 1. Topologia e Arquitetura Conceitual da Filial (Brasília/DF)

```text
       [ Provedor ISP WAN 1 ]       [ Provedor ISP WAN 2 (Backup) ]
                 │                                  │
                 └──────────────────┬───────────────┘
                                    │
                                    ▼
                         [ Firewall / Roteador de Borda ]
                         IP WAN: 200.x.x.x / NAT Ativo
                         VLAN Trunk (802.1Q)
                                    │
             ┌──────────────────────┴──────────────────────┐
             │                                             │
             ▼                                             ▼
[ Switch Core / Distribuição L3 ]            [ Controladores de Domínio ]
VLAN 10: Gerência & TI (192.168.10.0/24)     - Active Directory / DNS
VLAN 20: Corporativo / Estações (192.168.20.0/24) - DHCP Server Scope: 192.168.20.50-200
VLAN 30: Telefonia VoIP (192.168.30.0/24)    IP: 10.10.1.10 / 10.10.1.11
VLAN 40: Wi-Fi Visitantes (172.16.40.0/24)
             │
   ┌─────────┴─────────────────────┐
   ▼                               ▼
[ Estação N1 (Windows 11) ]    [ Servidor de Arquivos & ERP ]
IP: 192.168.20.45               IP: 10.10.5.20
GW: 192.168.20.1                Portas: 445 (SMB), 1433 (SQL)
```

---

## 2. Camadas do Modelo TCP/IP no Raciocínio Diagnóstico N1

Quando um chamado de rede chega ao Service Desk, o analista N1 segue o método de isolamento estruturado:

1. **Camada 1 (Física):**
   * *Verificação:* Cabo de rede desconectado, pino quebrado, luzes Link/Act no conector RJ45 e na porta do switch.
2. **Camada 2 (Enlace):**
   * *Verificação:* Negociação de velocidade (1000 Mbps Full Duplex vs. 10 Mbps Half Duplex por cabo danificado), isolamento de porta e VLAN atribuída incorretamente na porta do switch.
3. **Camada 3 (Rede / Internet):**
   * *Verificação:* Endereço IP válido via DHCP, máscara de sub-rede, rota padrão (Gateway) e tabela de roteamento local.
   * *Comandos:* `ipconfig`, `ip addr`, `ip route`, `ping`.
4. **Camada 4 (Transporte):**
   * *Verificação:* O protocolo de transporte (TCP/UDP) está respondendo na porta de serviço esperada?
   * *Comandos:* `Test-NetConnection -Port`, `ss -tulpn`, `telnet`.
5. **Camada 7 (Aplicação):**
   * *Verificação:* Resolução de nomes (DNS), regras de proxy corporativo, autenticação NTLM/Kerberos e resposta HTTP/HTTPS.
   * *Comandos:* `nslookup`, `dig`, `curl -I`.

---

## 3. Matriz de Comandos de Rede para Suporte N1

| Comando | Plataforma | Finalidade Prática no Suporte N1 |
| :--- | :--- | :--- |
| `ipconfig /all` | Windows | Lista todos os adaptadores, MAC Address, IP, Gateway, Servidor DHCP e DNS. |
| `ip addr` / `ip a` | Linux | Inspeciona interfaces de rede, IPs e status de link. |
| `ping -t [destino]` | Windows | Testa continuidade de pacotes em tempo real para detectar intermitência/perda. |
| `tracert [host]` | Windows | Mapeia os saltos (*hops*) até o destino, identificando em qual roteador ocorre a parada. |
| `traceroute [host]` | Linux | Equivalente ao tracert no ambiente Linux. |
| `nslookup [fqdn]` | Win/Linux | Testa consultas a registros A, CNAME e MX no servidor DNS. |
| `Test-NetConnection -ComputerName [host] -Port [porta]` | PowerShell | Testa se uma porta TCP remota específica está acessível (substituto moderno do telnet). |
| `arp -a` | Win/Linux | Inspeciona a tabela ARP para verificar resolução de IP para endereço físico MAC. |
| `netstat -ano` / `ss -tulpn` | Win/Linux | Lista conexões ativas e portas locais abertas vinculadas a PIDs. |
