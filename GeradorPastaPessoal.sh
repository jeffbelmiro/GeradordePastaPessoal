#!/bin/bash

# Array para armazenar os nomes das pastas raiz
PASTAS_RAIZ=()

echo "=========================================="
echo "   GERADOR DE ESTRUTURA DE PASTAS        "
echo "=========================================="
echo ""

# FASE 1: Coleta dos nomes das pessoas/pastas
while true; do
    read -p "Digite o nome da pessoa (ou aperte Enter para usar data e horario): " NOME_PESSOA

    # Se o usuario nao digitar nada, gera o formato AAAAMMDDhhmm
    if [ -z "$NOME_PESSOA" ]; then
        RAIZ=$(date +"%Y%m%d%H%M")
        PASTAS_RAIZ+=("$RAIZ")
    else
        # Validador: permite apenas letras, numeros, espacos, hifens e underlines
        if [[ "$NOME_PESSOA" =~ ^[a-zA-Z0-9[:space:]_-]+$ ]]; then
            PASTAS_RAIZ+=("$NOME_PESSOA")
        else
            echo "❌ Erro: O nome contém caracteres inválidos ou especiais."
            echo "💡 Dica: Use apenas letras, números, espaços, hífens (-) ou underlines (_)."
            echo ""
            continue
        fi
    fi

    # Pergunta se deseja cadastrar mais uma pasta
    echo ""
    read -p "Deseja criar mais alguma outra pasta raiz de outra pessoa? (Y/N): " RESPOSTA
    echo ""

    # Converte a resposta para maiuscula
    RESPOSTA=$(echo "$RESPOSTA" | tr '[:lower:]' '[:upper:]')

    # Se a resposta nao for Y, encerra o loop de perguntas e vai para a criacao
    if [ "$RESPOSTA" != "Y" ]; then
        break
    fi
done

# FASE 2: Criacao de todas as pastas acumuladas
echo "=========================================="
echo "Iniciando a criação das pastas raiz..."
echo "=========================================="

for RAIZ in "${PASTAS_RAIZ[@]}"; do
    echo "📁 Criando estrutura em: ./$RAIZ ..."

    mkdir -p "$RAIZ"/{ \
        00_Central/Inbox, \
        00_Central/Anotacoes&Acessos, \
        01_DocumentosPessoais/Identificacao, \
        01_DocumentosPessoais/Endereco&Comprovantes, \
        01_DocumentosPessoais/Impostos&Declaracoes, \
        02_Carreira&Estudos/Curriculos&Portfolio, \
        02_Carreira&Estudos/Cursos&Certificados, \
        02_Carreira&Estudos/ProjetosProfissionais, \
        03_Financas/Orcamento&Controle, \
        03_Financas/Contas&Comprovantes, \
        03_Financas/Investimentos&Bancos, \
        04_Saude&BemEstar/Exames&Consultas, \
        04_Saude&BemEstar/HistoricoDeVacinas, \
        04_Saude&BemEstar/PlanosDeSaude&Seguros, \
        05_Casa&Veiculos/Moradia, \
        05_Casa&Veiculos/Veiculo, \
        06_ProjetosPessoais/Viagens, \
        06_ProjetosPessoais/Eventos&Casamentos, \
        06_ProjetosPessoais/Hobbies&Interesses, \
        99_ArquivoHistorico/AnosAnteriores, \
        99_ArquivoHistorico/Fotos&Memorias \
    }
done

echo ""
echo "✅ Todas as estruturas foram criadas com sucesso!"
