# Ficha Técnica de Escalonamento Operacional (Handover N1 ➔ N2/N3)

```markdown
================================================================================
RELATÓRIO TÉCNICO DE ESCALONAMENTO N1 -> [N2-SISTEMAS / N2-INFRA / N3-SEGURANÇA]
================================================================================

TICKET DE ORIGEM: #INC-[ANO]-[ID]
DATA/HORA DO ESCALONAMENTO: [Data e Hora Exata]
TÉCNICO RESPONSÁVEL N1: [Nome do Analista N1]

1. RESUMO EXECUTIVO
--------------------------------------------------------------------------------
Usuário Afetado: [Nome, Cargo e Setor]
Item de Configuração Afetado: [Hostname / IP / Sistema]
Prioridade Definida: [P1 - Crítica | P2 - Alta | P3 - Média]
Justificativa do Escalonamento:
[Ex: Necessidade de intervenção direta no switch core / Falha na porta TCP do servidor de banco / Falta de privilégio administrativo no N1]

2. HISTÓRICO DE INVESTIGAÇÃO N1 & EVIDÊNCIAS COLETADAS
--------------------------------------------------------------------------------
Comportamento Reprodutível? [x] Sim  [ ] Intermitente
Testes de Rede Realizados:
- Ping Gateway: [OK / Tempo de resposta < 1ms]
- Resolução DNS: [OK / IP resolvido: 10.10.1.50]
- Teste de Porta (PowerShell Test-NetConnection): [FALHA / Porta 1433 recusando conexões]

Logs Extraídos do Event Viewer (Sistema / Aplicação):
- Event ID: 1001 - Application Error no executável financeiro.exe
- Código de Exceção: 0xc0000005

Ações Já Realizadas pelo N1 (Para evitar retrabalho no N2):
1. Reinicialização controlada da estação de trabalho.
2. Limpeza de arquivos temporários e redefinição de perfil do aplicativo.
3. Teste em máquina vizinha (mesmo erro ocorre para outros usuários do setor).

3. HIPÓTESE TÉCNICA DO N1
--------------------------------------------------------------------------------
"O problema não está isolado na estação do cliente. Trata-se de uma falha de serviço no servidor de banco de dados SQL (10.10.1.50) ou bloqueio de firewall na porta 1433 após a manutenção noturna."

4. ORIENTAÇÃO FORNECIDA AO CLIENTE
--------------------------------------------------------------------------------
O cliente foi informado de que a demanda está sendo tratada em conjunto com o time sênior de infraestrutura. Foi alinhado retorno de status em até 45 minutos.
================================================================================
```
