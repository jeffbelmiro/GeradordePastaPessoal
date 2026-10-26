#!/bin/bash

# Captura o diretorio atual de execucao
DIR_ATUAL=$(pwd)

# Array para armazenar os nomes das pastas raiz (limite maximo de 5)
PASTAS_RAIZ=()
LIMITE_MAX=5

echo "=========================================="
echo "   GERADOR DE ESTRUTURA DE PASTAS        "
echo "=========================================="
echo "📍 Diretório de execução: $DIR_ATUAL"
echo ""

# FASE 1: Coleta dos nomes das pessoas/pastas
CONTINUAR_COLETA=true

while [ "$CONTINUAR_COLETA" = true ]; do
    read -p "Digite o nome da pessoa (ou aperte Enter para usar data e horario): " NOME_PESSOA

    # Se o usuario nao digitar nada, gera o formato AAAAMMDDhhmm
    if [ -z "$NOME_PESSOA" ]; then
        NOME_FINAL=$(date +"%Y%m%d%H%M")
    else
        # Validador: permite apenas letras, numeros, espacos, hifens e underlines
        if [[ "$NOME_PESSOA" =~ ^[a-zA-Z0-9[:space:]_-]+$ ]]; then
            # Formata para Title Case (cada palavra com inicial maiuscula) de forma portavel
            NOME_FINAL=""
            for PALAVRA in $NOME_PESSOA; do
                PRIMEIRA_LETRA=$(echo "${PALAVRA:0:1}" | tr '[:lower:]' '[:upper:]')
                RESTO=$(echo "${PALAVRA:1}" | tr '[:upper:]' '[:lower:]')
                NOME_FINAL="$NOME_FINAL $PRIMEIRA_LETRA$RESTO"
            done
            # Remove espaco extra do inicio
            NOME_FINAL=$(echo "$NOME_FINAL" | sed 's/^ //')
        else
            echo "❌ Erro: O nome contém caracteres inválidos ou especiais."
            echo "💡 Dica: Use apenas letras, números, espaços, hífens (-) ou underlines (_)."
            echo ""
            continue
        fi
    fi

    # Adiciona e acumula o nome validado no array
    PASTAS_RAIZ+=("$NOME_FINAL")

    TOTAL_ATUAL=${#PASTAS_RAIZ[@]}

    # Verifica se atingiu o limite maximo de 5 pastas
    if [ $TOTAL_ATUAL -ge $LIMITE_MAX ]; then
        echo ""
        echo "⚠️  Atenção: Você atingiu o limite máximo de $LIMITE_MAX pastas raiz!"
        break
    fi

    # Loop de validacao da resposta para adicionar mais nomes (Y/N)
    while true; do
        echo ""
        read -p "Deseja criar mais alguma outra pasta raiz de outra pessoa? (Y/N): " RESPOSTA
        
        RESPOSTA_MAIUSCULA=$(echo "$RESPOSTA" | tr '[:lower:]' '[:upper:]')

        if [ "$RESPOSTA_MAIUSCULA" = "Y" ]; then
            echo ""
            break # Volta para o loop principal e pede outro nome
        elif [ "$RESPOSTA_MAIUSCULA" = "N" ]; then
            CONTINUAR_COLETA=false # Para a coleta e encerra o loop principal
            break
        else
            echo "❌ Opção inválida! Digite apenas 'Y' (Sim) ou 'N' (Não)."
        fi
    done
done

# FASE 2: Resumo e Confirmacao Final
echo ""
echo "========================================================================"
echo "           RESUMO E LOCAL DE CRIAÇÃO                                   "
echo "========================================================================"
echo "📂 As pastas abaixo serão criadas dentro do seguinte diretório:"
echo "👉 $DIR_ATUAL"
echo "------------------------------------------------------------------------"
echo "Lista de pasta(s) raiz a criar (${#PASTAS_RAIZ[@]} no total):"

CONTADOR=1
for PASTA in "${PASTAS_RAIZ[@]}"; do
    echo "  $CONTADOR. $DIR_ATUAL/$PASTA"
    CONTADOR=$((CONTADOR + 1))
done

echo "========================================================================"
echo ""

# Loop de confirmacao para iniciar a criacao
while true; do
    read -p "Deseja confirmar a criação de todas as pastas listadas no local acima? (Y/N): " CONFIRMACAO
    CONFIRMACAO_MAIUSCULA=$(echo "$CONFIRMACAO" | tr '[:lower:]' '[:upper:]')

    if [ "$CONFIRMACAO_MAIUSCULA" = "Y" ]; then
        break
    elif [ "$CONFIRMACAO_MAIUSCULA" = "N" ]; then
        echo ""
        echo "🚫 Operação cancelada pelo usuário. Nenhuma pasta foi criada."
        exit 0
    else
        echo "❌ Opção inválida! Digite apenas 'Y' (Sim) ou 'N' (Não)."
    fi
done

# FASE 3: Criacao de todas as pastas acumuladas no diretorio atual
echo ""
echo "=========================================="
echo "Iniciando a criação das pastas raiz..."
echo "=========================================="

for RAIZ in "${PASTAS_RAIZ[@]}"; do
    DESTINO="$DIR_ATUAL/$RAIZ"
    echo "📁 Criando estrutura em: $DESTINO"

    # Criacao forçada da pasta raiz e subpastas com hifen
    mkdir -p "$DESTINO/DocumentosPessoais/Identificacao"
    mkdir -p "$DESTINO/DocumentosPessoais/Endereco-Comprovantes"
    mkdir -p "$DESTINO/DocumentosPessoais/Impostos-Declaracoes"

    mkdir -p "$DESTINO/Carreira-Estudos/Curriculos-Portfolio"
    mkdir -p "$DESTINO/Carreira-Estudos/Cursos-Certificados"
    mkdir -p "$DESTINO/Carreira-Estudos/ProjetosProfissionais"

    mkdir -p "$DESTINO/Financas/Orcamento-Controle"
    mkdir -p "$DESTINO/Financas/Contas-Comprovantes"
    mkdir -p "$DESTINO/Financas/Investimentos-Bancos"

    mkdir -p "$DESTINO/Saude-BemEstar/Exames-Consultas"
    mkdir -p "$DESTINO/Saude-BemEstar/HistoricoDeVacinas"
    mkdir -p "$DESTINO/Saude-BemEstar/PlanosDeSaude-Seguros"

    mkdir -p "$DESTINO/Casa-Veiculos/Moradia"
    mkdir -p "$DESTINO/Casa-Veiculos/Veiculo"

    mkdir -p "$DESTINO/ProjetosPessoais/Viagens"
    mkdir -p "$DESTINO/ProjetosPessoais/Eventos-Casamentos"
    mkdir -p "$DESTINO/ProjetosPessoais/Hobbies-Interesses"

    mkdir -p "$DESTINO/ArquivoHistorico/AnosAnteriores"
    mkdir -p "$DESTINO/ArquivoHistorico/Fotos-Memorias"
done

echo ""
echo "✅ Todas as estruturas e subpastas foram criadas com sucesso no diretório atual!"
