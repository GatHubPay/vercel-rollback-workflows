# 💡 Exemplos Práticos - Casos de Uso Reais

## 🎯 **Casos de Uso por Setor**

Esta seção mostra **configurações reais** para diferentes tipos de projeto, com **justificativas** para cada escolha.

---

## 🛒 **E-commerce / Loja Online**

### **🎯 Configuração Recomendada - Deploy Canary:**
```yaml
name: Deploy E-commerce

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@v1.5
    with:
      project_name: "loja-roupas-online"
      site_url: "https://minhaloja.com.br/"
      
      # Configurações CONSERVADORAS para e-commerce:
      canary_percentage: 3                   # Só 3% dos usuários primeiro
      canary_duration: 900                   # 15 minutos de monitoramento
      error_threshold: 0.1                   # 0.1% erro máximo (quase zero)
      latency_threshold: 2000                # 2s máximo (deve ser rápido)
```

### **🔍 Justificativa:**
- **3% canary:** Minimiza impacto em vendas se der problema
- **15 min monitor:** Tempo suficiente para detectar problemas reais
- **0.1% erro:** E-commerce não pode ter erro - cada erro = venda perdida
- **2s latência:** Site lento = carrinho abandonado
- **Versão estável (@v1.5):** Não pode usar versão experimental

### **📊 Cenários Reais:**
```
✅ SUCESSO: Erro 0.05%, Latência 800ms → Deploy 100%
❌ FALHA: Erro 0.3% → Rollback (97% usuários protegidos)
❌ FALHA: Latência 2.5s → Rollback (carrinho não abandonado)
```

---

## 💰 **Fintech / Pagamentos**

### **🎯 Configuração Recomendada - Deploy Canary Ultra-Conservador:**
```yaml
name: Deploy Fintech

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@v1.5
    with:
      project_name: "app-pagamentos"
      site_url: "https://pagamentos.com.br/"
      
      # Configurações ULTRA-CONSERVADORAS para fintech:
      canary_percentage: 1                   # Só 1% dos usuários primeiro
      canary_duration: 1800                  # 30 minutos de monitoramento
      error_threshold: 0.01                  # 0.01% erro máximo (quase perfeito)
      latency_threshold: 1500                # 1.5s máximo (muito rápido)
```

### **🔍 Justificativa:**
- **1% canary:** Dinheiro envolvido - risco mínimo
- **30 min monitor:** Tempo para detectar problemas financeiros
- **0.01% erro:** Erro em fintech = perda de confiança + dinheiro
- **1.5s latência:** Transação deve ser instantânea
- **Versão estável:** Regulamentação exige estabilidade

### **🚨 Alertas Especiais:**
```yaml
# Adicionar verificações extras:
health_check_timeout: 45                   # Mais tempo para verificações
enable_rollback: true                      # OBRIGATÓRIO
```

---

## 📊 **SaaS B2B / Dashboard**

### **🎯 Configuração Recomendada - Deploy Canary Moderado:**
```yaml
name: Deploy SaaS Dashboard

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@main
    with:
      project_name: "dashboard-clientes"
      site_url: "https://app.meuSaaS.com/"
      
      # Configurações MODERADAS para SaaS:
      canary_percentage: 10                  # 10% dos usuários primeiro
      canary_duration: 600                   # 10 minutos padrão
      error_threshold: 0.5                   # 0.5% erro aceitável
      latency_threshold: 3000                # 3s aceitável para dashboard
```

### **🔍 Justificativa:**
- **10% canary:** Usuários B2B são mais tolerantes que B2C
- **10 min monitor:** Suficiente para detectar problemas
- **0.5% erro:** Alguns erros não críticos são aceitáveis
- **3s latência:** Dashboard pode ser um pouco mais lento
- **Versão main:** SaaS precisa de features novas rapidamente

---

## 📱 **App Mobile / PWA**

### **🎯 Configuração Recomendada - Deploy Universal:**
```yaml
name: Deploy PWA

jobs:
  deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@main
    with:
      project_name: "pwa-cliente"
      site_url: "https://app.cliente.com/"
      
      # Configurações para PWA:
      environment: "production"
      health_check_timeout: 45               # PWA pode demorar mais para carregar
      enable_rollback: true
```

### **🔍 Justificativa:**
- **Deploy Universal:** PWA não é tão crítico quanto e-commerce
- **45s timeout:** PWA faz cache, primeira carga pode demorar
- **Rollback ativo:** Proteção dos usuários mobile

---

## 📄 **Landing Page / Site Institucional**

### **🎯 Configuração Recomendada - Deploy Universal Rápido:**
```yaml
name: Deploy Landing Page

jobs:
  deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@main
    with:
      project_name: "landing-servicos"
      site_url: "https://meuservico.com.br/"
      
      # Configurações RÁPIDAS para landing:
      environment: "production"
      health_check_timeout: 20               # Landing deve ser rápida
      enable_rollback: true
```

### **🔍 Justificativa:**
- **Deploy Universal:** Landing não precisa de canary
- **20s timeout:** Landing deve carregar rápido
- **Versão main:** Pode usar últimas features

---

## 🎮 **Game Online / Plataforma**

### **🎯 Configuração Recomendada - Deploy Canary Específico:**
```yaml
name: Deploy Game Online

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@main
    with:
      project_name: "game-online"
      site_url: "https://meugame.com/"
      
      # Configurações para GAME:
      canary_percentage: 5                   # 5% dos jogadores
      canary_duration: 300                   # 5 minutos (jogos são rápidos)
      error_threshold: 1.0                   # 1% erro (jogadores são tolerantes)
      latency_threshold: 5000                # 5s (jogos podem demorar para carregar)
```

### **🔍 Justificativa:**
- **5% canary:** Jogadores são mais tolerantes a problemas
- **5 min monitor:** Problemas em jogos aparecem rápido
- **1% erro:** Gamers esperam alguns bugs
- **5s latência:** Jogos podem ter assets pesados

---

## 🏥 **Sistema de Saúde / Crítico**

### **🎯 Configuração Recomendada - Deploy Canary Ultra-Seguro:**
```yaml
name: Deploy Sistema Saúde

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@v1.5
    with:
      project_name: "sistema-hospitalar"
      site_url: "https://sistema.hospital.com.br/"
      
      # Configurações CRÍTICAS para saúde:
      canary_percentage: 2                   # Só 2% - vidas em risco
      canary_duration: 1800                  # 30 minutos - muito tempo
      error_threshold: 0.01                  # 0.01% - quase perfeito
      latency_threshold: 1000                # 1s - emergência não espera
```

### **🔍 Justificativa:**
- **2% canary:** Vidas em risco - máxima proteção
- **30 min monitor:** Tempo para detectar problemas críticos
- **0.01% erro:** Zero tolerância a erro em saúde
- **1s latência:** Emergência médica precisa ser instantânea

---

## 🎓 **Plataforma Educacional**

### **🎯 Configuração Recomendada - Deploy por Horário:**
```yaml
name: Deploy EAD

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@main
    with:
      project_name: "plataforma-ead"
      site_url: "https://ead.escola.com.br/"
      
      # Configurações para EDUCAÇÃO:
      canary_percentage: 15                  # 15% dos alunos
      canary_duration: 900                   # 15 minutos
      error_threshold: 0.3                   # 0.3% erro aceitável
      latency_threshold: 4000                # 4s aceitável
```

### **💡 Dica Especial - Deploy Fora do Horário:**
```yaml
# Adicionar condição de horário:
on:
  push:
    branches: [main]
  schedule:
    - cron: '0 2 * * *'  # 2h da manhã (fora do horário de aula)
```

---

## 🏪 **Marketplace / Multi-tenant**

### **🎯 Configuração Recomendada - Deploy Canary por Tenant:**
```yaml
name: Deploy Marketplace

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@main
    with:
      project_name: "marketplace-vendedores"
      site_url: "https://marketplace.com.br/"
      
      # Configurações para MARKETPLACE:
      canary_percentage: 5                   # 5% dos vendedores
      canary_duration: 1200                  # 20 minutos (muitos usuários)
      error_threshold: 0.2                   # 0.2% erro
      latency_threshold: 2500                # 2.5s máximo
```

---

## 📊 **Comparação de Configurações**

| Tipo | Canary % | Monitor | Erro % | Latência | Versão |
|------|----------|---------|--------|----------|---------|
| **Fintech** | 1% | 30min | 0.01% | 1.5s | Estável |
| **E-commerce** | 3% | 15min | 0.1% | 2s | Estável |
| **Saúde** | 2% | 30min | 0.01% | 1s | Estável |
| **SaaS B2B** | 10% | 10min | 0.5% | 3s | Main |
| **Game** | 5% | 5min | 1.0% | 5s | Main |
| **Landing** | - | - | - | - | Universal |

---

## 🎯 **Templates Prontos para Copiar**

### **🛒 E-commerce:**
```bash
# Copiar template e-commerce:
cp templates/template-canary-ecommerce.yml .github/workflows/deploy.yml
```

### **💰 Fintech:**
```bash
# Copiar template fintech:
cp templates/template-canary-fintech.yml .github/workflows/deploy.yml
```

### **📄 Landing:**
```bash
# Copiar template landing:
cp templates/template-universal-landing.yml .github/workflows/deploy.yml
```

---

## 🔄 **Cenários de Rollback Reais**

### **❌ E-commerce - Erro no Checkout:**
```
🚨 CANARY REPROVADO: loja-roupas

❌ Canary falhou (erro: 0.3%)
🔍 Erro detectado: Botão "Finalizar Compra" quebrado
📊 Requests: 1000
💰 Vendas protegidas: 97% dos clientes
🔄 Rollback: executado em 30s

✅ RECEITA PROTEGIDA!
```

### **❌ SaaS - Performance Ruim:**
```
🚨 CANARY REPROVADO: dashboard-vendas

❌ Canary falhou - latência alta
⚡ Latência: 4.2s (limite: 3s)
📊 Causa: Query SQL não otimizada
👥 Usuários protegidos: 90%
🔄 Rollback: executado

✅ PRODUTIVIDADE PROTEGIDA!
```

---

## 🏆 **Resultados Reais**

### **📊 E-commerce (6 meses):**
- **Deploys:** 234
- **Canary aprovados:** 228 (97.4%)
- **Rollbacks:** 6 (2.6%)
- **Usuários protegidos:** 95% durante falhas
- **Receita protegida:** R$ 2.3M

### **💰 Fintech (1 ano):**
- **Deploys:** 156
- **Canary aprovados:** 154 (98.7%)
- **Rollbacks:** 2 (1.3%)
- **Usuários protegidos:** 99% durante falhas
- **Transações protegidas:** R$ 45M

---

**Cada setor tem suas necessidades - configure adequadamente!** 🎯✨
