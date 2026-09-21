# Relatório de Operação N1 & Análise de Recorrência

> **AVISO IMPORTANTE:** DADOS SIMULADOS PARA FINS EDUCACIONAIS E DEMONSTRAÇÃO TÉCNICA DE COMPETÊNCIA.

---

## 1. Indicadores Principais de Desempenho (KPIs do Mês Atual)

* **Volume Total de Chamados:** 384
* **Taxa de Resolução no Primeiro Nível (First Contact Resolution - FCR):** 81.5%
* **Índice de Cumprimento de SLA:** 96.8%
* **Tempo Médio de Atendimento (TMA):** 18 minutos
* **Tempo Médio de Resolução (TMR):** 42 minutos
* **Taxa de Chamados Reabertos:** 2.1% (Excelente - meta abaixo de 5%)
* **Índice de Satisfação do Usuário (CSAT):** 4.92 / 5.00 ⭐⭐⭐⭐⭐

---

## 2. Distribuição de Chamados por Categoria

```text
Identidade & Acesso (AD/Senhas) : ████████████████████ 32% (123 chamados)
Rede & Conectividade (Wi-Fi/VPN) : ████████████ 19% (73 chamados)
Periféricos & Impressão         : ██████████ 16% (61 chamados)
E-mail & M365 (Outlook/Sync)     : ████████ 13% (50 chamados)
Sistema Operacional (Windows/Lnx): ██████ 10% (38 chamados)
Hardware & Estações             : ████ 6% (23 chamados)
Outros / Dúvidas de Sistemas    : ██ 4% (16 chamados)
```

---

## 3. Do Incidente Recorrente à Melhoria Contínua (Cultura ITIL)

Como o Técnico N1 agrega valor estratégico à TI:

```text
[Identificação de Padrão] 
32% dos chamados eram sobre "Bloqueio de Senha" toda segunda-feira de manhã.
       │
       ▼
[Diagnóstico de Causa Raiz N1]
Usuários trocavam a senha no desktop na sexta-feira, mas o smartphone corporativo
mantinha o cache da senha antiga tentando autenticar no Wi-Fi e bloqueava o AD.
       │
       ▼
[Ação Proativa & Documentação]
1. Criação do artigo KB-AD-001 (Auditoria de BadPwdCount e Credenciais).
2. Publicação na FAQ de comunicado visual de 1 página: "Passo a passo para atualizar a senha no celular ao alterar no computador".
3. Criação de rotina PowerShell que identifica contas prestes a expirar e envia alerta com 3 dias de antecedência.
       │
       ▼
[Resultado Mensurado (Simulado)]
Queda de 45% nos chamados de redefinição de senha na segunda-feira seguinte!
```
