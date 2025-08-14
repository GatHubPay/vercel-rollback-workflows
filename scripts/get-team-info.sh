#!/bin/bash

# 🔍 Script para descobrir VERCEL_TEAM_ID
# Execute este comando para descobrir o team ID

echo "🔍 Descobrindo informações do team Vercel..."
echo ""
echo "Execute este comando (substitua SEU_VERCEL_TOKEN):"
echo ""
echo "curl -H \"Authorization: Bearer SEU_VERCEL_TOKEN\" \\"
echo "  \"https://api.vercel.com/v2/teams\""
echo ""
echo "Procure pelo team 'gat-hubs-projects' na resposta e copie o 'id'"
echo ""
echo "Exemplo de resposta:"
echo "{"
echo "  \"teams\": ["
echo "    {"
echo "      \"id\": \"team_xxxxxxxxx\","
echo "      \"slug\": \"gat-hubs-projects\","
echo "      \"name\": \"Gat Hub's Projects\""
echo "    }"
echo "  ]"
echo "}"
echo ""
echo "✅ O 'id' é o seu VERCEL_TEAM_ID"
echo "✅ O 'slug' é o seu VERCEL_SCOPE"
