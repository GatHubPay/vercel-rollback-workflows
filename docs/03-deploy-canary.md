# 🎯 Deploy Canary - Proteção Máxima dos Usuários

## 🚀 **O que é Deploy Canary?**

Estratégia usada por **Netflix, Amazon, Uber** onde:
- 🎯 Deploy inicial para **5% dos usuários** (canary)
- 📊 **Monitoramento automático** por 10 minutos
- ✅ Se OK → Deploy para **100% dos usuários**
- ❌ Se FAIL → **Rollback automático**
- 🛡️ **95% dos usuários protegidos** durante testes

**Ideal para:** E-commerce, fintech, SaaS críticos, aplicações com muitos usuários

---

## 📋 **Como Configurar**

### **1. 📁 Copiar template:**
```bash
# De: ../templades/template-canary-softhouse.yml
# Para: .github/workflows/deploy-canary.yml
```

### **2. ✏️ Configurar projeto:**
```yaml
name: Canary Deploy Projeto

on:
  push:
    branches: [main, master]
  workflow_dispatch:
    inputs:
      canary_percentage:
        description: 'Porcentagem inicial do canary (5-50)'
        required: false
        default: '5'
      skip_canary:
        description: 'Pular canary e ir direto para 100%'
        type: boolean
        required: false
        default: false

jobs:
  canary-deploy:
    uses: SuaSofthouse/workflows/.github/workflows/deploy-canary-reusable.yml@main
    with:
      # 🎯 CONFIGURE APENAS ESTAS 2 LINHAS:
      project_name: "MEU_PROJETO"           # ← Nome no Vercel
      site_url: "https://meusite.com/"      # ← URL do site
      
      # 📊 CONFIGURAÇÕES CANARY (opcionais):
      canary_percentage: ${{ github.event.inputs.canary_percentage || 5 }}
      canary_duration: 600                  # 10 minutos de canary
      skip_canary: ${{ github.event.inputs.skip_canary || false }}
      error_threshold: 0.5                  # 0.5% erro máximo
      latency_threshold: 3000               # 3000ms latência máxima
      
    secrets: # ... secrets aqui
```

---

## 🔄 **Fluxo Completo do Canary**

### **📊 1. Deploy Canary (5% usuários)**
```
🎯 CANARY DEPLOY INICIADO

🚀 Projeto: loja-online
📊 Canary: 5% dos usuários  
⏰ Monitoramento: 600s
🔗 URL: https://loja-abc123.vercel.app
📝 Commit: a1b2c3d

🏢 Deploy estilo Big Companies!
```

### **📈 2. Monitoramento Automático**
- ✅ **Requests a cada 30s** por 10 minutos
- 📊 **Taxa de erro** deve ser < 0.5%
- ⚡ **Latência** deve ser < 3000ms
- 🔍 **Status HTTP** deve ser 200

### **✅ 3. Cenário de Sucesso**
```
🎯 CANARY DEPLOY SUCESSO: loja-online

✅ Canary aprovado (erro: 0.2%)
✅ Produção funcionando
⚡ Latência canary: 180ms
📊 Requests canary: 20
📊 Status produção: 200
⚡ Tempo produção: 1.2s
🌐 100% dos usuários protegidos
📝 Commit: a1b2c3d

🏢 Deploy estilo Big Companies!
```

### **❌ 4. Cenário de Falha**
```
🚨 CANARY REPROVADO: loja-online

❌ Canary falhou (erro: 2.1%)
⚡ Latência: 3200ms
📊 Requests: 20
🔄 Rollback: true
📝 Commit: a1b2c3d

✅ 95% DOS USUÁRIOS PROTEGIDOS!
```

---

## 📊 **Métricas Monitoradas**

### **🔍 Verificações Automáticas:**

#### **1. 📈 Taxa de Erro:**
```yaml
error_threshold: 0.5                       # 0.5% máximo (configurável)
```
- Conta requests que não retornam **200**
- Se > 0.5% → **Rollback automático**

#### **2. ⚡ Latência:**
```yaml
latency_threshold: 3000                    # 3000ms máximo (configurável)
```
- Mede tempo de resposta
- Se > 3000ms → **Rollback automático**

#### **3. 📊 Frequência:**
```yaml
canary_duration: 600                       # 10 minutos total
```
- Check a cada **30 segundos**
- Total de **20 verificações**
- Qualquer falha → **Para imediatamente**

---

## 🎮 **Como Usar**

### **🚀 Deploy Automático (Padrão):**
```bash
git push origin main
```
**Resultado:** Canary 5% → Monitor 10min → Produção 100%

### **🎯 Deploy Manual Customizado:**
1. GitHub → Actions → "Canary Deploy Projeto"
2. "Run workflow"
3. Configurar:
   - **Canary %:** `5`, `10`, `25` (% de usuários para teste)
   - **Skip Canary:** `false` (usar canary) / `true` (deploy direto)

### **🚀 Deploy Direto (Emergência):**
1. GitHub → Actions → "Canary Deploy Projeto"  
2. "Run workflow"
3. **Skip Canary:** `true`
**Resultado:** Deploy direto 100% (sem canary)

---

## ⚙️ **Configurações Avançadas**

### **🎯 Canary Conservador (E-commerce):**
```yaml
canary_percentage: 3                       # Só 3% dos usuários
canary_duration: 900                       # 15 minutos de teste
error_threshold: 0.1                       # 0.1% erro máximo
latency_threshold: 2000                    # 2s latência máxima
```

### **🚀 Canary Agressivo (App interno):**
```yaml
canary_percentage: 25                      # 25% dos usuários
canary_duration: 300                       # 5 minutos de teste
error_threshold: 1.0                       # 1% erro máximo
latency_threshold: 5000                    # 5s latência máxima
```

### **🧪 Canary para Staging:**
```yaml
project_name: "app-staging"
site_url: "https://staging.app.com/"
canary_percentage: 50                      # 50% em staging
canary_duration: 180                       # 3 minutos apenas
```

---

## 📊 **Exemplos por Setor**

### **🛒 E-commerce Crítico:**
```yaml
project_name: "loja-vendas"
site_url: "https://minhaloja.com.br/"
canary_percentage: 5                       # Só 5% - muito conservador
canary_duration: 900                       # 15 min - monitoramento longo
error_threshold: 0.1                       # 0.1% - quase zero erro
latency_threshold: 2000                    # 2s - deve ser rápido
```

### **💰 Fintech:**
```yaml
project_name: "app-pagamentos"
site_url: "https://pagamentos.com/"
canary_percentage: 3                       # Só 3% - extremamente conservador
canary_duration: 1200                      # 20 min - muito tempo
error_threshold: 0.05                      # 0.05% - quase perfeito
latency_threshold: 1500                    # 1.5s - muito rápido
```

### **📊 SaaS B2B:**
```yaml
project_name: "dashboard-clientes"
site_url: "https://app.saas.com/"
canary_percentage: 10                      # 10% - moderado
canary_duration: 600                       # 10 min - padrão
error_threshold: 0.5                       # 0.5% - padrão
latency_threshold: 3000                    # 3s - padrão
```

---

## 🔧 **Troubleshooting Canary**

### **❌ "Canary falhou (erro: 2.1%)"**
**Causa:** Taxa de erro acima do limite
**Ação:** 
- ✅ Rollback automático executado
- ✅ 95% usuários protegidos
- 🔍 Investigar logs do Vercel
- 🛠️ Corrigir código e tentar novamente

### **❌ "Canary falhou - latência alta"**
**Causa:** Site muito lento
**Ação:**
- ✅ Rollback automático executado  
- 🔍 Verificar performance
- ⚡ Otimizar código/imagens
- 📊 Considerar aumentar `latency_threshold`

### **❌ "Produção falhou após canary OK"**
**Causa:** Problema na promoção 5% → 100%
**Ação:**
- 🔄 Rollback automático ativado
- 🚨 Intervenção manual necessária
- 📞 Contactar equipe DevOps

---

## 🏆 **Vantagens vs Deploy Normal**

### **📊 Deploy Normal:**
- ❌ **100% usuários** veem erro se falhar
- ❌ Só descobre erro **depois** de no ar
- ❌ Rollback **reativo** (após dano)
- ❌ **Todos usuários** afetados

### **🎯 Deploy Canary:**
- ✅ Só **5% usuários** veem erro
- ✅ Descobre erro **antes** de afetar todos
- ✅ Rollback **preventivo** (antes do dano)
- ✅ **95% usuários protegidos**
- ✅ **Monitoramento automático**
- ✅ **Métricas em tempo real**

---

## 🚀 **Quando Usar Deploy Canary**

### **✅ OBRIGATÓRIO para:**
- 🛒 **E-commerce** (vendas críticas)
- 💰 **Fintech** (dinheiro envolvido)
- 📊 **SaaS crítico** (muitos usuários)
- 🏥 **Sistemas de saúde**
- 🎓 **Plataformas educacionais**

### **✅ RECOMENDADO para:**
- 📱 **Apps com +1000 usuários**
- 🔐 **Sistemas com login**
- 📊 **Dashboards importantes**
- 🎮 **Games online**

### **❌ Desnecessário para:**
- 📄 **Landing pages simples** → Use [`Deploy Universal`](02-deploy-universal.md)
- 💼 **Portfolios** → Use [`Deploy Universal`](02-deploy-universal.md)
- 📰 **Blogs pessoais** → Use [`Deploy Universal`](02-deploy-universal.md)

---

**Deploy Canary = Proteção Máxima dos Usuários!** 🛡️✨

**Mesmo sistema usado por Netflix, Amazon e Uber!** 🏢🚀
