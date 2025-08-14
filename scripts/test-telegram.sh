#!/bin/bash

# 📱 Teste das Credenciais do Telegram
# Este script testa se o bot do Telegram está funcionando corretamente

set -e

echo "🤖 Testando Bot do Telegram..."
echo "================================"

# Credenciais configuradas
BOT_TOKEN="8045408592:AAHtPkn2DTPTrL3rs5lLFbV4vhPDEMAqodw"
CHAT_ID="5649252463"

echo "📋 Informações do Bot:"
echo "  Token: ${BOT_TOKEN:0:20}..."
echo "  Chat ID: $CHAT_ID"
echo ""

# Teste 1: Verificar se o bot existe
echo "🔍 Teste 1: Verificando bot..."
BOT_INFO=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getMe")
BOT_STATUS=$(echo "$BOT_INFO" | grep -o '"ok":[^,]*' | cut -d: -f2)

if [ "$BOT_STATUS" = "true" ]; then
    BOT_NAME=$(echo "$BOT_INFO" | grep -o '"username":"[^"]*' | cut -d: -f2 | tr -d '"')
    echo "✅ Bot encontrado: @$BOT_NAME"
else
    echo "❌ Bot não encontrado ou token inválido"
    exit 1
fi

# Teste 2: Verificar histórico de mensagens
echo ""
echo "🔍 Teste 2: Verificando chat..."
UPDATES=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates")
UPDATE_COUNT=$(echo "$UPDATES" | grep -o '"update_id"' | wc -l)

if [ "$UPDATE_COUNT" -gt 0 ]; then
    echo "✅ Chat encontrado com $UPDATE_COUNT mensagens"
else
    echo "⚠️  Nenhuma mensagem encontrada (normal se for primeira vez)"
fi

# Teste 3: Enviar mensagem de teste
echo ""
echo "🔍 Teste 3: Enviando mensagem de teste..."

MESSAGE="🎉 TESTE DO SISTEMA DE DEPLOY

✅ Bot do Telegram funcionando!
🤖 Sistema de rollback automático ativo
📅 Data: $(date)
🚀 Status: Pronto para usar!

Próximos passos:
- Finalizar workflow principal
- Implementar health checks
- Testar rollback automático"

RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d "chat_id=$CHAT_ID" \
    -d "text=$MESSAGE")

SEND_STATUS=$(echo "$RESPONSE" | grep -o '"ok":[^,]*' | cut -d: -f2)

if [ "$SEND_STATUS" = "true" ]; then
    MESSAGE_ID=$(echo "$RESPONSE" | grep -o '"message_id":[0-9]*' | cut -d: -f2)
    echo "✅ Mensagem enviada com sucesso (ID: $MESSAGE_ID)"
    echo "📱 Verifique seu Telegram agora!"
else
    echo "❌ Falha ao enviar mensagem:"
    echo "$RESPONSE"
    exit 1
fi

echo ""
echo "🎉 TODOS OS TESTES PASSARAM!"
echo "================================"
echo "✅ Bot configurado corretamente"
echo "✅ Chat ID válido"
echo "✅ Mensagens sendo enviadas"
echo ""
echo "🚀 Sistema pronto para implementação!"
