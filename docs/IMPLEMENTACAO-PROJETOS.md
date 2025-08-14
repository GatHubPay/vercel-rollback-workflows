# 🚀 Guia de Implementação em Projetos

## 📋 CHECKLIST DE IMPLEMENTAÇÃO

### **PREPARAÇÃO INICIAL**
- [ ] Listar todos os projetos Next.js
- [ ] Verificar nomes exatos no Vercel
- [ ] Preparar secrets necessários
- [ ] Escolher projeto piloto para teste

---

## 📝 **PASSO 1: INVENTÁRIO DOS PROJETOS**

### **Liste seus projetos seguindo este formato:**

| Projeto | Tipo | Nome no Vercel | Repositório GitHub | Rotas Importantes |
|---------|------|----------------|-------------------|-------------------|
| Casa de Apostas | SaaS | `casa-apostas-prod` | `usuario/casa-apostas` | `/,/login,/apostas,/carteira` |
| Gateway Pagamento | API | `gateway-pay-prod` | `usuario/gateway-pay` | `/,/api/health,/api/payment` |
| Checkout Sistema | E-commerce | `checkout-sys-prod` | `usuario/checkout-sys` | `/,/carrinho,/checkout,/api/pay` |

---

## 🔧 **PASSO 2: CONFIGURAÇÃO DOS SECRETS**

### **Para CADA repositório, configure estes secrets:**

1. **Vá em:** `Settings > Secrets and variables > Actions`
2. **Adicione estes 3 secrets:**

```bash
# VERCEL_TOKEN
# Valor: (seu token do Vercel)
# Como obter: https://vercel.com/account/tokens

# VERCEL_TEAM_ID  
# Valor: (ID do seu time)
# Como obter: Dashboard Vercel > Settings > General

# VERCEL_SCOPE
# Valor: (nome da sua organização)
# Como obter: Dashboard Vercel > Settings > General
```

---

## 📄 **PASSO 3: TEMPLATES POR TIPO DE PROJETO**

### **🎰 Casa de Apostas / SaaS**
```yaml
# .github/workflows/deploy.yml
name: Deploy Casa de Apostas

on:
  push:
    branches: [main, master]
  workflow_dispatch:

jobs:
  deploy:
    uses: SeuUsuario/vercel-rollback-workflows/.github/workflows/vercel-rollback.yml@v1.0.0
    with:
      vercelProject: "casa-apostas-prod"
      routes: "/,/login,/apostas,/carteira,/jogos,/api/odds,/api/health"
      healthCheckTimeout: 45
      maxRetries: 4
      monitoringDurationMinutes: 45  # Monitoramento estendido
      monitoringIntervalMinutes: 5
    secrets:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: ${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: ${{ secrets.VERCEL_SCOPE }}
```

### **💳 Gateway de Pagamento**
```yaml
# .github/workflows/deploy.yml
name: Deploy Gateway Pagamento

on:
  push:
    branches: [main, master]
  workflow_dispatch:

jobs:
  deploy:
    uses: SeuUsuario/vercel-rollback-workflows/.github/workflows/vercel-rollback.yml@v1.0.0
    with:
      vercelProject: "gateway-pay-prod"
      routes: "/,/api/health,/api/payment,/api/webhook,/api/status"
      healthCheckTimeout: 60         # Timeout maior para APIs críticas
      maxRetries: 5                  # Mais tentativas para sistemas de pagamento
      monitoringDurationMinutes: 60  # Monitoramento longo para crítico
      monitoringIntervalMinutes: 3   # Verificações mais frequentes
    secrets:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: ${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: ${{ secrets.VERCEL_SCOPE }}
```

### **🛒 Sistema de Checkout**
```yaml
# .github/workflows/deploy.yml
name: Deploy Checkout

on:
  push:
    branches: [main, master]
  workflow_dispatch:

jobs:
  deploy:
    uses: SeuUsuario/vercel-rollback-workflows/.github/workflows/vercel-rollback.yml@v1.0.0
    with:
      vercelProject: "checkout-sys-prod"
      routes: "/,/carrinho,/checkout,/api/payment,/api/shipping,/api/health"
      healthCheckTimeout: 40
      maxRetries: 4
      monitoringDurationMinutes: 30
      monitoringIntervalMinutes: 5
    secrets:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: ${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: ${{ secrets.VERCEL_SCOPE }}
```

---

## 🧪 **PASSO 4: IMPLEMENTAÇÃO GRADUAL**

### **4.1 Projeto Piloto (Menos Crítico)**
1. **Escolha** um projeto menos crítico primeiro
2. **Implemente** o workflow
3. **Teste** fazendo um push
4. **Monitore** por algumas horas
5. **Ajuste** configurações se necessário

### **4.2 Projetos Críticos**
1. **Aguarde** confirmação do piloto
2. **Configure** com timeouts maiores
3. **Monitore** de perto os primeiros deploys
4. **Documente** problemas encontrados

### **4.3 Rollout Completo**
1. **Implemente** em todos os projetos restantes
2. **Monitore** notificações do Telegram
3. **Ajuste** configurações conforme necessário

---

## 📊 **PASSO 5: MONITORAMENTO E AJUSTES**

### **Primeiros Deploys - Monitore:**
- ✅ **Deploy bem-sucedido** (notificação verde)
- ✅ **Health checks passando**
- ✅ **Monitoramento pós-deploy funcionando**
- ✅ **Notificações chegando no Telegram**

### **Se Algo Der Errado:**
1. **Consulte** [Troubleshooting Guide](./TROUBLESHOOTING.md)
2. **Ajuste** timeouts se necessário
3. **Revise** rotas configuradas
4. **Teste** rotas manualmente

---

## 🎯 **CONFIGURAÇÕES RECOMENDADAS POR TIPO**

### **Projetos Críticos (Pagamento, Financeiro)**
```yaml
healthCheckTimeout: 60
maxRetries: 5
monitoringDurationMinutes: 60
monitoringIntervalMinutes: 3
```

### **Projetos Normais (E-commerce, SaaS)**
```yaml
healthCheckTimeout: 45
maxRetries: 4
monitoringDurationMinutes: 30
monitoringIntervalMinutes: 5
```

### **Projetos Simples (Landing, Blog)**
```yaml
healthCheckTimeout: 30
maxRetries: 3
monitoringDurationMinutes: 15
monitoringIntervalMinutes: 10
```

---

## 🚨 **CENÁRIOS DE EMERGÊNCIA**

### **Se Rollback Automático Falhar:**
```bash
# Rollback manual via Vercel CLI
vercel rollback --token=SEU_TOKEN --scope=SEU_SCOPE

# Ou via dashboard do Vercel
# Deployments > Promote to Production (versão anterior)
```

### **Se Muitos Falsos Positivos:**
```yaml
# Configuração menos sensível temporariamente
healthCheckTimeout: 90
maxRetries: 6
enablePostDeployMonitoring: false  # Desabilitar temporariamente
```

### **Para Desabilitar Temporariamente:**
```yaml
# Comentar ou remover o job do workflow
# jobs:
#   deploy:
#     uses: ...
```

---

## 📈 **MÉTRICAS DE SUCESSO**

### **Após 1 Semana:**
- [ ] Todos os projetos com workflow implementado
- [ ] Zero falhas não detectadas
- [ ] Rollbacks funcionando corretamente
- [ ] Notificações chegando consistentemente

### **Após 1 Mês:**
- [ ] Redução significativa de downtime
- [ ] Detecção automática de problemas
- [ ] Confiança no sistema de deploy
- [ ] Documentação de casos encontrados

---

## 🎉 **RESULTADO FINAL**

Ao completar esta implementação, você terá:

✅ **Proteção total** em todos os projetos  
✅ **Detecção automática** de falhas imediatas e tardias  
✅ **Rollback inteligente** sem intervenção manual  
✅ **Notificações instantâneas** de todos os eventos  
✅ **Monitoramento contínuo** por 30+ minutos  
✅ **Sistema profissional** de deploy robusto  

**Seus projetos estarão protegidos 24/7! 🛡️**
