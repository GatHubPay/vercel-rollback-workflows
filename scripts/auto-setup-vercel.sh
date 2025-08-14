#!/bin/bash

# 🚀 Script Automático de Setup Vercel
# Identifica todos os projetos e teams automaticamente

VERCEL_TOKEN="3L6PRzk55VblXpsy5mDCRs2N"
GITHUB_REPO="GatHubPay/raspaganha-v2"

echo "🔍 Analisando conta Vercel..."
echo "=========================================="

# Buscar informações dos teams
echo "📋 Buscando teams..."
TEAMS_RESPONSE=$(curl -s -H "Authorization: Bearer $VERCEL_TOKEN" \
  "https://api.vercel.com/v2/teams")

echo "$TEAMS_RESPONSE" | jq -r '.teams[]? | "Team: \(.name) | ID: \(.id) | Slug: \(.slug)"' 2>/dev/null || {
  echo "Teams encontrados:"
  echo "$TEAMS_RESPONSE"
}

echo ""
echo "=========================================="

# Buscar todos os projetos
echo "📁 Buscando todos os projetos..."
PROJECTS_RESPONSE=$(curl -s -H "Authorization: Bearer $VERCEL_TOKEN" \
  "https://api.vercel.com/v9/projects")

echo "$PROJECTS_RESPONSE" | jq -r '.projects[]? | "Projeto: \(.name) | ID: \(.id) | Team: \(.accountId // "personal")"' 2>/dev/null || {
  echo "Projetos encontrados:"
  echo "$PROJECTS_RESPONSE"
}

echo ""
echo "=========================================="

# Buscar especificamente o projeto "rasparei"
echo "🎯 Buscando projeto 'rasparei'..."
RASPAREI_INFO=$(echo "$PROJECTS_RESPONSE" | jq -r '.projects[]? | select(.name == "rasparei") | "Nome: \(.name) | ID: \(.id) | Team: \(.accountId // "personal")"' 2>/dev/null)

if [ -n "$RASPAREI_INFO" ]; then
    echo "✅ Projeto rasparei encontrado:"
    echo "$RASPAREI_INFO"
    
    # Extrair team ID do projeto rasparei
    RASPAREI_TEAM=$(echo "$PROJECTS_RESPONSE" | jq -r '.projects[]? | select(.name == "rasparei") | .accountId // "personal"' 2>/dev/null)
    echo "🏢 Team do projeto rasparei: $RASPAREI_TEAM"
    
    # Buscar nome do team
    if [ "$RASPAREI_TEAM" != "personal" ] && [ "$RASPAREI_TEAM" != "null" ]; then
        TEAM_SLUG=$(echo "$TEAMS_RESPONSE" | jq -r --arg teamid "$RASPAREI_TEAM" '.teams[]? | select(.id == $teamid) | .slug' 2>/dev/null)
        echo "🏷️  Team slug: $TEAM_SLUG"
        
        echo ""
        echo "🔧 CONFIGURAÇÃO PARA O GITHUB:"
        echo "=========================================="
        echo "VERCEL_TOKEN: $VERCEL_TOKEN"
        echo "VERCEL_TEAM_ID: $RASPAREI_TEAM"
        echo "VERCEL_SCOPE: $TEAM_SLUG"
        echo "=========================================="
        
        # Gerar comando para adicionar secrets no GitHub
        echo ""
        echo "📋 COMANDOS PARA ADICIONAR SECRETS:"
        echo "=========================================="
        echo "# Usar GitHub CLI (se instalado):"
        echo "gh secret set VERCEL_TEAM_ID --body '$RASPAREI_TEAM' --repo $GITHUB_REPO"
        echo "gh secret set VERCEL_SCOPE --body '$TEAM_SLUG' --repo $GITHUB_REPO"
        echo ""
        echo "# Ou adicionar manualmente no GitHub:"
        echo "# https://github.com/$GITHUB_REPO/settings/secrets/actions"
        echo "# VERCEL_TEAM_ID = $RASPAREI_TEAM"
        echo "# VERCEL_SCOPE = $TEAM_SLUG"
        
    else
        echo "ℹ️  Projeto é pessoal (não está em team)"
        echo ""
        echo "🔧 CONFIGURAÇÃO PARA O GITHUB:"
        echo "=========================================="
        echo "VERCEL_TOKEN: $VERCEL_TOKEN"
        echo "# Não precisa de VERCEL_TEAM_ID nem VERCEL_SCOPE"
        echo "=========================================="
    fi
else
    echo "❌ Projeto 'rasparei' não encontrado!"
    echo ""
    echo "📋 Projetos disponíveis:"
    echo "$PROJECTS_RESPONSE" | jq -r '.projects[]? | .name' 2>/dev/null || echo "$PROJECTS_RESPONSE"
fi

echo ""
echo "=========================================="
echo "✅ Análise completa!"
echo "=========================================="
