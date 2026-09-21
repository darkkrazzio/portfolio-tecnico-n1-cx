# KB-HDW-001: Resolução de Falhas de Vídeo e Múltiplos Monitores (HDMI / DisplayPort / Hub)

* **ID do Artigo:** KB-HDW-001
* **Categoria:** Hardware & Estações de Trabalho
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O monitor secundário fica com tela preta, exibe *"Sem Sinal" (No Signal)* ou entra em modo de economia de energia, mesmo com o notebook conectado na docking station ou diretamente na saída de vídeo.

## 2. Roteiro de Troubleshooting N1

1. **Atalho de Reinicialização de Driver de Vídeo:**
   * Pressione no teclado: `Win + Ctrl + Shift + B`.
   * A tela piscará brevemente e um bipe sonoro será emitido, forçando o Windows a reiniciar o subsistema gráfico (DWM/WDDM).

2. **Atalho de Projeção do Windows:**
   * Pressione `Win + P` e certifique-se de que a opção selecionada seja **Estender** (*Extend*) e não "Somente tela do computador".

3. **Verificação de Fonte de Entrada (Input Source):**
   * Orientar o usuário a verificar nos botões físicos do monitor se a entrada selecionada corresponde à porta conectada (HDMI 1, HDMI 2, DisplayPort, Type-C).

4. **Isolamento de Cabo e Porta:**
   * Trocar a ponta do cabo HDMI/DisplayPort.
   * Se estiver usando adaptador/dongle USB-C, testar a ligação direta sem o acessório para eliminar falha do conversor.

5. **Ajuste de Taxa de Atualização e Resolução:**
   * Configurações -> Sistema -> Tela -> Configurações Avançadas de Tela.
   * Verificar se a taxa de atualização foi configurada para um valor não suportado pelo monitor (definir em 60 Hz padrão).

## 3. Critérios de Escalonamento (Field Services)
* Monitor não acende nenhum LED de energia mesmo em tomada testada (falha na fonte interna da tela).
* Artefatos na tela (linhas verticais coloridas fixas) visíveis até na tela da BIOS (dano físico no painel LCD).
