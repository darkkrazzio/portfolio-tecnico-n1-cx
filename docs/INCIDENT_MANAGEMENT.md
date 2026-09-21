# Procedimento Operacional Padrão: Gerenciamento de Incidentes (Incident Management)

## 1. Ciclo de Vida do Incidente no Service Desk N1

```text
[Novo Contato] ──────────► [Identificação & Registro] ──────────► [Categorização & Priorização]
                                                                        │
┌───────────────────────────────────────────────────────────────────────┘
▼
[Diagnóstico Inicial & Troubleshooting N1]
       │
       ├─► [Solução Conhecida na KB / Procedimento Realizado] ──► [Validação com Usuário] ──► [Encerramento]
       │
       └─► [Falha de Infra / Sem Permissão / Causa Desconhecida] ─► [Escalonamento N2/N3 com Evidências]
```

---

## 2. Matriz de Priorização (Impacto × Urgência)

> *Nota de governança:* A matriz abaixo é um padrão demonstrativo baseado nas melhores práticas ITIL. Em ambientes reais de produção, as faixas de minutos/horas são determinadas pelo Acordo de Nível de Serviço (SLA) formalizado com o cliente.

| Impacto \ Urgência | Alta (Interrupção total / VIP / Prazo Crítico) | Média (Trabalho prejudicado com alternativa) | Baixa (Pequena conveniência / Sem prazo imediato) |
| :--- | :--- | :--- | :--- |
| **Alto (Empresa inteira, filial ou diretoria)** | **P1 - Crítica** (SLA 15min / 2h resolução) | **P2 - Alta** (SLA 30min / 4h resolução) | **P3 - Média** (SLA 1h / 8h resolução) |
| **Médio (Setor inteiro / Processo operacional)** | **P2 - Alta** (SLA 30min / 4h resolução) | **P3 - Média** (SLA 1h / 8h resolução) | **P4 - Baixa** (SLA 2h / 24h resolução) |
| **Baixo (Usuário individual)** | **P3 - Média** (SLA 1h / 8h resolução) | **P4 - Baixa** (SLA 2h / 24h resolução) | **P5 - Mínima** (SLA 4h / 48h resolução) |

---

## 3. Estados do Chamado (Ticket Status Flow)

* **Novo (New):** Chamado recém-criado, pendente de triagem e atribuição.
* **Em Análise (In Triage):** Técnico N1 validando informações, escopo e evidências iniciais.
* **Em Atendimento (In Progress):** N1 em contato ativo ou executando procedimentos de troubleshooting.
* **Aguardando Usuário (Pending User):** Aguardando teste, retorno de horário do usuário ou envio de print de erro. O temporizador de SLA de resolução é pausado neste status.
* **Aguardando Terceiro (Pending Vendor):** Aguardando operadora de telecomunicações, garantia de hardware ou suporte externo.
* **Escalado (Escalated):** Transferido para N2 (Sistemas/Infra), N3 (Especialistas/Segurança) ou Field Support.
* **Resolvido (Resolved):** Correção aplicada e validada com o usuário; aguarda confirmação final de encerramento.
* **Encerrado (Closed):** Chamado aceito pelo usuário ou encerrado automaticamente por inatividade após 48h sem réplica.

---

## 4. Estrutura Obrigatória para Registro de Chamado (Template de Incidentes)

Todo registro de incidente no N1 deve conter:
1. **Identificação do Solicitante:** Nome completo, setor, ramal/WhatsApp, hostname/patrimônio da máquina.
2. **Descrição do Sintoma:** O que está acontecendo (exatamente como relatado e com mensagens de erro literais).
3. **Ambiente:** SO (Windows 11 23H2 / Ubuntu 22.04), versão do app afetado, tipo de conexão (cabo/Wi-Fi/VPN).
4. **Passos para Reprodução:** Roteiro que aciona o erro.
5. **Ações Executadas (Troubleshooting):** Comandos rodados, serviços reiniciados, verificações feitas.
6. **Resultado Obtido:** Sucesso da intervenção ou logs capturados para escalonamento.
