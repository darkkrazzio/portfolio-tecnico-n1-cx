# KB-AD-001: Gestão de Contas, Desbloqueio e Auditoria no Active Directory

* **ID do Artigo:** KB-AD-001
* **Categoria:** Identidade e Acesso / Active Directory
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O usuário relata que não consegue fazer login no computador da empresa ou no portal interno, recebendo a mensagem: *"A conta referenciada está bloqueada e não pode ser utilizada"*, ou *"Sua senha expirou e precisa ser alterada"*.

## 2. Sintomas e Validação de Identidade (Segurança N1)
> **ATENÇÃO:** Antes de desbloquear ou redefinir qualquer senha, o técnico N1 deve validar a identidade do solicitante por um canal corporativo oficial (videoconferência, validação de matrícula com gestor ou envio de código de confirmação via e-mail previamente cadastrado). **Nunca realizar reset com base apenas em ligação sem confirmação.**

## 3. Procedimento via Interface Gráfica (ADUC - Active Directory Users and Computers)
1. Abrir `dsa.msc` no servidor de gerenciamento ou RSAT.
2. Localizar o usuário na Unidade Organizacional (OU) correspondente ao setor.
3. Clicar duas vezes sobre o usuário e selecionar a aba **Account (Conta)**.
4. Se a conta estiver bloqueada, marcar a caixa **"Unlock account" (Desbloquear conta)** e clicar em Aplicar.
5. Se for necessário reset de senha:
   * Clicar com botão direito no usuário -> **Reset Password...**
   * Definir uma senha temporária complexa de acordo com a política corporativa (mínimo 12 caracteres, letras maiúsculas, minúsculas, números e símbolos).
   * Marcar impreterivelmente a opção: **"User must change password at next logon" (O usuário deve alterar a senha no próximo logon)**.

## 4. Procedimento Rápido e Seguro via PowerShell

```powershell
# 1. Inspecionar o estado da conta (bloqueada? expirada? desabilitada?)
Get-ADUser -Identity "carlos.silva" -Properties LockedOut, AccountExpirationDate, Enabled, PasswordLastSet | 
    Select-Object Name, SamAccountName, LockedOut, Enabled, PasswordLastSet

# 2. Desbloquear a conta com segurança
Unlock-ADAccount -Identity "carlos.silva"

# 3. Definir senha temporária obrigando alteração no próximo login
$SenhaTemp = ConvertTo-SecureString "TempCorporate2026!#" -AsPlainText -Force
Set-ADAccountPassword -Identity "carlos.silva" -NewPassword $SenhaTemp -Reset
Set-ADUser -Identity "carlos.silva" -ChangePasswordAtLogon $true
```

## 5. Auditoria de Bloqueio Recorrente (BadPwdCount)
Se o usuário relatar que a conta é bloqueada a cada 10 minutos, o N1 deve inspecionar o atributo `badPwdCount`:
```powershell
Get-ADUser -Identity "carlos.silva" -Properties BadLogonCount, LastBadPasswordAttempt | 
    Select-Object SamAccountName, BadLogonCount, LastBadPasswordAttempt
```
* **Causa Comum:** Smartphone ou tablet corporativo com Wi-Fi/e-mail configurado com a senha antiga tentando autenticar em segundo plano.
* **Ação N1:** Orientar o colaborador a desconectar temporariamente a rede Wi-Fi corporativa de dispositivos móveis pessoais e atualizar a credencial salva no Gerenciador de Credenciais do Windows.
