# Laboratório Prático: Troubleshooting Avançado Windows N1

Este laboratório demonstra o raciocínio diagnóstico estruturado em 6 cenários frequentes enfrentados por um Técnico de Suporte N1.

---

## Caso 01: Estação Sem Conexão com a Internet (Cabo Desconectado / IP APIPA)

* **Sintoma:** Usuário no setor Financeiro relata: *"Não consigo acessar nada na empresa, perdi a internet."*
* **Contexto:** Estação desktop Dell OptiPlex conectada à tomada de rede de parede.
* **Hipóteses Levantadas:**
  1. Cabo de rede desconectado ou danificado fisicamente.
  2. Placa de rede travada em endereço APIPA (`169.254.x.x`) por falha de DHCP.
  3. Porta do switch desarmada por Port Security.
* **Coleta de Evidências:**
  * Solicitação para o usuário verificar as luzes da placa de rede atrás do gabinete -> LED apagado.
  * Cabo estava frouxo devido à movimentação da mesa de trabalho.
  * Ao reconectar firmemente, o LED laranja e verde acendeu.
  * Executado `ipconfig /all`: Placa recebeu IP `169.254.120.45` provisório.
* **Procedimento de Solução:**
  ```cmd
  ipconfig /release
  ipconfig /renew
  ```
  * Resultado: Recebeu IP válido `192.168.20.114`, máscara `255.255.255.0`, Gateway `192.168.20.1` e DNS `10.10.1.10`.
* **Validação:**
  * Ping no Gateway: `ping 192.168.20.1` (0% de perda, 1ms).
  * Ping DNS externo: `ping 1.1.1.1` (0% perda).
  * Navegador acessou o ERP corporativo com sucesso.
* **Prevenção:** Orientar organização dos cabos de força e rede com organizador de cabos sob a bancada.
* **Registro do Chamado:** Ticket #INC-2026-0101 categorizado como *Rede / Conectividade Física / Resolvido no N1*.
* **Critério de Escalonamento:** Se após a troca do cabo o LED permanecesse apagado, acionaria o suporte de infraestrutura para testar a porta física no patch panel do rack.

---

## Caso 02: DNS Não Resolve Nomes (Acesso por IP funciona, por URL falha)

* **Sintoma:** Usuária consegue abrir sites pelo IP digitado, mas nenhuma URL (`google.com`, `intranet.empresa.local`) carrega.
* **Contexto:** Notebook em home office conectado via Wi-Fi corporativo pré-configurado.
* **Hipóteses:**
  1. Cache local do resolvedor de DNS corrompido no cliente.
  2. Endereço de DNS configurado com IP inválido estático na placa de rede.
* **Coleta de Evidências:**
  * `ping 8.8.8.8` -> Responde perfeitamente.
  * `ping google.com` -> *"A solicitação ping não pôde encontrar o host google.com"*.
  * `Get-DnsClientServerAddress -AddressFamily IPv4` -> Apontando para IP legado inativo `192.168.99.1`.
* **Procedimento de Solução:**
  ```powershell
  # Redefinir DNS para obtenção automática via DHCP
  Set-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -ResetServerAddresses
  # Limpeza do cache
  Clear-DnsClientCache
  ipconfig /flushdns
  ```
* **Validação:** `nslookup intranet.empresa.local` retornou o IP correto imediatamente.
* **Registro:** #INC-2026-0105 - *Rede / Resolução DNS / Resolvido no N1*.

---

## Caso 03: Usuário Não Consegue Iniciar Sessão no Windows (Senha Expirada / Conta Bloqueada)

* **Sintoma:** Colaborador na recepção digita as credenciais e recebe a mensagem: *"A conta especificada está bloqueada e não pode ser usada para fazer logon."*
* **Contexto:** Retorno de férias do colaborador.
* **Hipóteses:**
  1. Excesso de tentativas incorretas por digitação errada (Caps Lock ativado).
  2. Credencial antiga salva em smartphone pessoal bloqueando o domínio.
* **Coleta de Evidências:**
  * No PowerShell com módulo AD:
    `Get-ADUser -Identity "joao.almeida" -Properties LockedOut, BadPwdCount | Select-Object LockedOut, BadPwdCount`
    Resultado: `LockedOut = True`, `BadPwdCount = 5`.
* **Procedimento de Solução:**
  1. Validação de identidade do colaborador por telefone/ramal.
  2. `Unlock-ADAccount -Identity "joao.almeida"`
  3. `Set-ADUser -Identity "joao.almeida" -ChangePasswordAtLogon $true`
* **Validação:** Usuário efetuou o login na estação e cadastrou nova senha com sucesso na primeira tentativa.
* **Registro:** #INC-2026-0112 - *Acesso / Desbloqueio de AD / Resolvido no N1*.

---

## Caso 04: Computador Extremamente Lento (Uso de Disco em 100%)

* **Sintoma:** Máquina trava constantemente, levando 5 minutos para carregar o Explorador de Arquivos.
* **Coleta de Evidências:**
  * Gerenciador de Tarefas exibindo Disco em 100%.
  * Processo causador: `Windows Update` travado em loop de download de pacote cumulativo.
* **Procedimento de Solução:**
  ```powershell
  # 1. Parar serviços de atualização
  Stop-Service -Name wuauserv -Force
  Stop-Service -Name bits -Force
  # 2. Renomear pasta de cache corrompida de downloads
  Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.old"
  # 3. Reiniciar serviços
  Start-Service -Name wuauserv
  Start-Service -Name bits
  ```
* **Validação:** Consumo de disco caiu de 100% para 4% após 3 minutos.
* **Registro:** #INC-2026-0120 - *Sistema Operacional / Windows Update / Resolvido no N1*.

---

## Caso 05: Impressora de Departamento Não Imprime (Trabalho Travado no Spooler)

* **Sintoma:** Ninguém no setor de Compras consegue imprimir na impressora de rede departamental.
* **Coleta de Evidências:**
  * Ping no IP da impressora (`192.168.20.250`): Responde normalmente.
  * Fila de impressão na máquina de um usuário chave continha um arquivo PDF de 150MB com status "Erro - Excluindo..." que não desaparecia.
* **Procedimento:** Executado script de limpeza de spooler (`Stop-Service Spooler`, limpeza em `C:\Windows\System32\spool\PRINTERS\*`, `Start-Service Spooler`).
* **Validação:** Página de teste impressa com sucesso e documentos subsequentes liberados.
* **Registro:** #INC-2026-0128 - *Periféricos / Impressora / Resolvido no N1*.

---

## Caso 06: Aplicação de Negócio Corporativa Não Abre (Falha de Dependência C++ Redistributable)

* **Sintoma:** Ao clicar no ícone do software ERP, aparece a mensagem: *"O programa não pode ser iniciado porque está faltando MSVCR120.dll no seu computador."*
* **Coleta de Evidências:**
  * O arquivo DLL pertence ao pacote Microsoft Visual C++ 2013 Redistributable.
  * O aplicativo havia sido atualizado na noite anterior, exigindo a biblioteca que não estava instalada na máquina.
* **Procedimento:**
  * Executada a instalação silenciosa via repositório homologado corporativo do pacote `vcredist_x64.exe /install /quiet /norestart`.
* **Validação:** O ERP abriu a tela de login instantaneamente.
* **Registro:** #INC-2026-0135 - *Software / Dependência / Resolvido no N1*.
