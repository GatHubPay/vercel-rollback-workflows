# 🆘 Guia de Troubleshooting

## 🔍 Problemas Comuns e Soluções

### **❌ Deploy Falha Imediatamente**

#### **Sintomas:**
- Deploy não consegue conectar com Vercel
- Erro de autenticação
- Projeto não encontrado

#### **Possíveis Causas:**
1. **Secrets incorretos ou ausentes**
2. **Nome do projeto errado**
3. **Permissões insuficientes**

#### **Soluções:**
```bash
# 1. Verificar secrets no GitHub
# Settings > Secrets and variables > Actions
# Confirmar se existem:
# - VERCEL_TOKEN
# - VERCEL_TEAM_ID  
# - VERCEL_SCOPE

# 2. Testar token manualmente
curl -H "Authorization: Bearer SEU_TOKEN" \
  "https://api.vercel.com/v9/projects?teamId=SEU_TEAM_ID"

# 3. Verificar nome exato do projeto
# Deve ser exatamente como aparece no Vercel
```

---

### **⚠️ Health Checks Falhando (Falsos Positivos)**

#### **Sintomas:**
- Deploy é bem-sucedido mas health check falha
- Rollback desnecessário
- Rotas funcionando manualmente mas falhando no teste

#### **Possíveis Causas:**
1. **Timeout muito baixo**
2. **Rotas que precisam de autenticação**
3. **Cold start do Next.js**

#### **Soluções:**
```yaml
# Aumentar timeouts
with:
  healthCheckTimeout: 60  # Era 30
  maxRetries: 5           # Era 3

# Configurar rotas específicas (sem autenticação)
routes: "/,/api/health"  # Evitar /dashboard, /admin

# Para APIs que precisam de auth, criar rota de health
# pages/api/health.js
export default function handler(req, res) {
  res.status(200).json({ status: 'OK' })
}
```

---

### **🔄 Rollback Executado Desnecessariamente**

#### **Sintomas:**
- Aplicação funcionando mas rollback é executado
- Muitos rollbacks tardios

#### **Possíveis Causas:**
1. **Aplicação com cold start lento**
2. **Problemas temporários de rede**
3. **Configuração muito sensível**

#### **Soluções:**
```yaml
# Configuração menos sensível
with:
  healthCheckTimeout: 45
  maxRetries: 4
  monitoringDurationMinutes: 15  # Reduzir monitoramento
  monitoringIntervalMinutes: 10  # Verificar menos frequente
```

---

### **📱 Notificações do Telegram Não Chegam**

#### **Sintomas:**
- Deploy funciona mas não recebe notificações
- Erro de envio de notificação nos logs

#### **Possíveis Causas:**
1. **Bot bloqueado ou removido**
2. **Chat ID incorreto**
3. **Token do bot expirado**

#### **Soluções:**
```bash
# 1. Testar bot manualmente
curl -X POST "https://api.telegram.org/bot8045408592:AAHtPkn2DTPTrL3rs5lLFbV4vhPDEMAqodw/sendMessage" \
  -d "chat_id=5649252463" \
  -d "text=Teste manual"

# 2. Verificar se bot ainda existe
curl "https://api.telegram.org/bot8045408592:AAHtPkn2DTPTrL3rs5lLFbV4vhPDEMAqodw/getMe"

# 3. Verificar chat ID
curl "https://api.telegram.org/bot8045408592:AAHtPkn2DTPTrL3rs5lLFbV4vhPDEMAqodw/getUpdates"
```

---

### **🐌 Deploy Muito Lento**

#### **Sintomas:**
- Workflow demora muito para completar
- Timeout em operações

#### **Possíveis Causas:**
1. **Muitas rotas sendo testadas**
2. **Timeouts muito altos**
3. **Monitoramento muito longo**

#### **Soluções:**
```yaml
# Otimizar configurações
with:
  routes: "/,/api/health"           # Apenas rotas essenciais
  healthCheckTimeout: 20            # Reduzir timeout
  enablePostDeployMonitoring: false # Desabilitar se não crítico
```

---

### **🔍 Rollback Tardio Não Funciona**

#### **Sintomas:**
- Problemas detectados mas rollback não é executado
- Erro ao buscar deployment anterior

#### **Possíveis Causas:**
1. **Não há deployment anterior**
2. **Permissões insuficientes**
3. **Projeto muito novo**

#### **Soluções:**
```yaml
# Garantir que há pelo menos 2 deploys antes de usar
# Fazer deploy manual primeiro se necessário

# Verificar permissões do token Vercel
# Token deve ter permissão de "Deploy" e "Manage"
```

---

## 🔧 Debugging Avançado

### **Ver Logs Detalhados**
```bash
# No GitHub Actions, expandir seção "Health checks nas rotas"
# Procurar por:
# - Status codes retornados
# - Tempos de resposta
# - Rotas testadas
```

### **Testar Rotas Manualmente**
```bash
# Testar uma rota específica
curl -v -w "Status: %{http_code}\nTime: %{time_total}s\n" \
  https://seu-projeto.vercel.app/sua-rota

# Testar com timeout
curl --connect-timeout 30 --max-time 30 \
  https://seu-projeto.vercel.app/
```

### **Validar Configuração do Vercel**
```bash
# Listar projetos
curl -H "Authorization: Bearer SEU_TOKEN" \
  "https://api.vercel.com/v9/projects?teamId=SEU_TEAM_ID"

# Ver deployments recentes
curl -H "Authorization: Bearer SEU_TOKEN" \
  "https://api.vercel.com/v6/deployments?projectId=PROJETO_ID&limit=5"
```

---

## 📋 Checklist de Diagnóstico

Quando algo não funcionar, siga esta ordem:

### **1. Verificações Básicas**
- [ ] Secrets configurados no GitHub
- [ ] Nome do projeto correto
- [ ] Token Vercel válido
- [ ] Projeto existe no Vercel

### **2. Testes de Conectividade**
- [ ] Aplicação responde manualmente
- [ ] Rotas configuradas existem
- [ ] Não há autenticação bloqueando

### **3. Configurações do Workflow**
- [ ] Timeouts apropriados para o projeto
- [ ] Rotas específicas configuradas
- [ ] Monitoramento configurado adequadamente

### **4. Notificações**
- [ ] Bot do Telegram funcionando
- [ ] Chat ID correto
- [ ] Mensagens chegando

---

## 🆘 Ainda Precisa de Ajuda?

### **Informações para Reportar Problema:**
1. **URL do repositório**
2. **Nome do projeto Vercel**
3. **Logs do GitHub Actions** (seção que falhou)
4. **Configuração usada** (routes, timeouts, etc)
5. **Comportamento esperado vs atual**

### **Onde Buscar Ajuda:**
- **Issues no GitHub** do repositório
- **Logs detalhados** do GitHub Actions
- **Teste manual** das rotas
- **Documentação do Vercel** para problemas de API

---

**💡 Dica:** A maioria dos problemas são relacionados a configuração de rotas ou timeouts. Comece sempre testando manualmente se a aplicação está respondendo corretamente.
