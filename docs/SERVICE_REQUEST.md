# Procedimento Operacional Padrão: Requisições de Serviço (Service Request Management)

## 1. Definição e Diferenciação
Diferente de um Incidente (que visa reparar um serviço interrompido), uma **Requisição de Serviço** é um pedido padrão para obtenção de recursos, permissões de acesso, alterações cadastrais, orientações ou fornecimento de equipamentos previamente homologados pelo catálogo de TI.

---

## 2. Catálogo Padrão de Requisições N1

1. **Gestão de Identidades e Acessos:**
   * Criação de novo colaborador (onboarding com aprovação do RH/Gestor).
   * Desativação de conta (offboarding imediato).
   * Concessão de acesso a pastas de rede (SMB/DFS) ou grupos de e-mail (Distribution Lists).
   * Redefinição de senha e MFA (Autenticação Multifator).
2. **Estações de Trabalho e Hardware:**
   * Troca de periférico desgastado (headset com ruído, teclado com tecla falhando).
   * Solicitação de segundo monitor para produtividade.
   * Empréstimo temporário de notebook corporativo.
3. **Software e Ferramentas de Produtividade:**
   * Instalação de software homologado (Adobe Acrobat Reader, 7-Zip, DBeaver, VS Code).
   * Habilitação de licença do Microsoft 365 / Teams Phone.

---

## 3. Fluxo de Autorização e Princípio do Menor Privilégio

```text
[Solicitante Abre Requisição] 
         │
         ▼
[Validação N1: Existe aprovação formal do gestor de dados/área?]
   ├── NÃO ──► Solicitar ticket de aprovação via Workflow / Recusar conforme política
   └── SIM  ──► Executar provisionamento estrito (Menor Privilégio)
                    │
                    ▼
           [Validação com Usuário] ──► [Encerramento]
```

* **Regra de Ouro de Segurança:** O técnico N1 **nunca** concede acesso administrativo local (Local Admin) ou acesso a pastas financeiras/diretoria sem autorização formal documentada no ticket.
