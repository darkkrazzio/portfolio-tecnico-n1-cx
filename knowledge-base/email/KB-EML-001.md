# KB-EML-001: Solução para Outlook Desconectado, Falha OST e Credenciais M365

* **ID do Artigo:** KB-EML-001
* **Categoria:** E-mail & Mensageria
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Problema
O cliente relata que o aplicativo Microsoft Outlook não recebe nem envia e-mails novos. A barra de status inferior exibe *"Desconectado"*, *"Tentando conectar..."* ou solicita a senha repetidamente em loop sem aceitar.

## 2. Sintomas
* Mensagens ficam presas na pasta "Caixa de Saída" (*Outbox*).
* No Outlook Web (OWA / navegador), a conta funciona normalmente com as mesmas credenciais, comprovando que o problema está no cliente desktop local.

## 3. Procedimento de Resolução N1

### Etapa 1: Limpeza de Credenciais Antigas do Office
1. Fechar o Outlook e Teams.
2. Pressione `Win + R`, digite `control /name Microsoft.CredentialManager`.
3. Selecione **Credenciais do Windows**.
4. Localize e remova todas as entradas iniciadas por `MicrosoftOffice16_Data`, `ADAL` ou `MS.Outlook`.

### Etapa 2: Iniciar em Modo Seguro para Isolar Suplementos Problemáticos
```cmd
outlook.exe /safe
```
* Se abrir sem travar, o causador é um suplemento de terceiros (antivírus, leitor de PDF ou plugin de CRM). Desativar os suplementos COM em Arquivo -> Opções -> Suplementos.

### Etapa 3: Recriação Limpa do Arquivo de Dados Offline (.OST)
1. Feche o Outlook.
2. Pressione `Win + R` e acesse `%localappdata%\Microsoft\Outlook`.
3. Localize o arquivo `[email].ost` e renomeie-o para `[email].ost.old`.
4. Abra o Outlook novamente. O cliente reconstruirá o cache baixando as mensagens do servidor exchange em nuvem.

### Etapa 4: Criação de Novo Perfil de E-mail (Se persistir)
1. Painel de Controle -> **Mail (Microsoft Outlook)**.
2. Clicar em **Mostrar Perfis...** -> **Adicionar**.
3. Nomear como `Corporativo2` e seguir o assistente de autodescoberta (Autodiscover).
4. Definir o novo perfil como padrão.

## 4. Validação
* Enviar um e-mail de teste para o próprio usuário e verificar a sincronização imediata na pasta "Itens Enviados" e "Caixa de Entrada".
