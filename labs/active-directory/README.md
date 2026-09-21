# Laboratório Prático: Active Directory Domain Services (AD DS)

> **Objetivo:** Demonstrar compreensão aprofundada da estrutura de diretórios corporativos, governança de identidade, gerenciamento de Unidades Organizacionais (OUs), grupos de segurança e aplicação do Princípio do Menor Privilégio.

---

## 1. Estrutura de Diretório e OUs da Organização (Exemplo Aplicado)

```text
DC=empresa,DC=local
 └── OU=Brasilia
      ├── OU=Usuarios
      │    ├── OU=Financeiro
      │    ├── OU=Recursos Humanos
      │    ├── OU=Operacoes
      │    └── OU=TI_ServiceDesk
      ├── OU=Computadores
      │    ├── OU=Desktops
      │    └── OU=Notebooks
      └── OU=Grupos
           ├── GRP_FS_FINANCEIRO_RW (Acesso Leitura/Escrita Servidor de Arquivos)
           ├── GRP_VPN_COLABORADORES (Permissão de Túnel Remoto)
           └── GRP_TI_N1_OPERATORS (Operadores de Suporte N1)
```

---

## 2. Operações de Rotina N1 com PowerShell (Exemplos Seguros)

### A. Consulta Completa de Informações de Usuário
```powershell
Get-ADUser -Identity "mariana.costa" -Properties DisplayName, Title, Department, EmailAddress, LockedOut, Enabled, PasswordLastSet | 
    Format-List DisplayName, Title, Department, EmailAddress, LockedOut, Enabled, PasswordLastSet
```

### B. Desbloqueio Imediato de Conta
```powershell
# Verificar se está realmente bloqueada
(Get-ADUser -Identity "mariana.costa" -Properties LockedOut).LockedOut

# Executar desbloqueio
Unlock-ADAccount -Identity "mariana.costa"
Write-Output "Conta desbloqueada com sucesso."
```

### C. Criação Padronizada de Novo Colaborador (Onboarding N1)
```powershell
# Script com padrão corporativo e sem privilégios administrativos
$UserParams = @{
    Name                  = "Lucas Andrade"
    GivenName             = "Lucas"
    Surname               = "Andrade"
    SamAccountName        = "lucas.andrade"
    UserPrincipalName     = "lucas.andrade@empresa.local"
    Path                  = "OU=Operacoes,OU=Usuarios,OU=Brasilia,DC=empresa,DC=local"
    AccountPassword       = (ConvertTo-SecureString "SenhaPadraoInicial2026!#" -AsPlainText -Force)
    Enabled               = $true
    ChangePasswordAtLogon = $true
    Department            = "Operações N1"
    Title                 = "Assistente de Operações"
}

New-ADUser @UserParams
Write-Output "Usuário criado com sucesso na OU correta."
```

### D. Desativação Imediata de Acesso (Offboarding)
```powershell
# Desativar a conta, remover de grupos sensíveis e mover para OU de Desativados
Disable-ADAccount -Identity "lucas.andrade"
Set-ADUser -Identity "lucas.andrade" -Description "Conta desativada conforme chamado #REQ-2026-9901 em 21/09/2026"
Move-ADObject -Identity (Get-ADUser "lucas.andrade").DistinguishedName -TargetPath "OU=Desativados,OU=Brasilia,DC=empresa,DC=local"
```

---

## 3. Segurança e Princípio do Menor Privilégio
O técnico N1 atua com credencial delegada apenas sobre as OUs de usuários e computadores locais. **Não possui nem requer privilégios de Domain Admin**, protegendo o ambiente corporativo contra escalada indevida de privilégios.
