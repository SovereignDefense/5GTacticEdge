# 5G-TacticEdge: Guia de Configuração do Edge Core (V1.0)

Este guia detalha os passos para a implantação do Core Network 5G na borda (Edge Core Appliance) usando Open5GS e Docker.

## 1. Pré-Requisitos no Edge Core Appliance

O Appliance deve rodar uma distribuição Linux (ex: Ubuntu Server 22.04 LTS).

1.  **Instalar Docker e Docker Compose:**
    ```bash
    sudo apt update
    sudo apt install docker.io docker-compose -y
    sudo usermod -aG docker $USER
    # Reinicie a sessão
    ```
2.  **Configurar IP e Rotas:**
    O Edge Core Appliance deve ter IPs estáticos para o gNB (Front-haul) e para o Backhaul.
    * Exemplo de interface UPF (User Plane Function) que se conecta ao gNB: `10.45.0.1/16`

## 2. Implantação do Core Network (Open5GS)

Utilizaremos o Docker Compose para subir as funções mínimas do 5G Core.

1.  **Criar o Diretório do Projeto:**
    ```bash
    mkdir 5G-TacticEdge-Core
    cd 5G-TacticEdge-Core
    ```
2.  **Criar o arquivo `docker-compose.yaml` (Exemplo Mínimo):**

    ```yaml
    version: '3.7'
    services:
      # Serviço principal do 5G Core - AMF, SMF, UPF (Open5GS)
      open5gs-core:
        image: open5gs/open5gs:latest
        container_name: 5g_core
        # Usar "host" para roteamento de alto desempenho
        network_mode: host 
        volumes:
          # Mapear configs e logs para persistência
          - ./config:/opt/open5gs/etc
          - ./logs:/opt/open5gs/var/log
        # O comando abaixo deve iniciar os módulos: AMF, SMF, UPF.
        command: ["/bin/bash", "-c", "open5gs-amf & open5gs-smf & open5gs-upf & open5gs-ausf & open5gs-udm & open5gs-udr & open5gs-nrf & wait"]

      # Serviço de Banco de Dados para Open5GS
      mongodb:
        image: mongo:4.4
        container_name: 5g_db
        restart: always
        volumes:
          - ./data:/data/db
        ports:
          - "27017:27017" # Porta padrão
    ```

3.  **Iniciar a Rede Core:**
    ```bash
    sudo docker-compose up -d
    # Verificar o status:
    sudo docker ps
    ```
    *Resultado Esperado: Os containers `5g_core` e `5g_db` devem estar rodando.*

## 3. Próximo Passo Crítico: PQC-VPN Gateway

A integração do *PQC-VPN Gateway* deve ser feita por um contêiner separado (como detalhado no `index.html`) que intercepta o tráfego de dados (via UPF) e o encapsula antes de enviá-lo pelo *Backhaul*. Isso requer a customização da imagem Docker (Libreswan + OQS) e a configuração das políticas IPsec no Edge Core.