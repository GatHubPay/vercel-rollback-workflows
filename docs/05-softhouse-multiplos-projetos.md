# 🏢 Softhouse - Gerenciar Múltiplos Projetos

## 🎯 **Estratégia para Softhouses**

Para empresas com **10+ projetos**, usar **workflow reutilizável** é OBRIGATÓRIO:
- 🔧 **Manutenção centralizada** - 1 correção → todos projetos
- 🎯 **Padronização forçada** - impossível "quebrar" o padrão  
- 📊 **Versionamento** - v1.0 estável, v2.0 experimental
- 🏢 **Compliance** - auditoria vê consistência
- 👥 **Proteção contra júnior** - não pode modificar workflow core

---

## 🚀 **Setup Inicial (1x apenas)**

### **1. 📁 Criar Repositório Central:**
```bash
# Criar repo: "workflows" ou "devops-templates"
mkdir workflows
cd workflows
git init
```

### **2. 📋 Estrutura do Repo:**
```
workflows/
├── .github/
│   └── workflows/
│       ├── deploy-universal-reusable.yml  ← Workflow principal
│       └── deploy-canary-reusable.yml     ← Workflow canary
├── templates/
│   ├── template-projeto-softhouse.yml     ← Template normal
│   └── template-canary-softhouse.yml      ← Template canary
├── docs/                                  ← Documentação
└── README.md
```

### **3. 📋 Copiar Workflows:**
```bash
# Copiar workflows reutilizáveis para .github/workflows/
cp ../deploy-universal-reusable.yml .github/workflows/
cp ../deploy-canary-reusable.yml .github/workflows/

# Copiar templates para templates/
cp ../templades/template-projeto-softhouse.yml templates/
cp ../templades/template-canary-softhouse.yml templates/
```

### **4. 🔐 Configurar Secrets Globais:**
Na **Organização GitHub** (não em cada repo):
```
VERCEL_TOKEN - Token da conta Vercel da empresa
VERCEL_TEAM_ID - ID da team da empresa
VERCEL_SCOPE - Nome da team da empresa  
TELEGRAM_BOT_TOKEN - Bot da empresa
TELEGRAM_CHAT_ID - Canal da empresa
```

---

## 🎯 **Para Cada Projeto Novo**

### **1. 📁 Criar estrutura:**
```bash
cd PROJETO_CLIENTE
mkdir -p .github/workflows
```

### **2. 📋 Copiar template:**
```bash
# Para deploy normal:
cp ../workflows/templates/template-projeto-softhouse.yml .github/workflows/deploy.yml

# Para deploy canary:
cp ../workflows/templates/template-canary-softhouse.yml .github/workflows/deploy-canary.yml
```

### **3. ✏️ Editar APENAS 2 linhas:**
```yaml
# Deploy Universal:
project_name: "loja-cliente-x"                    # ← Nome no Vercel
site_url: "https://loja-cliente-x.vercel.app/"    # ← URL do site

# Deploy Canary:
project_name: "ecommerce-cliente-y"               # ← Nome no Vercel
site_url: "https://cliente-y.com.br/"             # ← URL do site
```

### **4. 🔄 Atualizar referência do workflow:**
```yaml
# Em vez de:
uses: SuaSofthouse/workflows/.github/workflows/deploy-universal-reusable.yml@main

# Use:
uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@main
```

### **5. 🚀 Commit:**
```bash
git add .github/workflows/deploy.yml
git commit -m "feat: adicionar deploy automático"
git push origin main
```

### **6. ✅ FUNCIONANDO!**
- Deploy automático ✅
- Health check profissional ✅  
- Rollback inteligente ✅
- Notificações Telegram ✅

---

## 🔄 **Versionamento Inteligente**

### **🎯 Projetos Novos = Última Versão:**
```yaml
uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@main
```
**Vantagem:** Sempre tem as últimas melhorias

### **🛡️ Projetos Críticos = Versão Estável:**
```yaml
uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@v1.5
```
**Vantagem:** Garantia de estabilidade

### **🧪 Projetos Teste = Versão Beta:**
```yaml
uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@beta
```
**Vantagem:** Testar novas funcionalidades

---

## 📊 **Exemplos Práticos**

### **Cliente A - E-commerce:**
```yaml
# .github/workflows/deploy-canary.yml
name: Deploy E-commerce Cliente A

jobs:
  canary-deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-canary-reusable.yml@v1.5
    with:
      project_name: "ecommerce-cliente-a"
      site_url: "https://loja.clientea.com.br/"
      canary_percentage: 3                  # Muito conservador
      error_threshold: 0.1                  # Quase zero erro
```

### **Cliente B - Landing Page:**
```yaml
# .github/workflows/deploy.yml
name: Deploy Landing Cliente B

jobs:
  deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@main
    with:
      project_name: "landing-cliente-b"
      site_url: "https://clienteb.com.br/"
```

### **Cliente C - Dashboard Interno:**
```yaml
# .github/workflows/deploy.yml
name: Deploy Dashboard Cliente C

jobs:
  deploy:
    uses: MinhaEmpresa/workflows/.github/workflows/deploy-universal-reusable.yml@beta
    with:
      project_name: "dashboard-cliente-c"  
      site_url: "https://dashboard-cliente-c.vercel.app/"
      environment: "staging"               # Staging primeiro
      health_check_timeout: 60             # Mais tempo
```

---

## 🔧 **Manutenção Centralizada**

### **🐛 Corrigir Bug:**
1. **Editar** `deploy-universal-reusable.yml` no repo workflows
2. **Commit** na branch `main`
3. **TODOS os projetos** usam a correção automaticamente!

**Exemplo:**
```bash
cd workflows
# Corrigir bug no workflow
git add .github/workflows/deploy-universal-reusable.yml
git commit -m "fix: corrigir timeout do health check"
git push origin main

# ✅ Todos os 50 projetos da empresa agora têm a correção!
```

### **🚀 Nova Feature:**
1. **Criar branch** `feature/nova-funcionalidade`
2. **Testar** em 1-2 projetos:
   ```yaml
   uses: MinhaEmpresa/workflows/...@feature/nova-funcionalidade
   ```
3. **Se OK** → merge para `main`
4. **Todos projetos** ganham a feature!

### **📊 Rollback Global:**
Se versão nova tem problema:
```bash
# Reverter TODOS os projetos para versão anterior
cd workflows
git revert HEAD
git push origin main

# Ou usar tags:
git tag -d v2.0
git push origin :refs/tags/v2.0
```

---

## 📈 **Métricas e Monitoramento**

### **🎯 Dashboard Único:**
Todos workflows reportam para:
- 📱 **Mesmo canal Telegram** - visão unificada
- 📊 **Mesmo sistema de logs** - centralizado
- ⏰ **Mesmos horários** - padronizado
- 🚨 **Mesmos alertas** - consistente

### **📊 KPIs da Softhouse:**
```
Deploy Success Rate: 98.5% (meta: >95%)
Rollback Rate: 1.2% (meta: <5%)  
Deploy Time: 2.3min média
Health Check Pass: 99.1%
Projetos Ativos: 47
Deploys/Dia: 23
```

### **📱 Exemplo de Notificação Unificada:**
```
📊 RELATÓRIO DIÁRIO - MinhaEmpresa

✅ Deploys hoje: 23
✅ Sucessos: 22 (95.6%)
🔄 Rollbacks: 1 (4.4%)
⏰ Tempo médio: 2.1min

🚨 Projetos com problema:
• cliente-x-app: rollback executado

🏆 Top projetos:
• loja-cliente-a: 100% sucesso
• dashboard-b: 100% sucesso
• landing-c: 100% sucesso
```

---

## 🎉 **Resultado Final**

### **✅ Para Softhouse:**
- **50 projetos** com **1 arquivo** de manutenção
- **Bug fix** em **1 lugar** → **50 projetos** corrigidos
- **Padrão consistente** em **todos projetos**
- **Auditoria feliz** - compliance garantido
- **Time júnior protegido** - não quebra nada

### **✅ Para Clientes:**
- **Deploy profissional** igual Netflix/Uber
- **Rollback automático** se der problema
- **Site nunca fica quebrado** para usuários
- **Notificações em tempo real**
- **SLA alto** - 99%+ uptime

### **✅ Para Desenvolvedores:**
- **2 linhas** para configurar projeto novo
- **Zero manutenção** de workflow
- **Foco no código** - não em DevOps
- **Padrão conhecido** - mesmo em todos projetos

---

## 🚀 **Processo de Onboarding**

### **📋 Checklist Projeto Novo:**
- [ ] Criar repositório no GitHub
- [ ] Copiar template apropriado
- [ ] Configurar `project_name` e `site_url`
- [ ] Fazer primeiro commit
- [ ] Verificar deploy automático
- [ ] Confirmar notificação Telegram
- [ ] Documentar no dashboard da empresa

### **⏱️ Tempo Total:**
- **Desenvolvedor experiente:** 5 minutos
- **Desenvolvedor júnior:** 15 minutos
- **Estagiário com tutorial:** 30 minutos

---

## 🔄 **Migração de Projetos Existentes**

### **📊 Para 50 Projetos Existentes:**
1. **Semana 1:** Criar repo workflows + testar em 3 projetos piloto
2. **Semana 2:** Migrar 10 projetos menos críticos
3. **Semana 3:** Migrar 20 projetos médios
4. **Semana 4:** Migrar 17 projetos restantes (incluindo críticos)

### **🛡️ Estratégia de Rollback:**
- Manter workflows antigos por 1 mês
- Monitorar métricas comparativas
- Rollback individual se necessário

---

## 🎯 **Próximos Passos**

1. **📁 Criar repo `workflows`** na organização
2. **📋 Copiar workflows reutilizáveis** 
3. **🔐 Configurar secrets** na organização
4. **🧪 Testar** em 1 projeto piloto
5. **📢 Rollout** para todos projetos
6. **📊 Monitorar** e iterar

**Pronto para revolucionar os deploys da softhouse!** 🏢✨

---

**Resultado: 1 Workflow = 50 Projetos Protegidos!** 🛡️🚀
