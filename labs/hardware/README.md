# Laboratório Prático: Troubleshooting de Hardware e Estações de Trabalho

> **Objetivo:** Demonstrar o processo investigativo de falhas físicas, testes de bancada e diagnóstico em estações Dell, Lenovo, HP e periféricos corporativos.

---

## 1. Casos Práticos de Hardware N1

### Caso A: Notebook Não Liga (Sem Sinal de Alimentação)
* **Sintoma:** Usuário pressiona o botão Power e a máquina não reage, sem LEDs ou barulho de ventoinha (*cooler*).
* **Diagnóstico N1:**
  1. Testar se o LED da ponta do carregador ou do conector acende ao plugar na tomada.
  2. Testar outra tomada elétrica conhecida que esteja funcionando.
  3. **Procedimento de Reset Elétrico (Drenagem de Energia Residual):**
     * Desconectar carregador e todos os periféricos USB/Docking.
     * Pressionar e segurar o botão Power por 30 segundos contínuos.
     * Reconectar somente o carregador e ligar novamente.
  4. *Resultado:* Em 70% dos casos de proteção estática em notebooks modernos, o equipamento volta a inicializar normalmente.
  5. *Escalonamento:* Se após a drenagem persistir inerte, acionar garantia com abertura de chamado no portal Dell/Lenovo para troca da placa-mãe (*Motherboard replacement*).

---

### Caso B: Bips Sonoros ao Ligar (Post Beep Codes / LEDs de Diagnóstico)
* **Sintoma:** Desktop liga os coolers em velocidade máxima, não exibe imagem e pisca o LED de energia em padrão (ex: 2 piscadas âmbar, 3 piscadas brancas em Dell OptiPlex).
* **Diagnóstico:**
  * O código "2-3" no manual do fabricante indica falha de memória RAM (não detectada ou falha de inicialização).
  * Abertura do gabinete com pulseira antiestática.
  * Remoção dos pentes de memória, limpeza dos contatos com pincel antiestático e reposicionamento (*reseat*) nos slots 1 e 3.
  * Validação com diagnóstico integrado (F12 -> ePSA Diagnostics).

---

### Caso C: Periféricos (Webcam e Microfone para Reuniões de Diretoria)
* **Sintoma:** Em sala de reunião, a câmera USB Logitech Rally não é detectada pelo computador da sala.
* **Diagnóstico N1:**
  * Verificar conexões do Hub USB na mesa.
  * No Gerenciador de Dispositivos (`devmgmt.msc`): verificar se há dispositivo com triângulo amarelo ou se o controlador USB entrou em estado de suspensão seletiva (*USB selective suspend*).
  * Desativar a suspensão de energia nas propriedades do Hub USB raiz.
  * Câmera detectada e validada em chamada de teste.
