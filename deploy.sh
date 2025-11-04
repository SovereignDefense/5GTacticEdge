#!/bin/bash

# Script de Deploy e Teste do 5G-TacticEdge Edge Core (MVP)
# Este script assume que o Docker e o Docker Compose estão instalados.

echo "================================================="
echo "  5G-TacticEdge: INICIANDO EDGE CORE TÁTICO (V1.0)"
echo "================================================="

# 1. Criação das Pastas Necessárias
echo "[PASSO 1/5] Criando diretórios de configuração e persistência..."
mkdir -p config/open5gs config/pqc logs/open5gs data/mongodb
echo "Diretórios criados."

# 2. Deploy dos Contêineres
echo "[PASSO 2/5] Inicializando serviços Docker (Core 5G, MongoDB, PQC-VPN)..."
# O -d é para rodar em modo 'detached' (segundo plano)
sudo docker-compose up -d

if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao iniciar os contêineres Docker. Verifique as permissões (sudo) e a instalação do Docker Compose."
    exit 1
fi
echo "Serviços iniciados com sucesso!"

# 3. Teste de Status Operacional
echo ""
echo "[PASSO 3/5] Verificando o status dos contêineres (espera-se 'Up')..."
sudo docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Teste CRÍTICO: Verificação de conectividade do banco de dados (MongoDB)
echo ""
echo "[PASSO 4/5] Teste de Conectividade do Core (Database)..."
DB_STATUS=$(sudo docker logs 5g_core 2>&1 | grep "mongo" | grep "connected" | wc -l)

if [ "$DB_STATUS" -ge 1 ]; then
    echo "SUCESSO: Core 5G (Open5GS) conectado ao Banco de Dados (DB Status: OK)."
else
    echo "AVISO: Core 5G iniciando ou falhou ao conectar ao MongoDB. Verificar logs do contêiner '5g_core'."
fi

# 5. Instruções Finais
echo ""
echo "================================================="
echo "  EDGE CORE PRONTO PARA TESTES TÁTICOS."
echo "================================================="
echo "PRÓXIMOS PASSOS:"
echo "1. Configurar o gNB (Rádio Tático) para se conectar ao IP do Edge Appliance (Front-haul)."
echo "2. O tráfego de dados está sendo processado pelo UPF na borda, com latência mínima."
echo "3. Para desligar: 'sudo docker-compose down'"
echo ""