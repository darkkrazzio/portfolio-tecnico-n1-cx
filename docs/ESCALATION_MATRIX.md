# Matriz Operacional de Escalonamento (N1 ➔ N2 ➔ N3 / Field Services)

> **Princípio Central:** O N1 é resolutivo para tudo o que estiver no escopo de primeiro nível, procedimentos da Knowledge Base e ferramentas atribuídas. Se o chamado exige acesso além do perfil ou intervenção física presencial em data center/switch, o escalonamento deve ser executado de forma estruturada, sem retrabalho para o usuário.

---

## 1. Critérios de Decisão: Resolver no N1 vs. Escalar

| Cenário Técnico | Decisão | Nível de Destino | Justificativa Operacional |
| :--- | :--- | :--- | :--- |
| Senha bloqueada / Expiração no Active Directory | **Resolver no N1** | N1 (Autoatendimento/Suporte) | Procedimento padrão, script/GUI de desbloqueio com validação de identidade. |
| Cabo desconectado / Placa com IP estático incorreto | **Resolver no N1** | N1 | Diagnóstico via ipconfig / liberação DHCP rápida. |
| Perfil do Outlook corrompido / Cache OST travado | **Resolver no N1** | N1 | Procedimento documentado de recriação de perfil via Painel de Controle (Mail). |
| Troca de headset / mouse com defeito físico na filial Brasília | **Resolver no N1** | N1 / Suporte Local | Atendimento presencial simples no estoque local de periféricos. |
| **Queda total do link de internet ou switch de andar inoperante** | **Escalar** | **N2 / Infraestrutura & Redes** | Requer acesso a equipamentos de núcleo, abertura de chamado com a operadora ISP. |
| **Suspeita de comprometimento / Infecção por Ransomware ou Phishing** | **Escalar Imediato** | **N3 / Segurança da Informação (SOC/CSIRT)** | Isolar a máquina da rede imediatamente e acionar protocolo de segurança. |
| **Falha de hardware em servidor ou storage corporativo** | **Escalar** | **N3 / Infraestrutura de Servidores** | Escopo exclusivo de administração de data center/cloud. |
| **Erro de código / Bug em software ERP proprietário** | **Escalar** | **N2 / N3 Sustentação de Sistemas** | Exige depuração de código, logs de banco de dados ou correção de release. |
| **Necessidade de troca de placa-mãe / display quebrado de notebook** | **Escalar** | **Field Services / Garantia Fabricante (Dell/Lenovo)** | Requer abertura de chamado em garantia com envio de peças e técnico credenciado. |

---

## 2. Padrão Obrigatório de Registro de Escalonamento (Handover N1 ➔ N2)

Ao transferir um ticket para o nível seguinte, o analista N1 **nunca** deve apenas encaminhar dizendo *"favor verificar"*. O chamado deve ser preenchido com a seguinte ficha técnica:

```markdown
### [FICHA DE ESCALONAMENTO N1 -> N2/N3]
* **Chamado Original:** #INC-2026-0842
* **Solicitante:** Marcos Vinicius (Gerência Financeira - Ramal 4022)
* **Ativo Afetado:** Estação DT-FIN-014 (Windows 11 Enterprise 23H2)
* **Impacto & Urgência:** Alto / Alta (Fechamento contábil mensal)
* **Sintoma Observado:** Aplicação TOTVS Protheus exibe "Erro de Conexão com Servidor de Licenças (Porta 5555)".

**Testes Executados pelo N1:**
1. Teste de conectividade física e IP: Estação possui IP válido na VLAN 20 (192.168.20.45).
2. Ping para o gateway (192.168.20.1): 100% sucesso (latência < 1ms).
3. Resolução DNS: `nslookup srv-licencas.empresa.local` resolveu para 10.10.5.12.
4. Teste de porta com PowerShell: `Test-NetConnection -ComputerName 10.10.5.12 -Port 5555` retornou `TcpTestSucceeded: False`.
5. Outras estações do setor financeiro apresentaram a mesma mensagem nos últimos 10 minutos.

**Hipótese Técnica N1:** Serviço de licenças travado no servidor 10.10.5.12 ou bloqueio recente de regra no Firewall interno.
**Ação Solicitada ao N2:** Verificar o status do serviço no servidor de licenças ou liberação da porta 5555 entre VLAN 20 e VLAN 10.
**Evidências Anexadas:** Print do erro Protheus + Log de comando PowerShell salvo no ticket.
```
