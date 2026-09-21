# Template Padrão de Requisição de Serviço (Service Desk N1)

```markdown
================================================================================
TICKET DE REQUISIÇÃO DE SERVIÇO: #REQ-[ANO]-[SEQUENCIAL]
================================================================================

1. DADOS DO REQUISITANTE & BENEFICIÁRIO
--------------------------------------------------------------------------------
Requisitante: [Nome de quem abriu]
Beneficiário Final: [Nome de quem receberá o acesso/equipamento]
Setor / Centro de Custo: [Ex: Controladoria / CC-1040]
Localidade de Entrega: [Ex: Escritório Brasília - Sala 204]

2. DETALHAMENTO DA REQUISIÇÃO
--------------------------------------------------------------------------------
Item do Catálogo: [Ex: Acesso a Pasta Compartilhada / Criação de Usuário / Novo Periférico]
Finalidade Comercial / Justificativa:
"[Ex: Nova analista contratada para fechamento fiscal trimestral]"

3. VALIDAÇÃO DE CONFORMIDADE & APROVAÇÃO
--------------------------------------------------------------------------------
Aprovador Responsável: [Nome do Gestor do Departamento]
Canal de Aprovação: [E-mail Corporativo / Aprovação no Workflow do ITSM]
Data e Hora da Aprovação: [Ex: 21/09/2026 10:14]
Status de Compliance: [x] Aprovado  [ ] Rejeitado

4. PROVISIONAMENTO TÉCNICO (PRINCÍPIO DO MENOR PRIVILÉGIO)
--------------------------------------------------------------------------------
Grupo de Active Directory Adicionado: [Ex: GRP_FS_FINANCEIRO_LEITURA]
Pasta de Rede / Caminho UNC: [\\srv-files01.empresa.local\financeiro$\relatorios]
Nível de Permissão Concedido: [Leitura Apenas / Modificação / Controle Total (Requer Diretoria)]
Comando PowerShell Executado:
> Add-ADGroupMember -Identity "GRP_FS_FINANCEIRO_LEITURA" -Members "usuario.exemplo"

5. ENTREGA & ACEITE DO USUÁRIO
--------------------------------------------------------------------------------
Procedimento de Teste: Usuário mapeou a unidade Z: e visualizou arquivos com sucesso.
Aceite Formal: Confirmado pelo usuário via chat corporativo.
Status: Encerrado
================================================================================
```
