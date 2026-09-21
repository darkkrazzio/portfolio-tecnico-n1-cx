# KB-LNX-001: Guia N1 de Diagnóstico Rápido e Troubleshooting no Linux

* **ID do Artigo:** KB-LNX-001
* **Categoria:** Sistema Operacional / Linux
* **Nível:** Suporte N1
* **Data de Revisão:** 21/09/2026

---

## 1. Contexto Operacional N1
Estações de desenvolvimento Ubuntu Desktop ou servidores de aplicação básica baseados em Debian/RedHat. O técnico N1 deve ser capaz de coletar evidências estruturadas, checar processos, verificar armazenamento e restaurar serviços básicos sem degradar o ambiente.

---

## 2. Roteiro de Comandos Essenciais e Interpretação

### A. Diagnóstico de Rede e Conectividade
* `ip addr show` (ou `ip a`): Exibe interfaces, endereços IPv4/IPv6 e status `UP/DOWN`.
* `ip route show`: Mostra a tabela de rotas e o Gateway Padrão (`default via 192.168.1.1`).
* `ping -c 4 192.168.1.1`: Testa alcance da camada 3 limitando a 4 pacotes (evita loop infinito no Linux).
* `ss -tulpn`: Lista portas TCP/UDP em escuta e qual processo está associado (ex: verificar se a porta 80/443 está aberta).
* `curl -I https://portal.empresa.local`: Testa resposta HTTP do servidor sem precisar abrir navegador.
* `dig portal.empresa.local` ou `nslookup portal.empresa.local`: Inspeciona tempo de resposta e registros DNS recebidos.

### B. Diagnóstico de Recursos e Performance
* `df -h`: Exibe a utilização das partições de disco em formato legível para humanos (ex: identificar partição `/` com 100% de uso).
* `free -h`: Exibe o consumo de memória RAM física e área de troca (*Swap*).
* `top` (ou `htop`): Monitor em tempo real de carga da CPU e processos mais consumidores.
* `ps aux | grep [nome_do_processo]`: Localiza o PID exato de um executável travado.

### C. Gerenciamento de Serviços e Logs do Sistema
* `systemctl status [servico]` (ex: `systemctl status apache2` ou `docker`): Exibe se o serviço está ativo (*active - running*), parado (*inactive*) ou com falha (*failed*).
* `sudo systemctl restart [servico]`: Reinicia com segurança o daemon travado.
* `journalctl -u [servico] -n 50 --no-pager`: Extrai as últimas 50 linhas de log do serviço para identificar o motivo da queda.
* `journalctl -xe`: Exibe os logs de erros mais recentes do sistema operacional.

### D. Permissões e Propriedade de Arquivos
* `ls -la /var/www/html`: Inspeciona permissões (`rwx`) e donos (`user:group`).
* `chmod 755 [arquivo]` e `chown [usuario]:[grupo] [arquivo]`: Corrige permissões de execução e leitura respeitando o princípio do menor privilégio (nunca aplicar `chmod 777` em ambiente de produção).

---

## 3. Critérios de Escalonamento (N2 - Linux / DevOps)
* Falhas de inicialização com Kernel Panic ou corrupção do sistema de arquivos (`fsck` manual requerido).
* Necessidade de redimensionamento de LVM (Logical Volume Manager) em servidores de produção.
