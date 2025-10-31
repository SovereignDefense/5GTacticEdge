# 5G-TacticEdge: Rede 5G Privativa Tática de Borda (V1.0 - PVM)

## 🎯 Sumário Executivo

O **5G-TacticEdge** é um projeto de comunicação de defesa/segurança focado na implantação de uma Rede 5G Standalone (SA) de altíssima segurança e baixíssima latência na borda tática (Edge).

Esta Versão 1.0 representa o **Produto Viável Mínimo (PVM)**, com arquitetura definida, códigos de deploy funcionais (Docker Compose) e foco estratégico na segurança Pós-Quântica (PQC), pronto para testes de funcionalidade em laboratório (Proof of Concept).

---

## 💻 Desenvolvido por

**MateusWorkSpace**

---

## 📁 Estrutura do Repositório (PVM)

O repositório está estruturado para permitir apresentação imediata e testes técnicos do Edge Core:

| Arquivo | Conteúdo | Propósito Principal |
| :--- | :--- | :--- |
| `index.html` | Website completo do projeto (Código Único). | **Apresentação Visual** e documentação de alto nível. |
| `PROJECT_PLAN.md` | Detalhamento da Arquitetura, Componentes e KRIs. | **Documento Formal** para gestão e engenharia. |
| `CORE_SETUP_GUIDE.md` | Guia de implementação do 5G Edge Core (Docker/Open5GS). | **Referência Técnica** para instalação em campo. |
| **`docker-compose.yaml`**| Código funcional para iniciar o 5G Edge Core. | **Coração do PVM** (Edge Core Network Functionality). |
| **`deploy.sh`** | Script de shell para deploy rápido e teste de conectividade do Core. | **Teste de Funcionalidade** (MVP Validation). |
| `README.md` | (Este arquivo) | Ponto de partida, sumário e instruções. |

## ⚙️ Como Testar o Produto Viável (MVP)

Assumindo que o Docker e o Docker Compose estão instalados em sua máquina Linux (Edge Core Appliance):

1.  **Acesso e Permissão:** Navegue até o diretório do projeto e garanta permissão de execução ao script:
    ```bash
    cd 5G-TacticEdge-v1.0
    chmod +x deploy.sh
    ```
2.  **Executar o Deploy:** O script irá configurar as pastas e iniciar os contêineres do 5G Core e do Banco de Dados:
    ```bash
    ./deploy.sh
    ```
3.  **Validação:** O script fornecerá o status dos contêineres e confirmará se o `5g_core` está conectado ao banco de dados, indicando que o **Edge Core está operacional e pronto** para receber o tráfego do Rádio Tático (gNB).

## 🚀 Próximos Passos (Apresentação)

Para realizar a apresentação, utilize o `index.html` no navegador, focando nas seções de Latência (< 5ms) e Segurança PQC, e use o `PROJECT_PLAN.md` e o resultado da execução do `deploy.sh` para dar credibilidade técnica.