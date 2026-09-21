# Diretrizes e Políticas de SLA (Service Level Agreement)

## 1. Definições Fundamentais
* **Tempo de Primeira Resposta (TMA - Triage):** Período decorrido entre o registro do chamado no sistema e a primeira interação humana com o usuário ou início do diagnóstico técnico.
* **Tempo de Resolução (TMR):** Período total até o serviço ser restabelecido e validado com o solicitante.
* **Tempo Útil (Business Hours):** Horário de atendimento contratual (ex: 10:00 às 19:00, de segunda a sexta-feira, fuso Brasília/DF).

---

## 2. Metas de SLA por Nível de Prioridade (Simulação Padrão)

| Prioridade | Primeiro Contato (Resposta) | Resolução Alvo | Regra de Escalonamento |
| :--- | :--- | :--- | :--- |
| **P1 - Crítica** | Até 15 minutos | Até 2 horas | Se não resolvido em 30 min, escalar para N2/Gerência Imediata |
| **P2 - Alta** | Até 30 minutos | Até 4 horas | Se não resolvido em 1 hora, escalar para N2 |
| **P3 - Média** | Até 1 hora | Até 8 horas | Se não resolvido em 4 horas, reavaliar com supervisão |
| **P4 - Baixa** | Até 2 horas | Até 24 horas | Resolução via fila regular N1 |
| **P5 - Mínima** | Até 4 horas | Até 48 horas | Agendamento de conveniência com o usuário |

---

## 3. Regras de Pausa e Congelamento de SLA
O cronômetro de SLA de resolução é **pausado automaticamente** nos seguintes estados:
1. **Aguardando Usuário:** Quando o técnico necessita de um teste por parte do colaborador ou envio de evidências e o solicitante está ausente ou em reunião.
2. **Aguardando Terceiro:** Quando o chamado depende de entrega de peça física pelo fabricante em garantia ou restabelecimento de link por concessionária externa de telecomunicações.
3. **Fora do Horário Comercial:** Chamados abertos após as 19:00 têm seu cronômetro iniciado a partir das 10:00 do dia útil seguinte.
