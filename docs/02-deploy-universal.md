# 🚀 Deploy Universal - Para Qualquer Projeto

## 🎯 **O que é Deploy Universal?**

Deploy padrão profissional com:
- 🚀 **Deploy direto** para produção
- 🔍 **Health check rigoroso** (verifica se site funciona)
- 🔄 **Rollback automático** se falhar
- 📱 **Notificações detalhadas** no Telegram
- ⚡ **Rápido e confiável** (2-3 minutos)

**Ideal para:** Landing pages, portfolios, blogs, sites normais

---

## 📋 **Como Configurar**

### **1. 📁 Copiar template:**
```bash
# De: ../templades/template-projeto-softhouse.yml
# Para: .github/workflows/deploy.yml
```

### **2. ✏️ Configurar projeto:**
```yaml
name: Deploy Projeto

on:
  push:
    branches: [main, master]
  workflow_dispatch:

jobs:
  deploy:
    uses: SuaSofthouse/workflows/.github/workflows/deploy-universal-reusable.yml@main
    with:
      # 🎯 CONFIGURE APENAS ESTAS 2 LINHAS:
      project_name: "MEU_PROJETO"              # ← Nome no Vercel
      site_url: "https://meusite.com/"         # ← URL do site
      
      # ⚙️ OPCIONAIS (customize se necessário):
      environment: "production"                # production/staging
      health_check_timeout: 30                 # segundos para timeout
      enable_rollback: true                    # ativar rollback automático
      
    secrets:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: ${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: ${{ secrets.VERCEL_SCOPE }}
      TELEGRAM_BOT_TOKEN: ${{ secrets.TELEGRAM_BOT_TOKEN }}
      TELEGRAM_CHAT_ID: ${{ secrets.TELEGRAM_CHAT_ID }}
```

---

## 🔍 **Health Check Profissional**

### **✅ Verificações Automáticas:**

#### **1. 📊 Disponibilidade:**
- Status HTTP deve ser **200**
- Tempo de resposta < **5 segundos**
- Site deve estar acessível

#### **2. 📄 Conteúdo:**
- Página deve ter conteúdo (> 1000 chars)
- Não pode ter erros visíveis:
  - "500 Internal Server Error"
  - "Application Error"  
  - "Fatal Error"
  - "BAILOUT_TO_CLIENT_SIDE_RENDERING"

#### **3. 🔄 Se Falhar:**
- **Rollback automático** para versão anterior
- **Notificação detalhada** do erro
- **Site continua funcionando** (versão anterior)

---

## 📱 **Notificações Telegram**

### **🚀 Deploy Iniciado:**
```
🚀 Deploy production iniciado

🏢 Projeto: meu-projeto
🌐 Site: https://meusite.com/
📊 Commit: a1b2c3d
👤 Por: developer
🔄 Aguardando health check...
```

### **✅ Deploy Sucesso:**
```
✅ meu-projeto - FUNCIONANDO!

🏢 Deploy profissional concluído
🌐 Site: https://meusite.com/
📊 Status: 200
⚡ Tempo: 1.8s
📊 Commit: a1b2c3d

🎯 Deploy estilo Big Companies!
```

### **🔄 Rollback Executado:**
```
🔄 ROLLBACK EXECUTADO!

🏢 Projeto: meu-projeto
🚨 Deploy falhou mas foi revertido
✅ Site funcionando (versão anterior)
🌐 https://meusite.com/
📊 Commit: a1b2c3d

✅ USUÁRIOS PROTEGIDOS!
```

### **🚨 Falha Crítica:**
```
🚨 DEPLOY FALHOU!

🏢 Projeto: meu-projeto
❌ Health check falhou
🔍 Erro: • HTTP 500 (site offline)
📊 Status: 500
🔄 Rollback: falhou
🌐 https://meusite.com/

🔥 INTERVENÇÃO NECESSÁRIA!
```

---

## ⚙️ **Configurações Avançadas**

### **🕒 Timeout Personalizado:**
```yaml
health_check_timeout: 60                    # 60 segundos (padrão: 30)
```

### **🧪 Deploy para Staging:**
```yaml
environment: "staging"                      # staging em vez de production
site_url: "https://staging.meusite.com/"   # URL de staging
```

### **🚫 Desativar Rollback:**
```yaml
enable_rollback: false                     # não fazer rollback automático
```

---

## 📊 **Exemplos Práticos**

### **🛒 E-commerce:**
```yaml
project_name: "loja-roupas"
site_url: "https://minhaloja.com.br/"
health_check_timeout: 45                   # E-commerce pode ser mais lento
enable_rollback: true                      # Crítico - sempre rollback
```

### **📱 App Web:**
```yaml
project_name: "webapp-cliente"
site_url: "https://app.cliente.com/"
environment: "production"
health_check_timeout: 30
```

### **📄 Site Institucional:**
```yaml
project_name: "site-empresa"
site_url: "https://minhaempresa.com.br/"
health_check_timeout: 20                   # Site simples - timeout menor
```

---

## 🔧 **Troubleshooting**

### **❌ "Site não responde (HTTP 500)"**
**Causa:** Erro na aplicação
**Solução:** 
- Rollback automático ativado
- Verificar logs no Vercel
- Corrigir código e fazer novo deploy

### **❌ "Site muito lento (>5s)"**
**Causa:** Performance ruim
**Solução:**
- Aumentar `health_check_timeout`
- Otimizar aplicação
- Verificar recursos do Vercel

### **❌ "Rollback falhou"**
**Causa:** Nenhum deployment anterior válido
**Solução:**
- Intervenção manual necessária
- Verificar deployments no Vercel
- Fazer deploy manual de versão estável

---

## 🚀 **Quando Usar Deploy Universal**

### **✅ Ideal para:**
- 📄 **Landing pages**
- 💼 **Portfolios** 
- 📰 **Blogs**
- 🏢 **Sites institucionais**
- 📱 **Apps simples**

### **❌ NÃO recomendado para:**
- 🛒 **E-commerce crítico** → Use [`Deploy Canary`](03-deploy-canary.md)
- 💰 **Fintech** → Use [`Deploy Canary`](03-deploy-canary.md)
- 📊 **SaaS crítico** → Use [`Deploy Canary`](03-deploy-canary.md)

---

**Deploy Universal = Rápido, Confiável e Profissional!** 🚀✨
