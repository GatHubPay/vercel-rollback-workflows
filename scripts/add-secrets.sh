#!/bin/bash

# 🚀 SCRIPT PARA ADICIONAR SECRETS AUTOMATICAMENTE
# Adiciona VERCEL_TOKEN, TELEGRAM_BOT_TOKEN e TELEGRAM_CHAT_ID em todos os projetos

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 ADICIONANDO SECRETS AUTOMATICAMENTE${NC}"
echo "=================================="

# Verificar se GitHub CLI está instalado
if ! command -v gh &> /dev/null; then
    echo -e "${RED}❌ GitHub CLI não está instalado!${NC}"
    echo "Instale com: brew install gh"
    echo "Depois faça login: gh auth login"
    exit 1
fi

# Verificar se está logado
if ! gh auth status &> /dev/null; then
    echo -e "${RED}❌ Não está logado no GitHub CLI!${NC}"
    echo "Execute: gh auth login"
    exit 1
fi

# Solicitar token da Vercel
echo -e "${YELLOW}🔑 Digite seu token da Vercel:${NC}"
read -s VERCEL_TOKEN
echo ""

# Verificar se o token foi fornecido
if [ -z "$VERCEL_TOKEN" ]; then
    echo -e "${RED}❌ Token da Vercel é obrigatório!${NC}"
    exit 1
fi

# Tokens fixos do Telegram
TELEGRAM_BOT_TOKEN="8045408592:AAHtPkn2DTPTrL3rs5lLFbV4vhPDEMAqodw"
TELEGRAM_CHAT_ID="5649252463"

echo -e "${GREEN}✅ Tokens configurados:${NC}"
echo "   Vercel: ${VERCEL_TOKEN:0:10}..."
echo "   Telegram Bot: ${TELEGRAM_BOT_TOKEN}"
echo "   Telegram Chat: ${TELEGRAM_CHAT_ID}"
echo ""

# Lista de projetos (ajuste conforme necessário)
PROJECTS=(
    "raspaganha-v2"
    # Adicione mais projetos aqui
)

echo -e "${BLUE}📋 Projetos para configurar:${NC}"
for project in "${PROJECTS[@]}"; do
    echo "   - $project"
done
echo ""

# Perguntar se quer continuar
echo -e "${YELLOW}⚠️  ATENÇÃO: Isso vai adicionar secrets em TODOS os projetos listados!${NC}"
read -p "Continuar? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}❌ Operação cancelada!${NC}"
    exit 0
fi

echo ""
echo -e "${BLUE}🚀 Iniciando configuração...${NC}"
echo "=================================="

# Contador de sucessos e falhas
SUCCESS=0
FAILED=0

# Para cada projeto
for project in "${PROJECTS[@]}"; do
    echo -e "${BLUE}📁 Configurando: $project${NC}"
    
    # Tentar adicionar VERCEL_TOKEN
    if gh secret set VERCEL_TOKEN --body "$VERCEL_TOKEN" --repo "GatHubPay/$project" &> /dev/null; then
        echo -e "   ✅ VERCEL_TOKEN adicionado"
    else
        echo -e "   ❌ Falha ao adicionar VERCEL_TOKEN"
        ((FAILED++))
        continue
    fi
    
    # Tentar adicionar TELEGRAM_BOT_TOKEN
    if gh secret set TELEGRAM_BOT_TOKEN --body "$TELEGRAM_BOT_TOKEN" --repo "GatHubPay/$project" &> /dev/null; then
        echo -e "   ✅ TELEGRAM_BOT_TOKEN adicionado"
    else
        echo -e "   ❌ Falha ao adicionar TELEGRAM_BOT_TOKEN"
        ((FAILED++))
        continue
    fi
    
    # Tentar adicionar TELEGRAM_CHAT_ID
    if gh secret set TELEGRAM_CHAT_ID --body "$TELEGRAM_CHAT_ID" --repo "GatHubPay/$project" &> /dev/null; then
        echo -e "   ✅ TELEGRAM_CHAT_ID adicionado"
        ((SUCCESS++))
        echo -e "   🎉 $project configurado com sucesso!"
    else
        echo -e "   ❌ Falha ao adicionar TELEGRAM_CHAT_ID"
        ((FAILED++))
    fi
    
    echo ""
done

# Resumo final
echo "=================================="
echo -e "${GREEN}🎉 CONFIGURAÇÃO CONCLUÍDA!${NC}"
echo -e "${GREEN}✅ Sucessos: $SUCCESS${NC}"
echo -e "${RED}❌ Falhas: $FAILED${NC}"

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎯 Todos os projetos foram configurados com sucesso!${NC}"
else
    echo -e "${YELLOW}⚠️  Alguns projetos falharam. Verifique os logs acima.${NC}"
fi

echo ""
echo -e "${BLUE}📋 PRÓXIMOS PASSOS:${NC}"
echo "1. Adicionar o workflow (.github/workflows/) em cada projeto"
echo "2. Escolher o template apropriado"
echo "3. Configurar as rotas específicas"
echo "4. Fazer deploy para testar"
