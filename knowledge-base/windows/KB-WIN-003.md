# KB-WIN-003: Falha de Login com Perfil Temporário no Windows

* **ID do Artigo:** KB-WIN-003
* **Categoria:** Sistema Operacional / Windows
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O usuário faz login no computador corporativo e se depara com a mensagem: *"Você foi conectado com um perfil temporário. Não é possível acessar seus arquivos..."*. A área de trabalho aparece zerada e atalhos habituais sumiram.

## 2. Sintomas
* Notificação persistente no canto inferior direito do Windows.
* Arquivos salvos na Área de Trabalho desaparecem após reiniciar o equipamento.

## 3. Ambiente
* Windows 10 / Windows 11 integrado a domínio Active Directory local ou híbrido (Azure AD / Entra ID).

## 4. Causa Provável
O arquivo de registro do perfil do usuário (`NTUSER.DAT`) foi travado por um processo durante o desligamento anterior ou o registro criou uma chave duplicada com terminação `.bak` em `ProfileList`.

## 5. Procedimento de Recuperação N1

1. **Ação Imediata (Alerta ao Usuário):**
   * Orientar o usuário a **não salvar novos documentos** na Área de Trabalho temporária, pois serão descartados no logoff.

2. **Verificação no Registro do Windows (`regedit`):**
   * Acessar a chave:
     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList`
   * Identificar o SID correspondente ao usuário. Haverá duas entradas com o mesmo SID, uma delas terminando com `.bak`.

3. **Correção Controlada:**
   * Se existir a chave normal com caminho apontando para `C:\Users\TEMP`, renomeie para `.old`.
   * Na chave que possui o final `.bak` (que aponta para a pasta correta `C:\Users\nome.sobrenome`), remova a extensão `.bak`.
   * Certifique-se de que o valor DWORD `State` esteja definido como `0`.

4. **Reinicialização e Teste:**
   * Reiniciar a máquina: `shutdown /r /t 0`.
   * Pedir para o colaborador efetuar login novamente e verificar a restauração da Área de Trabalho e documentos originais.

## 6. Critérios de Escalonamento (N2)
* Se a pasta do usuário em `C:\Users\` tiver sido corrompida fisicamente no disco ou se o procedimento de registro não persistir após reinicialização.
