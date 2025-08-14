# ⚡ Início Rápido - Deploy em 5 Minutos

## 🎯 **Objetivo**
Configurar deploy automático profissional em **qualquer projeto** em 5 minutos.

---

## 🚀 **Passo a Passo**

### **1. 📁 Criar estrutura no seu projeto:**
```bash
cd MEU_PROJETO
mkdir -p .github/workflows
```

### **2. 📋 Copiar template:**
```bash
# Copiar de: ../templades/template-projeto-softhouse.yml
# Para: .github/workflows/deploy.yml
```

### **3. ✏️ Configurar APENAS 2 linhas:**
```yaml
# Linha 16-17 do arquivo deploy.yml:
project_name: "meu-projeto"                    # ← Nome no Vercel
site_url: "https://meusite.com.br/"           # ← URL do site
```

### **4. 🔐 Configurar Secrets (uma vez só):**
No GitHub: **Settings → Secrets → Actions**
```
VERCEL_TOKEN - Token do Vercel
VERCEL_TEAM_ID - ID da sua team  
VERCEL_SCOPE - Nome da sua team
TELEGRAM_BOT_TOKEN - Token do bot
TELEGRAM_CHAT_ID - ID do chat
```
👉 **Detalhes:** [`04-configuracao-secrets.md`](04-configuracao-secrets.md)

### **5. 🚀 Commit:**
```bash
git add .github/workflows/deploy.yml
git commit -m "feat: adicionar deploy automático"
git push origin main
```

---

## 🎉 **PRONTO! Funcionando!**

### **✅ O que acontece automaticamente:**
- 🚀 **Deploy** quando você faz `git push origin main`
- 🔍 **Health check** verifica se site está funcionando
- 🔄 **Rollback automático** se algo der errado
- 📱 **Notificações Telegram** sobre status

### **📱 Exemplo de notificação:**
```
✅ meu-projeto - FUNCIONANDO!

🏢 Deploy profissional concluído
🌐 Site: https://meusite.com.br/
📊 Status: 200
⚡ Tempo: 1.2s
📊 Commit: a1b2c3d

🎯 Deploy estilo Big Companies!
```

---

## 🔄 **Como Usar Depois**

### **Deploy Automático:**
```bash
git add .
git commit -m "feat: nova funcionalidade"
git push origin main
```
**Resultado:** Deploy automático com verificação!

### **Deploy Manual:**
1. GitHub → Actions
2. "Deploy Projeto" → "Run workflow"
3. Aguardar notificação no Telegram

---

## 📊 **Exemplos por Tipo de Projeto**

### **🛒 E-commerce:**
```yaml
project_name: "loja-roupas"
site_url: "https://minhaloja.com.br/"
```

### **📄 Landing Page:**
```yaml
project_name: "landing-servicos"
site_url: "https://meuservico.com/"
```

### **💼 Portfolio:**
```yaml
project_name: "portfolio-dev"
site_url: "https://meuportfolio.dev/"
```

---

## 🚀 **Próximos Passos**

### **Para Projetos Críticos:**
👉 Use **Deploy Canary**: [`03-deploy-canary.md`](03-deploy-canary.md)
- Deploy gradual (5% → 100%)
- Monitoramento automático
- Proteção máxima dos usuários

### **Para Múltiplos Projetos:**
👉 Estratégia **Softhouse**: [`05-softhouse-multiplos-projetos.md`](05-softhouse-multiplos-projetos.md)
- Workflow reutilizável
- Manutenção centralizada
- Padrão para toda equipe

---

## ❓ **Dúvidas Comuns**

**P: Funciona com domínio próprio?**
**R:** ✅ Sim! Só mudar a `site_url`

**P: E se meu projeto tem nome diferente no Vercel?**
**R:** ✅ Só mudar o `project_name`

**P: Preciso configurar secrets em cada projeto?**
**R:** ❌ Não! Secrets são globais na sua conta GitHub

**P: E se algo der errado?**
**R:** 🔄 Rollback automático + notificação no Telegram

---

**Pronto para ter deploys profissionais?** 🏢✨
