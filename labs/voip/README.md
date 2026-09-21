# Laboratório Prático: Telefonia IP, VoIP & Comunicações Unificadas

> **Objetivo:** Procedimentos de suporte de primeiro nível para ramais IP (hardphones SIP), softphones e ferramentas como Microsoft Teams Phone.

---

## 1. Falha: Telefone Físico IP Não Registra no PABX Virtual (No Service / Unregistered)

* **Sintoma:** Aparelho telefônico na mesa de atendimento exibe a mensagem *"Registro com falha"* ou fica sem tom de discagem.
* **Fluxo Diagnóstico N1:**
  1. **Alimentação & PoE:** O aparelho recebe energia via PoE (*Power over Ethernet*) do switch? O cabo de rede está conectado na porta `LAN` e não na porta `PC` do aparelho?
  2. **VLAN de Voz (Voice VLAN):** O telefone pegou IP na faixa correta de telefonia (`192.168.30.0/24`)?
     * Se recebeu IP `192.168.20.xxx` (dados), a tag 802.1Q de Voice VLAN pode estar desconfigurada na porta do switch.
  3. **Ping no Servidor PABX:**
     * Acessar a interface web do telefone (via IP do aparelho no navegador).
     * Testar ping para o servidor SIP (`10.10.30.5`).
  4. **Credenciais SIP:** Verificar se o ramal e a senha do protocolo SIP estão em conformidade com o cadastro da central.

---

## 2. Falha de Áudio Unidirecional (One-Way Audio / Jitter / Perda de Pacotes)

* **Sintoma:** O colaborador consegue ouvir o cliente, mas o cliente não ouve a voz do colaborador.
* **Causa Comum em Redes IP:**
  * Bloqueio ou falha de tradução de portas RTP (geralmente portas UDP 10000 a 20000) no Firewall ou NAT com SIP ALG ativo (*Application Layer Gateway* desregulando o fluxo SDP).
* **Ação N1:**
  * Verificar se o problema ocorre apenas em ligações externas ou também entre ramais internos.
  * Se for restrito a conexões externas via VPN de home office: validar bloqueio de UDP pelo provedor residencial.
  * Documentar as portas afetadas e escalar com rastreio de pacotes para o N2 de Telecomunicações.
