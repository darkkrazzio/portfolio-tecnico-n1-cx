# Diretrizes de Experiência do Cliente e Comunicação Humanizada (Customer Experience - CX)

> **Premissa:** *“Resolver o problema técnico é apenas 50% do trabalho; os outros 50% consistem em garantir que o usuário se sinta ouvido, respeitado, seguro e acolhido durante todo o processo.”*

---

## 1. Perfis de Usuários e Estratégias de Abordagem

### Perfil A: O Usuário com Pouca Familiaridade Tecnológica
* **Comportamento:** Sente medo de "estragar o computador", vergonha de não saber termos técnicos, fala de forma genérica ("a internet sumiu", "o sistema apagou tudo").
* **Estratégia do N1:**
  * Linguagem desprovida de jargões técnicos herméticos (evitar termos como *flushdns*, *loopback*, *DHCP lease* sem explicar).
  * Condução com analogias visuais simples (ex: *"Vou pedir para o senhor olhar na parte de trás do computador, onde tem aquele cabinho azul com uma luzinha piscando..."*).
  * Tom encorajador e paciente, reforçando que o problema não foi culpa dele.

### Perfil B: O Usuário Técnico / Desenvolvedor / Analista de Dados
* **Comportamento:** Já executou testes preliminares, tem pressa, fala com vocabulário técnico preciso e se frustra se for forçado a repetir etapas óbvias sem motivo.
* **Estratégia do N1:**
  * Comunicação objetiva e direta.
  * Perguntar de imediato o que já foi tentado: *"Olá, Thiago! Vi que você já testou o ping e o nslookup. Você chegou a testar a porta via Test-NetConnection ou olhar o log do Event Viewer?"*
  * Alinhamento colaborativo entre pares técnicos.

### Perfil C: O Usuário Sob Alta Pressão / Prazo Crítico
* **Comportamento:** Ansioso, relata que tem uma audiência, reunião com diretoria ou fechamento contábil em minutos.
* **Estratégia do N1:**
  * Manter a compostura e a calma vocal (a calma do técnico desacelera o usuário).
  * Foco imediato na contenção (*workaround* rápido para permitir a entrega da tarefa) em vez de uma investigação demorada da causa raiz.
  * Transparência no tempo estimado e atualizações frequentes.

### Perfil D: O Usuário Frustrado / Irritado com Recorrência
* **Comportamento:** Reclama de chamados anteriores não resolvidos, tom ríspido, descrença na TI.
* **Técnica de Atendimento (AIDA + Escuta Ativa):**
  1. **Acolhimento & Validação do Sentimento:** *"Compreendo perfeitamente o seu descontentamento, Mariana. Ficar sem emitir nota fiscal atrasa todo o seu cronograma, e eu no seu lugar também estaria incomodado."*
  2. **Assunção de Responsabilidade:** *"Eu assumi o seu chamado agora e vou acompanhar pessoalmente até que o sistema volte a operar normalmente."*
  3. **Plano de Ação Imediato:** Informar com clareza o passo que está sendo realizado.
  4. **Compromisso de Pós-Atendimento:** Manter contato até confirmar estabilidade e abrir investigação de causa raiz (Problema) para evitar novas ocorrências.

---

## 2. Roteiro Padrão de Atendimento (Script Estruturado N1)

1. **Abertura & Apresentação:**
   > *"Olá, bom dia! Aqui é o [Nome], do Service Desk N1. Com quem tenho o prazer de falar?"*
2. **Identificação & Localização:**
   > *"Perfeito, Carlos. Pode me confirmar seu setor e o número de patrimônio colado na etiqueta da sua máquina?"*
3. **Escuta Ativa & Entendimento do Problema:**
   > *"Entendido. Você mencionou que a impressora parou de responder logo após a queda de energia de hoje cedo, correto?"*
4. **Coleta de Diagnóstico Guiado:**
   > *"Vou iniciar um acesso remoto pelo Quick Assist / AnyDesk para avaliarmos a fila de impressão juntos, tudo bem?"*
5. **Aplicação da Solução e Explicação Respeitosa:**
   > *"Identifiquei que o serviço de spooler travou com um arquivo corrompido. Já limpei a fila e reiniciei o serviço."*
6. **Validação Prática com o Usuário:**
   > *"Poderia imprimir uma página de teste para confirmarmos se as folhas saíram normalmente na bandeja?"*
7. **Confirmação da Experiência e Encerramento:**
   > *"Excelente, fico feliz que esteja funcionando! Posso te ajudar com mais alguma questão hoje? O número do seu chamado é #INC-2026-1102. Tenha um ótimo dia de trabalho!"*
