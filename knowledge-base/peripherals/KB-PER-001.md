# KB-PER-001: Headset USB / VoIP Mudo ou Microfone Inoperante no Windows e Teams

* **ID do Artigo:** KB-PER-001
* **Categoria:** Periféricos & Comunicações Unificadas / VoIP
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O colaborador entra em uma reunião do Microsoft Teams, Zoom ou softphone corporativo (ex: 3CX, MicroSIP) e não ouve os colegas ou ninguém consegue ouvi-lo.

## 2. Sintomas
* O indicador de microfone no Teams exibe aviso: *"Seu microfone não está funcionando"*.
* Áudio saindo pelos alto-falantes internos do notebook em vez do fone de ouvido.

## 3. Investigação N1 Passo a Passo

1. **Botão Físico Mute / Conexão USB:**
   * Verificar se a chave física no cabo do headset está no modo Mudo (LED vermelho aceso).
   * Desconectar da porta USB atual (evitar hubs USB passivos sem alimentação) e conectar diretamente em uma porta USB 3.0 nativa da máquina.

2. **Permissões de Privacidade no Windows:**
   * Configurações -> Privacidade e Segurança -> **Microfone**.
   * Garantir que a opção **"Acesso ao microfone"** esteja **Ativada** e que **"Permitir que os aplicativos da área de trabalho acessem o microfone"** também esteja marcada.

3. **Dispositivo Padrão de Reprodução e Gravação:**
   * Executar `mmsys.cpl` no Windows Executar.
   * Na aba **Reprodução**, clicar com botão direito no Headset e selecionar **Definir como Dispositivo Padrão** e **Definir como Dispositivo de Comunicação Padrão**.
   * Repetir o mesmo procedimento na aba **Gravação**.
   * Testar falando no microfone e observar se a barra verde de volume oscila.

4. **Configuração Interna do Microsoft Teams:**
   * No Teams: Configurações -> Dispositivos -> Dispositivos de Áudio.
   * Alterar de "Personalizado" para o nome exato do modelo do Headset (ex: *Jabra Evolve / Logitech H390*).
   * Clicar no botão **Fazer uma chamada de teste** (*Make a test call*) para validar o retorno do eco.

## 4. Validação
* Realizar uma chamada curta de 30 segundos via Teams/ramal entre o técnico N1 e o usuário para confirmar a inteligibilidade do áudio.
