#!/bin/bash

# 🔐 Script para Adicionar Secrets Automaticamente no GitHub
# Baseado na análise automática do Vercel

GITHUB_REPO="GatHubPay/raspaganha-v2"
VERCEL_TOKEN="3L6PRzk55VblXpsy5mDCRs2N"
VERCEL_TEAM_ID="team_L1Bv89TVZn7fyYgpNTqTw9uI"
VERCEL_SCOPE="gat-hubs-projects"

echo "🔐 Adicionando secrets no GitHub automaticamente..."
echo "Repository: $GITHUB_REPO"
echo "=========================================="

# Verificar se GitHub CLI está instalado
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI encontrado, adicionando secrets..."
    
    # Verificar se está logado
    if gh auth status &> /dev/null; then
        echo "✅ Usuário logado no GitHub CLI"
        
        # Adicionar secrets
        echo "🔐 Adicionando VERCEL_TEAM_ID..."
        gh secret set VERCEL_TEAM_ID --body "$VERCEL_TEAM_ID" --repo "$GITHUB_REPO"
        
        echo "🔐 Adicionando VERCEL_SCOPE..."
        gh secret set VERCEL_SCOPE --body "$VERCEL_SCOPE" --repo "$GITHUB_REPO"
        
        echo "🔐 Atualizando VERCEL_TOKEN..."
        gh secret set VERCEL_TOKEN --body "$VERCEL_TOKEN" --repo "$GITHUB_REPO"
        
        echo ""
        echo "✅ Secrets adicionados com sucesso!"
        echo "=========================================="
        
        # Listar secrets para confirmar
        echo "📋 Verificando secrets adicionados:"
        gh secret list --repo "$GITHUB_REPO"
        
    else
        echo "❌ Não está logado no GitHub CLI"
        echo "Execute: gh auth login"
        echo ""
        show_manual_instructions
    fi
else
    echo "❌ GitHub CLI não encontrado"
    echo "Instale com: brew install gh"
    echo ""
    show_manual_instructions
fi

show_manual_instructions() {
    echo "📋 INSTRUÇÕES MANUAIS:"
    echo "=========================================="
    echo "Vá para: https://github.com/$GITHUB_REPO/settings/secrets/actions"
    echo ""
    echo "Clique em 'New repository secret' e adicione:"
    echo ""
    echo "1. Nome: VERCEL_TEAM_ID"
    echo "   Valor: $VERCEL_TEAM_ID"
    echo ""
    echo "2. Nome: VERCEL_SCOPE"  
    echo "   Valor: $VERCEL_SCOPE"
    echo ""
    echo "3. Atualizar VERCEL_TOKEN:"
    echo "   Valor: $VERCEL_TOKEN"
    echo "=========================================="
}

echo ""
echo "🚀 Próximos passos:"
echo "1. ✅ Secrets configurados"
echo "2. 📁 Copiar workflow para o repositório"
echo "3. 🧪 Fazer commit para testar deploy"
