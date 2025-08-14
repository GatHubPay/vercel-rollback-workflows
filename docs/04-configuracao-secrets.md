# 🔐 Configuração de Secrets - Tokens e Credenciais

## 🎯 **O que são Secrets?**

Secrets são **credenciais seguras** (tokens, senhas, IDs) que o GitHub Actions usa para:
- 🔐 **Fazer deploy** no Vercel
- 📱 **Enviar notificações** no Telegram
- 🔄 **Executar rollbacks** automáticos

**⚠️ IMPORTANTE:** Secrets são **criptografados** e **nunca aparecem nos logs**!

---

## 📋 **Secrets Necessários**

### **🚀 Para Vercel (Deploy):**
```
VERCEL_TOKEN - Token de acesso do Vercel
VERCEL_TEAM_ID - ID da sua team/organização
VERCEL_SCOPE - Nome da sua team/organização
```

### **📱 Para Telegram (Notificações):**
```
TELEGRAM_BOT_TOKEN - Token do bot do Telegram
TELEGRAM_CHAT_ID - ID do chat/canal para notificações
```

---

## 🔧 **Como Obter Cada Secret**

### **1. 🚀 VERCEL_TOKEN**

#### **Passo a Passo:**
1. Ir em [vercel.com/account/tokens](https://vercel.com/account/tokens)
2. Clicar **"Create Token"**
3. Nome: `GitHub Actions Deploy`
4. Scope: **Full Account** (recomendado)
5. Expiration: **No expiration** ou **1 year**
6. Copiar o token gerado

#### **Exemplo:**
```
vercel_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

---

### **2. 🏢 VERCEL_TEAM_ID**

#### **Passo a Passo:**
1. Ir em [vercel.com/teams](https://vercel.com/teams)
2. Selecionar sua **team/organização**
3. Ir em **Settings → General**
4. Copiar **Team ID**

#### **Exemplo:**
```
team_XXXXXXXXXXXXXXXXXXXXXXXX
```

#### **💡 Se não tiver team:**
- Use seu **User ID** pessoal
- Encontrar em: [vercel.com/account](https://vercel.com/account)

---

### **3. 🎯 VERCEL_SCOPE**

#### **Passo a Passo:**
1. Mesmo lugar do Team ID
2. Copiar o **nome da team** (não o ID)
3. Ou usar seu **username** se for pessoal

#### **Exemplo:**
```
minha-empresa
```
ou
```
meu-username
```

---

### **4. 🤖 TELEGRAM_BOT_TOKEN**

#### **Passo a Passo:**
1. Abrir Telegram
2. Procurar **@BotFather**
3. Enviar `/newbot`
4. Escolher nome: `Deploy Bot MinhaSofthouse`
5. Escolher username: `deploy_minhasofthouse_bot`
6. Copiar o token gerado

#### **Exemplo:**
```
1234567890:ABCdefGHIjklMNOpqrsTUVwxyz1234567890
```

---

### **5. 💬 TELEGRAM_CHAT_ID**

#### **Método 1 - Chat Pessoal:**
1. Enviar mensagem para seu bot: `/start`
2. Acessar: `https://api.telegram.org/bot{TOKEN}/getUpdates`
3. Substituir `{TOKEN}` pelo seu bot token
4. Procurar `"chat":{"id":123456789`
5. Copiar o número

#### **Método 2 - Grupo/Canal:**
1. Adicionar bot ao grupo
2. Enviar mensagem mencionando o bot
3. Mesmo processo do método 1
4. ID de grupo começa com `-` (negativo)

#### **Método 3 - Automático:**
```bash
# Use nosso script helper
curl -s "https://api.telegram.org/bot{SEU_TOKEN}/getUpdates" | jq '.result[-1].message.chat.id'
```

#### **Exemplos:**
```
123456789      # Chat pessoal
-987654321     # Grupo
-1001234567890 # Canal
```

---

## ⚙️ **Como Configurar no GitHub**

### **📁 Para 1 Projeto:**
1. Ir no repositório do projeto
2. **Settings → Secrets and variables → Actions**
3. Clicar **"New repository secret"**
4. Adicionar cada secret:

```
Nome: VERCEL_TOKEN
Valor: vercel_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Nome: VERCEL_TEAM_ID  
Valor: team_XXXXXXXXXXXXXXXXXXXXXXXX

Nome: VERCEL_SCOPE
Valor: minha-empresa

Nome: TELEGRAM_BOT_TOKEN
Valor: 1234567890:ABCdefGHIjklMNOpqrsTUVwxyz1234567890

Nome: TELEGRAM_CHAT_ID
Valor: 123456789
```

---

### **🏢 Para Organização/Softhouse:**

#### **✅ RECOMENDADO - Secrets Globais:**
1. Ir na **Organização** GitHub
2. **Settings → Secrets and variables → Actions**
3. **Organization secrets → New organization secret**
4. **Repository access:** `Selected repositories` ou `All repositories`
5. Adicionar todos os secrets

#### **🎯 Vantagens:**
- ✅ **Configurar 1 vez** → funciona em todos projetos
- ✅ **Manutenção centralizada** - mudar token em 1 lugar
- ✅ **Segurança** - devs não veem os tokens
- ✅ **Auditoria** - controle de acesso centralizado

---

## 🧪 **Testar Configuração**

### **1. 🔍 Verificar Vercel:**
```bash
# Testar token Vercel
curl -H "Authorization: Bearer SEU_VERCEL_TOKEN" \
     "https://api.vercel.com/v2/user"
```

### **2. 📱 Testar Telegram:**
```bash
# Testar bot Telegram
curl "https://api.telegram.org/botSEU_BOT_TOKEN/getMe"

# Testar envio de mensagem
curl "https://api.telegram.org/botSEU_BOT_TOKEN/sendMessage?chat_id=SEU_CHAT_ID&text=Teste"
```

### **3. 🚀 Testar Deploy:**
1. Fazer commit simples
2. Verificar GitHub Actions
3. Aguardar notificação Telegram

---

## 🔧 **Troubleshooting**

### **❌ "Invalid Vercel token"**
**Causa:** Token expirado ou inválido
**Solução:**
- Gerar novo token no Vercel
- Verificar se scope está correto
- Atualizar secret no GitHub

### **❌ "Vercel project not found"**
**Causa:** `project_name` errado ou sem acesso
**Solução:**
- Verificar nome exato no Vercel
- Verificar se token tem acesso ao projeto
- Verificar se `VERCEL_SCOPE` está correto

### **❌ "Telegram bot token invalid"**
**Causa:** Token do bot errado
**Solução:**
- Verificar token com @BotFather
- Copiar token completo (com `:`)
- Atualizar secret no GitHub

### **❌ "Chat not found"**
**Causa:** `TELEGRAM_CHAT_ID` errado
**Solução:**
- Verificar ID do chat
- Garantir que bot foi adicionado ao grupo
- Testar envio manual de mensagem

---

## 🛡️ **Segurança e Boas Práticas**

### **✅ Recomendações:**
- 🔄 **Renovar tokens** a cada 6-12 meses
- 👥 **Usar organização** para secrets compartilhados
- 📝 **Documentar** quais projetos usam quais secrets
- 🔍 **Monitorar** uso dos tokens no Vercel
- 🚫 **Nunca commitar** secrets no código

### **⚠️ Se Token Vazar:**
1. **Revogar imediatamente** no Vercel/Telegram
2. **Gerar novo token**
3. **Atualizar secret** no GitHub
4. **Verificar logs** de uso suspeito

---

## 📊 **Exemplo Completo**

### **Para E-commerce "Loja ABC":**
```yaml
# .github/workflows/deploy.yml
jobs:
  deploy:
    uses: minha-org/workflows/.github/workflows/deploy-universal-reusable.yml@main
    with:
      project_name: "loja-abc"
      site_url: "https://loja-abc.com.br/"
    secrets:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: ${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: ${{ secrets.VERCEL_SCOPE }}
      TELEGRAM_BOT_TOKEN: ${{ secrets.TELEGRAM_BOT_TOKEN }}
      TELEGRAM_CHAT_ID: ${{ secrets.TELEGRAM_CHAT_ID }}
```

### **Secrets Configurados:**
```
VERCEL_TOKEN = vercel_1234567890abcdef
VERCEL_TEAM_ID = team_abc123def456
VERCEL_SCOPE = loja-abc-team
TELEGRAM_BOT_TOKEN = 987654321:XYZabc123DEFghi456JKLmno789
TELEGRAM_CHAT_ID = -1001234567890
```

---

**Secrets configurados = Deploy automático funcionando!** 🔐✨
