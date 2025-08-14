# 🎯 CANARY DEPLOYMENTS - Como as Big Companies

## 🚀 **O que é Canary Deploy?**

**Canary Deploy** é a estratégia usada por **Netflix, Amazon, Uber** onde:
- 🎯 Deploy inicial para **5% dos usuários** (canary)
- 📊 **Monitoramento automático** por 10 minutos
- ✅ Se OK → Deploy para **100% dos usuários**
- ❌ Se FAIL → **Rollback automático**

---

## 📁 **Arquivo:** `workflow-canary-deployments.yml`

### 🎯 **Configure apenas 2 linhas:**

#### **Linha 15-16 - Projeto e URL:**
```yaml
# Antes:
PROJECT_NAME: "SEU_PROJETO_AQUI"
SITE_URL: "https://SEU_SITE_AQUI.com/"

# Depois (exemplo):
PROJECT_NAME: "rasparei"
SITE_URL: "https://rasparei.com/"
```

---

## 🎮 **Como Usar:**

### **1. 🚀 Deploy Automático (Padrão):**
```bash
git push origin main
```
**Resultado:**
- ✅ Canary para 5% dos usuários
- 📊 Monitor por 10 minutos
- ✅ Se OK → 100% dos usuários

### **2. 🎯 Deploy Manual com % Customizada:**
```bash
# Via GitHub Actions interface:
- Canary: 25%  (25% dos usuários primeiro)
- Skip Canary: false
```

### **3. 🚀 Deploy Direto (Pular Canary):**
```bash
# Via GitHub Actions interface:
- Skip Canary: true
```
**Resultado:** Deploy direto para 100%

---

## 📊 **Monitoramento Automático:**

### **🔍 Métricas Verificadas:**
- **Taxa de Erro:** < 0.5% (configurável)
- **Latência:** < 2000ms (configurável)
- **Requests:** A cada 30s por 10 minutos
- **HTTP Status:** Deve ser 200

### **⚙️ Configurações (linhas 19-22):**
```yaml
CANARY_DURATION: "600"    # 10 min de canary
MONITOR_DURATION: "300"   # 5 min de monitor
ERROR_THRESHOLD: "0.5"    # 0.5% erro máximo
LATENCY_THRESHOLD: "2000" # 2s latência máxima
```

---

## 🎯 **Fluxo Completo:**

### **✅ Cenário de Sucesso:**
```
1. 🚀 Deploy Canary (5% usuários)
2. 📊 Monitor 10 min → Taxa erro: 0.2% ✅
3. 🚀 Deploy Produção (100% usuários)  
4. 🔍 Health Check → OK ✅
5. 📱 "🎯 CANARY DEPLOY SUCESSO"
```

### **❌ Cenário Canary Falha:**
```
1. 🚀 Deploy Canary (5% usuários)
2. 📊 Monitor 10 min → Taxa erro: 2.1% ❌
3. 🔄 Rollback Automático
4. 📱 "🚨 CANARY REPROVADO - USUÁRIOS PROTEGIDOS"
```

### **❌ Cenário Produção Falha:**
```
1. 🚀 Deploy Canary (5% usuários) → OK ✅
2. 🚀 Deploy Produção (100% usuários) → FAIL ❌
3. 🔄 Rollback Automático
4. 📱 "🚨 PRODUÇÃO FALHOU - INTERVENÇÃO NECESSÁRIA"
```

---

## 📱 **Exemplos de Notificações:**

### **🎯 Início do Canary:**
```
🎯 CANARY DEPLOY INICIADO

🚀 Projeto: rasparei
📊 Canary: 5% dos usuários
⏰ Monitoramento: 600s
🔗 URL: https://rasparei-abc123.vercel.app
📝 Commit: a1b2c3d
```

### **✅ Sucesso Total:**
```
🎯 CANARY DEPLOY SUCESSO: rasparei

✅ Canary aprovado (erro: 0.2%)
✅ Produção funcionando
⚡ Latência: 180ms
🌐 100% dos usuários
📊 Commit: a1b2c3d

🏢 Deploy estilo Big Companies!
```

### **🚨 Canary Reprovado:**
```
🚨 CANARY REPROVADO: rasparei

❌ Canary falhou (erro: 2.1%)
⚡ Latência: 3200ms
🔄 Rollback: true
📊 Commit: a1b2c3d

✅ USUÁRIOS PROTEGIDOS!
```

---

## 🔐 **Secrets Necessários:**
```
VERCEL_TOKEN - Token do Vercel
VERCEL_TEAM_ID - ID da team
VERCEL_SCOPE - Nome da team
TELEGRAM_BOT_TOKEN - Bot do Telegram
TELEGRAM_CHAT_ID - Chat ID
```

---

## 🏢 **Vantagens vs Deploy Normal:**

### **Deploy Normal:**
- ❌ 100% usuários veem erro se falhar
- ❌ Só descobre erro depois de no ar
- ❌ Rollback reativo

### **Canary Deploy:**
- ✅ Só 5% usuários veem erro
- ✅ Descobre erro antes de afetar todos
- ✅ Rollback preventivo
- ✅ **95% dos usuários protegidos!**

---

## 🎯 **Resultado:**

**Você terá o mesmo sistema de deploy que Netflix, Amazon e Uber usam!** 

🏢 **Deploy de Big Company** com proteção máxima para seus usuários! 🛡️
