# Guia de Fundamentos ITIL v4 Aplicados ao Suporte N1 (Service Desk)

> **Contexto Operacional:** Laboratório prático e estudo aplicado de boas práticas ITIL adaptadas à realidade operacional de um Técnico de Experiência do Cliente N1 (Brasília/DF).

---

## 1. O que é ITIL no contexto do Service Desk N1?
A **ITIL (Information Technology Infrastructure Library)** fornece uma estrutura (*framework*) para o gerenciamento de serviços de TI (ITSM). Para o analista N1, a ITIL não é apenas teoria gerencial, mas sim o **roteiro prático de tomada de decisão**, garantindo previsibilidade, rastreabilidade e satisfação do usuário.

No N1, atuamos como o **Ponto Único de Contato (SPOC - Single Point of Contact)** entre os usuários da organização e a equipe de Tecnologia da Informação.

---

## 2. Diferenciação Operacional: Os 4 Tipos de Demandas

| Dimensão | Incidente (Incident) | Requisição de Serviço (Service Request) | Problema (Problem) | Mudança (Change) |
| :--- | :--- | :--- | :--- | :--- |
| **Definição ITIL** | Interrupção não planejada ou redução na qualidade de um serviço. | Solicitação formal de um usuário para algo a ser fornecido (acesso, hardware, dúvida). | Causa raiz ou causa potencial desconhecida por trás de um ou mais incidentes. | Adição, modificação ou remoção de qualquer item que possa afetar os serviços de TI. |
| **Objetivo N1** | Restaurar o serviço normal o mais rápido possível (*workaround* ou correção). | Atender à solicitação dentro do catálogo de serviços e aprovações prévias. | Identificar recorrência, registrar evidências e apoiar o N2/N3 na investigação. | Identificar quando uma solicitação exige aprovação (RFC) e não executar fora do padrão. |
| **Exemplo Real** | "Meu Outlook parou de sincronizar e dá erro 0x8004010F." | "Preciso de acesso à pasta compartilhada do setor financeiro." | "Cinco usuários da mesma filial perderam conexão com o ERP após as 14h." | "Atualização do firmware do switch central agendada para sábado." |
| **Ação do N1** | Aplicar procedimento da KB, testar e restabelecer conexão. | Validar autorização do gestor e adicionar o usuário ao grupo de AD aprovado. | Criar ticket de Problema vinculado aos incidentes e escalar para N2/Infra. | Não aplicar alterações arquiteturais em produção sem processo de Change Management. |

---

## 3. As 4 Dimensões do Gerenciamento de Serviços no N1

1. **Organizações e Pessoas:** Empatia, escuta ativa, clareza na linguagem técnica e alinhamento com os horários de operação do negócio (ex: atendimento 10h às 19h).
2. **Informação e Tecnologia:** Uso de sistemas ITSM, ferramentas de telemetria, scripts seguros de diagnóstico e inventário de ativos.
3. **Parceiros e Fornecedores:** Saber quando acionar links de operadoras de telecom (WAN), suporte de garantia de fabricantes (Dell/Lenovo) e SaaS (Microsoft 365).
4. **Fluxos de Valor e Processos:** Cumprimento rigoroso de SLAs, taxonomia uniforme de categorização e alimentação contínua da Base de Conhecimento (KCS - Knowledge-Centered Service).

---

## 4. Princípios Orientadores ITIL Aplicados ao Dia a Dia

* **Foco no valor:** Entender a dor do usuário corporativo. Restaurar a planilha de faturamento de um diretor tem valor imediato para a empresa.
* **Começar de onde você está:** Antes de formatar uma máquina ou reinstalar o SO, colete evidências, verifique logs recentes e aplique soluções de menor impacto.
* **Progredir iterativamente com feedback:** Ao solucionar um problema, teste passo a passo e pergunte ao usuário se a função necessária voltou a responder.
* **Colaborar e promover visibilidade:** Documentar cada ação no histórico do chamado para que qualquer colega do N1 ou N2 compreenda exatamente o que já foi testado.
* **Pensar e trabalhar holisticamente:** Lembrar que uma falha de rede pode ser física (cabo), lógica (DHCP/DNS) ou de autenticação (802.1x).
* **Manter de forma simples e prática:** Se uma limpeza de cache de credenciais do Windows Credential Manager resolve o travamento de login, não é necessário recriar o perfil do Windows.
* **Otimizar e automatizar:** Tarefas repetitivas de diagnóstico (verificação de IP, DNS, rotas, espaço em disco) devem ser automatizadas via scripts em PowerShell/Bash.
