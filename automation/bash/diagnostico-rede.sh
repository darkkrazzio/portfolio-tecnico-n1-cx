#!/usr/bin/env bash
# ==============================================================================
# N1 Service Desk — Script de Diagnóstico Rápido de Rede e Sistema (Linux)
# Uso: ./diagnostico-rede.sh
# Finalidade: Coleta de evidências não destrutiva para tickets de suporte N1
# ==============================================================================

set -e

CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}==========================================================${NC}"
echo -e "${CYAN}       N1 SERVICE DESK — DIAGNÓSTICO DE REDE (LINUX)       ${NC}"
echo -e "${CYAN}==========================================================${NC}"

echo -e "\n${YELLOW}[1. INFORMAÇÕES DO SISTEMA]${NC}"
echo "Hostname:     $(hostname)"
echo "Kernel:       $(uname -r)"
echo "Uptime:       $(uptime -p)"

echo -e "\n${YELLOW}[2. INTERFACES DE REDE E ENDEREÇOS IP]${NC}"
ip -4 -o addr show | awk '{print "Interface: "$2" | IP: "$4}'

echo -e "\n${YELLOW}[3. ROTA PADRÃO (GATEWAY)]${NC}"
ip route | grep default || echo -e "${RED}Nenhuma rota padrão configurada!${NC}"

echo -e "\n${YELLOW}[4. SERVIDORES DNS CONFIGURADOS]${NC}"
if [ -f /etc/resolv.conf ]; then
    grep nameserver /etc/resolv.conf
else
    echo "Arquivo /etc/resolv.conf não encontrado."
fi

echo -e "\n${YELLOW}[5. TESTES DE CONECTIVIDADE ICMP]${NC}"
for target in 127.0.0.1 1.1.1.1 8.8.8.8; do
    if ping -c 2 -W 2 "$target" > /dev/null 2>&1; then
        echo -e "Ping para $target: [${GREEN}OK${NC}]"
    else
        echo -e "Ping para $target: [${RED}FALHA${NC}]"
    fi
done

echo -e "\n${YELLOW}[6. RESOLUÇÃO DE NOMES (DNS)]${NC}"
if nslookup google.com > /dev/null 2>&1; then
    echo -e "Resolução DNS externa (google.com): [${GREEN}OK${NC}]"
else
    echo -e "Resolução DNS externa (google.com): [${RED}FALHA${NC}]"
fi

echo -e "\n${YELLOW}[7. UTILIZAÇÃO DE DISCO]${NC}"
df -h / | awk 'NR==1 || NR==2 {print $0}'

echo -e "\n${CYAN}==========================================================${NC}"
echo -e "${CYAN}Diagnóstico concluído. Cole este bloco no chamado ITSM.${NC}"
echo -e "${CYAN}==========================================================${NC}"
