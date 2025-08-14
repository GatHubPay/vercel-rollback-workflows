#!/bin/bash

# 🚀 Script para Gerar Workflows para Todos os Projetos
# Baseado na análise automática do Vercel

VERCEL_TOKEN="3L6PRzk55VblXpsy5mDCRs2N"
VERCEL_TEAM_ID="team_L1Bv89TVZn7fyYgpNTqTw9uI"
VERCEL_SCOPE="gat-hubs-projects"

echo "🚀 Gerando workflows para todos os projetos encontrados..."
echo "=========================================="

# Array com todos os projetos encontrados
declare -a PROJECTS=(
    "rasparei"
    "raspadinav2producao" 
    "abrao-silva-advocacia"
    "gateways"
    "gateway-v2"
    "tiovideos"
    "v0-glow"
    "v0-next-js-layout-redesign"
    "v0-teste1"
    "v0-dash"
    "v0-novo-designer-gateway"
    "v0-gateway"
    "oneshotaicreator"
    "v0-modern-landing-page"
    "vemdebox"
    "caixasmisteriosas1"
    "jogo-do-bico"
    "rifa"
    "caixasmisteriosas"
)

# Criar diretório para os workflows
mkdir -p generated-workflows

echo "📁 Gerando workflows individuais..."

for project in "${PROJECTS[@]}"; do
    echo "🔧 Gerando workflow para: $project"
    
    # Determinar tipo de template baseado no nome
    template_type="basic"
    if [[ $project == *"caixa"* ]] || [[ $project == *"jogo"* ]] || [[ $project == *"raspa"* ]]; then
        template_type="caixabox"
    elif [[ $project == *"gateway"* ]]; then
        template_type="gateway"
    elif [[ $project == *"rifa"* ]]; then
        template_type="casa-apostas"
    fi
    
    # Gerar workflow
    cat > "generated-workflows/${project}-deploy.yml" << EOF
# 🚀 Deploy $project - Workflow Gerado Automaticamente
# Tipo: $template_type

name: Deploy $project

on:
  push:
    branches: [main, master]
  workflow_dispatch:

jobs:
  deploy:
    uses: GatHubPay/vercel-rollback-workflows/.github/workflows/vercel-rollback.yml@main
    with:
      vercelProject: "$project"
      routes: "/,/api/health"
      healthCheckTimeout: 45
      maxRetries: 3
      enablePostDeployMonitoring: true
      monitoringDurationMinutes: 15
      monitoringIntervalMinutes: 5
      
    secrets:
      VERCEL_TOKEN: \${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: \${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: \${{ secrets.VERCEL_SCOPE }}
      TELEGRAM_BOT_TOKEN: \${{ secrets.TELEGRAM_BOT_TOKEN }}
      TELEGRAM_CHAT_ID: \${{ secrets.TELEGRAM_CHAT_ID }}
EOF

done

echo ""
echo "✅ Workflows gerados para ${#PROJECTS[@]} projetos!"
echo "📁 Localização: generated-workflows/"
echo ""
echo "📋 Projetos processados:"
for project in "${PROJECTS[@]}"; do
    echo "  ✅ $project"
done

echo ""
echo "=========================================="
echo "🎯 PRÓXIMOS PASSOS:"
echo "=========================================="
echo "1. ✅ Secrets já configurados automaticamente"
echo "2. 📁 Workflows gerados em generated-workflows/"
echo "3. 🚀 Para implementar em um projeto específico:"
echo "   - Copie o arquivo correspondente para .github/workflows/"
echo "   - Faça commit e push"
echo "   - O deploy será executado automaticamente!"
echo ""
echo "🎮 FOCO NO RASPAGANHA-V2:"
echo "Arquivo principal: raspaganha-v2-workflow-final.yml"
echo "Copie para: .github/workflows/deploy-caixabox.yml"
echo "No repositório: https://github.com/GatHubPay/raspaganha-v2"
echo "=========================================="
