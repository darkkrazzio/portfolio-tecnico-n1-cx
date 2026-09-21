# Template Padrão de Registro de Incidente (Service Desk N1)

```markdown
================================================================================
TICKET DE INCIDENTE: #INC-[ANO]-[SEQUENCIAL]
================================================================================

1. DADOS DO SOLICITANTE
--------------------------------------------------------------------------------
Nome Completo: [Nome do Colaborador]
Departamento/Setor: [Ex: Financeiro / RH / Operações / Jurídico]
Localidade: [Ex: Edifício Sede Brasília - 4º Andar / Home Office]
Contato: [Ramal / Telefone / WhatsApp Corporativo]
Horário de Contato: [Ex: 14:15]

2. CLASSIFICAÇÃO ITIL
--------------------------------------------------------------------------------
Tipo de Registro: Incidente
Categoria: [Hardware | Software | Rede | E-mail | Acesso | VoIP | Periféricos]
Subcategoria: [Ex: Conectividade Wi-Fi / Erro de Envio Outlook / Bloqueio de AD]
Item de Configuração (CI) / Hostname: [Ex: NB-DF-0452 / IP 192.168.10.88]
Impacto: [Alto | Médio | Baixo]
Urgência: [Alta | Média | Baixa]
Prioridade Calculada: [Crítica (P1) | Alta (P2) | Média (P3) | Baixa (P4) | Mínima (P5)]

3. DESCRIÇÃO DO SINTOMA & IMPACTO OPERACIONAL
--------------------------------------------------------------------------------
Relato do Usuário:
"[Transcrever de forma clara o que o usuário reportou]"

Mensagem de Erro Literal:
"[Código ou print da mensagem de erro exibida em tela]"

Impacto no Negócio:
[Descrever se o usuário está totalmente impedido de trabalhar ou se há alternativa]

4. TRIAGEM & TROUBLESHOOTING N1 (EVIDÊNCIAS TÉCNICAS)
--------------------------------------------------------------------------------
[x] Teste de conectividade física (cabo conectado, link no switch)
[x] Validação de endereçamento IP (ipconfig /all / ip addr)
[x] Teste de resolução de nomes (nslookup)
[x] Teste de conectividade com gateway e serviços de borda (ping)
[x] Análise de logs locais (Event Viewer / journalctl)

Comandos executados & Resultados:
> ping 192.168.1.1 -> OK (1ms)
> nslookup app.empresa.local -> Falha (Non-existent domain)

5. AÇÃO EXECUTADA / PROCEDIMENTO APLICADO
--------------------------------------------------------------------------------
Procedimento da KB Consultada: [Ex: KB-NET-002: Falha de Cache DNS no Windows]
Ações:
1. Executado ipconfig /flushdns
2. Verificado arquivo hosts (limpo de entradas obsoletas)
3. Reiniciada placa de rede virtual

6. VALIDAÇÃO & RESOLUÇÃO
--------------------------------------------------------------------------------
Resultado: O usuário conseguiu abrir a aplicação com sucesso.
Validação com Solicitante: Usuário confirmou funcionamento às 14:38.
Status Final: Resolvido
Tempo de Atendimento (TMA): 23 minutos
SLA Respeitado: [x] Sim  [ ] Não
Prevenção Sugerida: Verificar se outros usuários da VLAN 10 reportam instabilidade no DNS local.
================================================================================
```
