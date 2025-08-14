#!/bin/bash

# 🔍 Script para Debugar Telegram
# Investiga por que as notificações não estão chegando

echo "🔍 INVESTIGANDO PROBLEMA DO TELEGRAM"
echo "====================================="

# 1. Verificar se os secrets estão configurados
echo "1. 📋 Verificando secrets no GitHub..."
echo "Vá para: https://github.com/GatHubPay/raspaganha-v2/settings/secrets/actions"
echo "Verifique se existem:"
echo "- TELEGRAM_BOT_TOKEN ✓"
echo "- TELEGRAM_CHAT_ID ✓"
echo ""

# 2. Testar bot token (se fornecido)
if [ ! -z "$1" ] && [ ! -z "$2" ]; then
    BOT_TOKEN="$1"
    CHAT_ID="$2"
    
    echo "2. 🤖 Testando bot token..."
    BOT_INFO=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getMe")
    
    if echo "$BOT_INFO" | grep -q '"ok":true'; then
        BOT_NAME=$(echo "$BOT_INFO" | grep -o '"username":"[^"]*"' | cut -d'"' -f4)
        echo "✅ Bot token válido: @$BOT_NAME"
    else
        echo "❌ Bot token inválido!"
        echo "Resposta: $BOT_INFO"
        echo ""
        echo "🔧 Como corrigir:"
        echo "1. Vá para @BotFather no Telegram"
        echo "2. Digite /newbot ou /mybots"
        echo "3. Pegue o token correto"
        echo "4. Atualize o secret TELEGRAM_BOT_TOKEN"
        exit 1
    fi
    
    echo ""
    echo "3. 💬 Testando envio de mensagem..."
    TEST_MESSAGE="🧪 Teste de conectividade - $(date)"
    
    RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$TEST_MESSAGE")
    
    if echo "$RESPONSE" | grep -q '"ok":true'; then
        echo "✅ Mensagem enviada com sucesso!"
        echo "Verifique seu Telegram agora"
    else
        echo "❌ Falha ao enviar mensagem!"
        echo "Resposta: $RESPONSE"
        echo ""
        
        if echo "$RESPONSE" | grep -q "chat not found"; then
            echo "🔧 PROBLEMA: Chat ID incorreto"
            echo ""
            echo "Como encontrar o Chat ID correto:"
            echo "1. Envie uma mensagem para seu bot no Telegram"
            echo "2. Acesse: https://api.telegram.org/bot$BOT_TOKEN/getUpdates"
            echo "3. Procure por 'chat':{'id': NUMERO"
            echo "4. Use esse número como TELEGRAM_CHAT_ID"
        elif echo "$RESPONSE" | grep -q "bot was blocked"; then
            echo "🔧 PROBLEMA: Bot foi bloqueado"
            echo "1. Vá para o chat com seu bot no Telegram"
            echo "2. Digite /start"
            echo "3. Teste novamente"
        else
            echo "🔧 PROBLEMA: Erro desconhecido"
            echo "Verifique os secrets no GitHub"
        fi
        exit 1
    fi
    
else
    echo "2. ⚠️  Para testar, execute:"
    echo "./debug-telegram.sh SEU_BOT_TOKEN SEU_CHAT_ID"
    echo ""
fi

echo ""
echo "4. 🔍 Verificando logs do GitHub Actions..."
echo "Vá para: https://github.com/GatHubPay/raspaganha-v2/actions"
echo "Clique na última execução do workflow"
echo "Procure por mensagens como:"
echo "- '📱 Telegram falhou'"
echo "- 'curl: command failed'"
echo "- Erros de conectividade"

echo ""
echo "5. 📋 Checklist de verificação:"
echo "□ Bot token está correto no GitHub"
echo "□ Chat ID está correto no GitHub"
echo "□ Bot não foi bloqueado no Telegram"
echo "□ Workflow está executando (sem erros de sintaxe)"
echo "□ Secrets estão acessíveis no workflow"

echo ""
echo "6. 🔧 Soluções comuns:"
echo ""
echo "PROBLEMA: Bot token inválido"
echo "SOLUÇÃO: Pegue novo token do @BotFather"
echo ""
echo "PROBLEMA: Chat ID errado"
echo "SOLUÇÃO: Use https://api.telegram.org/botTOKEN/getUpdates"
echo ""
echo "PROBLEMA: Bot bloqueado"
echo "SOLUÇÃO: Digite /start no chat do bot"
echo ""
echo "PROBLEMA: Secrets não acessíveis"
echo "SOLUÇÃO: Verifique se estão no repositório correto"

echo ""
echo "====================================="
echo "🎯 PRÓXIMOS PASSOS:"
echo "1. Execute este script com seus tokens para testar"
echo "2. Verifique os logs do GitHub Actions"
echo "3. Corrija os problemas encontrados"
echo "4. Teste novamente fazendo um commit"
echo "====================================="
