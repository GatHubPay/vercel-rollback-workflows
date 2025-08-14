# 🔧 Guia de Configuração

## 📋 Pré-requisitos

- ✅ Projeto Next.js no Vercel
- ✅ Repositório no GitHub
- ✅ Conta no Vercel com acesso de API
- ✅ Telegram para notificações (já configurado)

## 🚀 Configuração Rápida

### **1. Configure os Secrets do GitHub**

Em cada repositório do seu projeto:

1. Vá em **Settings** → **Secrets and variables** → **Actions**
2. Clique em **New repository secret**
3. Adicione estes 3 secrets:

| Nome | Valor | Onde Obter |
|------|-------|------------|
| `VERCEL_TOKEN` | Token da API | [vercel.com/account/tokens](https://vercel.com/account/tokens) |
| `VERCEL_TEAM_ID` | ID do seu time | Dashboard do Vercel → Settings → General |
| `VERCEL_SCOPE` | Nome do time/org | Dashboard do Vercel → Settings → General |

### **2. Adicione o Workflow ao Projeto**

Crie `.github/workflows/deploy.yml` no seu projeto:

```yaml
name: Deploy com Rollback Automático

on:
  push:
    branches: [main]

jobs:
  deploy:
    uses: SeuUsuario/vercel-rollback-workflows/.github/workflows/vercel-rollback.yml@v1
    with:
      vercelProject: "meu-projeto-vercel"
    secrets:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: ${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: ${{ secrets.VERCEL_SCOPE }}
```

### **3. Customize Conforme Necessário**

```yaml
with:
  vercelProject: "meu-projeto-vercel"
  routes: "/,/api/health,/login"  # Rotas específicas
  healthCheckTimeout: 45          # Timeout personalizado
  maxRetries: 5                   # Mais tentativas
  monitoringDurationMinutes: 60   # Monitoramento mais longo
```

## 📊 Tipos de Projeto

### **🛒 E-commerce**
```yaml
with:
  vercelProject: "minha-loja"
  routes: "/,/produtos,/carrinho,/checkout,/api/produtos,/api/pagamento"
  healthCheckTimeout: 45
  monitoringDurationMinutes: 45
```

### **📝 Blog**
```yaml
with:
  vercelProject: "meu-blog"
  routes: "/,/posts,/sobre,/contato"
  healthCheckTimeout: 30
  monitoringDurationMinutes: 20
```

### **💼 SaaS/Dashboard**
```yaml
with:
  vercelProject: "meu-saas"
  routes: "/,/login,/dashboard,/api/auth,/api/health"
  healthCheckTimeout: 60
  monitoringDurationMinutes: 60
```

## 🎯 Parâmetros Disponíveis

| Parâmetro | Tipo | Padrão | Descrição |
|-----------|------|--------|-----------|
| `vercelProject` | string | - | **OBRIGATÓRIO** - Nome exato do projeto no Vercel |
| `routes` | string | `""` | Rotas para testar (vazio = auto-detecção) |
| `healthCheckTimeout` | number | `30` | Timeout em segundos por requisição |
| `maxRetries` | number | `3` | Máximo de tentativas por rota |
| `enablePostDeployMonitoring` | boolean | `true` | Habilitar monitoramento pós-deploy |
| `monitoringDurationMinutes` | number | `30` | Duração do monitoramento em minutos |
| `monitoringIntervalMinutes` | number | `5` | Intervalo entre verificações |

## 🤖 Notificações no Telegram

As notificações estão **pré-configuradas** e serão enviadas automaticamente para:
- **Bot:** @Gat_hub_bot
- **Chat ID:** 5649252463

### **Tipos de Notificação:**

#### **✅ Deploy Bem-Sucedido**
```
✅ Deploy Bem-Sucedido!

🏗️ Projeto: meu-projeto
📊 Status: SUCESSO
🔄 Rollback: NÃO EXECUTADO
🌐 URL: https://meu-projeto.vercel.app
```

#### **🚨 Rollback Executado**
```
🚨 Rollback Executado!

🏗️ Projeto: meu-projeto
📊 Status: FALHOU
🔄 Rollback: EXECUTADO COM SUCESSO
⚠️ Motivo: Health check falhou
```

## 🔍 Como Funciona a Auto-Detecção

Quando você não especifica `routes`, o sistema:

1. **Sempre testa:** `/` (página inicial)
2. **Verifica automaticamente:**
   - `/api/health`
   - `/health`
   - `/api/status`
   - `/login`
   - `/dashboard`
   - `/produtos`
   - `/posts`
   - `/sobre`
   - `/contato`
   - `/carrinho`
   - `/checkout`
3. **Detecta Next.js:** `/_next/static`
4. **Usa apenas as rotas que respondem**

## ⚡ Exemplo Completo

```yaml
name: Deploy Profissional

on:
  push:
    branches: [main, develop]
  workflow_dispatch:

jobs:
  deploy:
    uses: SeuUsuario/vercel-rollback-workflows/.github/workflows/vercel-rollback.yml@v1
    with:
      vercelProject: "meu-projeto-producao"
      routes: "/,/api/health,/login,/dashboard"
      healthCheckTimeout: 45
      maxRetries: 4
      enablePostDeployMonitoring: true
      monitoringDurationMinutes: 30
      monitoringIntervalMinutes: 5
    secrets:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
      VERCEL_TEAM_ID: ${{ secrets.VERCEL_TEAM_ID }}
      VERCEL_SCOPE: ${{ secrets.VERCEL_SCOPE }}
```

## 🆘 Primeiros Passos

1. **Escolha um projeto** para testar primeiro
2. **Configure os secrets** no GitHub
3. **Use o template básico** inicialmente
4. **Faça um push** e acompanhe os logs
5. **Verifique o Telegram** para as notificações
6. **Ajuste as configurações** conforme necessário

## 🔗 Links Úteis

- [Tokens da API Vercel](https://vercel.com/account/tokens)
- [Documentação do GitHub Actions](https://docs.github.com/en/actions)
- [Templates de Exemplo](../templates/)

---

**🎯 Próximo:** [Troubleshooting](./TROUBLESHOOTING.md) | **📋 Anterior:** [README](../README.md)
