# 🔐 Setup da Organização GatHubPay

## 🎯 **Configurar Secrets da Organização**

### **📍 Local:** GitHub.com → Organizations → GatHubPay → Settings → Secrets and variables → Actions

### **🔑 Secrets Obrigatórios:**

```
VERCEL_TOKEN
├── Valor: seu_token_vercel_aqui
├── Acesso: Full Account
└── Expiração: Never (recomendado)

VERCEL_TEAM_ID  
├── Valor: team_xxxxxxxxxxxxxxxx
└── Como obter: vercel.com/account/team

VERCEL_SCOPE
├── Valor: GatHubPay
└── Nome exato da sua team/organização

TELEGRAM_BOT_TOKEN
├── Valor: 1234567890:AAAAAAAAAAAAAAAAAAAAAAAAAA
└── Como obter: @BotFather no Telegram

TELEGRAM_CHAT_ID
├── Valor: -1001234567890 (para grupos)
├── Valor: 123456789 (para chat pessoal)
└── Como obter: envie mensagem para bot e acesse:
    https://api.telegram.org/botSEU_TOKEN/getUpdates
```

---

## 🚀 **Passo a Passo:**

### **1. 🔑 Obter Token Vercel:**
```bash
# 1. Ir para: https://vercel.com/account/tokens
# 2. "Create Token" 
# 3. Nome: "GatHubPay Deploy Bot"
# 4. Scope: "Full Account"
# 5. Expiration: "No Expiration"
# 6. Copiar token
```

### **2. 📱 Criar Bot Telegram:**
```
1. Abrir Telegram
2. Procurar: @BotFather
3. Comando: /newbot
4. Nome: "GatHubPay Deploy Bot"
5. Username: "gathubpay_deploy_bot"
6. Copiar token: 1234567890:AAAAA...
```

### **3. 🆔 Obter Chat ID:**
```bash
# Método 1 - Chat Pessoal:
# 1. Enviar mensagem para seu bot
# 2. Acessar: https://api.telegram.org/botSEU_TOKEN/getUpdates
# 3. Procurar "chat":{"id":123456789}

# Método 2 - Grupo (Recomendado):
# 1. Criar grupo "GatHubPay Deploys"
# 2. Adicionar o bot no grupo
# 3. Enviar mensagem no grupo
# 4. Acessar: https://api.telegram.org/botSEU_TOKEN/getUpdates
# 5. Procurar "chat":{"id":-1001234567890}
```

### **4. 🏢 Configurar na Organização:**
```
GitHub.com → Organizations → GatHubPay → Settings → 
Secrets and variables → Actions → Organization secrets

➕ New organization secret:
├── VERCEL_TOKEN: vercel_xxxxxxxx
├── VERCEL_TEAM_ID: team_xxxxxxxx  
├── VERCEL_SCOPE: GatHubPay
├── TELEGRAM_BOT_TOKEN: 1234567890:AAAAA
└── TELEGRAM_CHAT_ID: -1001234567890

Repository access: Selected repositories
✅ Selecionar TODOS os repositórios de projetos
```

---

## ✅ **Testar Configuração:**

### **🧪 Teste Manual:**
```bash
# Testar Vercel:
curl -H "Authorization: Bearer SEU_VERCEL_TOKEN" \
     "https://api.vercel.com/v2/user"

# Testar Telegram:
curl "https://api.telegram.org/botSEU_BOT_TOKEN/sendMessage?chat_id=SEU_CHAT_ID&text=Teste%20GatHubPay"
```

### **🚀 Teste Real:**
```bash
# 1. Fazer commit em qualquer projeto
# 2. Verificar se deploy funciona
# 3. Verificar se notificação chega no Telegram
```

---

## 🎯 **Resultado Final:**

✅ **Todos os 10+ projetos** vão herdar os secrets automaticamente
✅ **Uma configuração** → todos projetos funcionando  
✅ **Manutenção zero** de secrets individuais
✅ **Segurança centralizada** na organização

---

**Pronto para configurar os secrets!** 🔐✨
