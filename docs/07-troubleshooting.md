# 🔧 Troubleshooting - Resolver Problemas

## 🎯 **Problemas Mais Comuns**

Este guia resolve **95%** dos problemas que você pode encontrar com os workflows de deploy.

---

## 🔐 **Problemas de Secrets/Autenticação**

### **❌ "Invalid Vercel token"**

#### **🔍 Sintomas:**
```
Error: Invalid token provided
Deploy failed: Unauthorized
```

#### **💡 Soluções:**
1. **Verificar token:**
   ```bash
   curl -H "Authorization: Bearer SEU_TOKEN" \
        "https://api.vercel.com/v2/user"
   ```

2. **Gerar novo token:**
   - Ir em [vercel.com/account/tokens](https://vercel.com/account/tokens)
   - Criar token com **Full Account** access
   - Atualizar secret `VERCEL_TOKEN`

3. **Verificar expiração:**
   - Tokens podem expirar
   - Sempre criar tokens **sem expiração** ou **1 year**

---

### **❌ "Project not found"**

#### **🔍 Sintomas:**
```
Error: Project "meu-projeto" not found
The specified project does not exist
```

#### **💡 Soluções:**
1. **Verificar nome exato:**
   ```bash
   # Listar projetos:
   npx vercel ls --token="SEU_TOKEN" --scope="SUA_TEAM"
   ```

2. **Verificar VERCEL_SCOPE:**
   - Deve ser **exatamente** o nome da team
   - Ou seu username se for pessoal

3. **Verificar permissões:**
   - Token deve ter acesso ao projeto
   - Verificar se você é owner/member da team

---

### **❌ "Telegram bot not found"**

#### **🔍 Sintomas:**
```
Error: Bot token invalid
Chat not found
```

#### **💡 Soluções:**
1. **Testar bot:**
   ```bash
   curl "https://api.telegram.org/botSEU_TOKEN/getMe"
   ```

2. **Testar chat:**
   ```bash
   curl "https://api.telegram.org/botSEU_TOKEN/sendMessage?chat_id=SEU_CHAT_ID&text=teste"
   ```

3. **Obter chat_id correto:**
   ```bash
   # Enviar mensagem para o bot e depois:
   curl "https://api.telegram.org/botSEU_TOKEN/getUpdates"
   ```

---

## 🚀 **Problemas de Deploy**

### **❌ "Deploy timeout"**

#### **🔍 Sintomas:**
```
Error: Deploy timed out after 5 minutes
Vercel deployment failed
```

#### **💡 Soluções:**
1. **Verificar build:**
   ```bash
   # Local:
   npm run build
   # Verificar se build funciona localmente
   ```

2. **Verificar logs Vercel:**
   - Ir no dashboard Vercel
   - Ver logs do deployment
   - Identificar erro específico

3. **Aumentar timeout (temporário):**
   ```yaml
   # No workflow:
   timeout-minutes: 15  # Padrão é 5
   ```

---

### **❌ "Build failed"**

#### **🔍 Sintomas:**
```
Error: Build failed with exit code 1
npm ERR! Missing dependency
```

#### **💡 Soluções:**
1. **Verificar package.json:**
   ```json
   {
     "scripts": {
       "build": "next build"  // Deve existir
     },
     "dependencies": {
       // Todas dependências necessárias
     }
   }
   ```

2. **Testar build local:**
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   npm run build
   ```

3. **Verificar Node.js version:**
   ```json
   // package.json
   {
     "engines": {
       "node": ">=18.0.0"
     }
   }
   ```

---

## 🔍 **Problemas de Health Check**

### **❌ "Site não responde (HTTP 500)"**

#### **🔍 Sintomas:**
```
❌ FALHA CRÍTICA: Site não responde (HTTP 500)
Health check falhou
```

#### **💡 Soluções:**
1. **Verificar logs Vercel:**
   - Function logs
   - Build logs
   - Runtime errors

2. **Testar URL manualmente:**
   ```bash
   curl -I https://seusite.com/
   ```

3. **Verificar variáveis ambiente:**
   - Database URLs
   - API keys
   - Environment variables

---

### **❌ "Site muito lento (>5s)"**

#### **🔍 Sintomas:**
```
❌ FALHA CRÍTICA: Site muito lento (8.2s > 5s)
```

#### **💡 Soluções:**
1. **Aumentar timeout temporariamente:**
   ```yaml
   health_check_timeout: 60  # Padrão é 30
   ```

2. **Otimizar performance:**
   - Otimizar imagens
   - Code splitting
   - Lazy loading

3. **Verificar cold start:**
   - Vercel pode ter cold start
   - Aguardar alguns minutos

---

### **❌ "Página de erro detectada"**

#### **🔍 Sintomas:**
```
❌ FALHA CRÍTICA: Página de erro detectada
• BAILOUT_TO_CLIENT_SIDE_RENDERING
```

#### **💡 Soluções:**
1. **Erro Next.js específico:**
   ```javascript
   // Verificar getServerSideProps/getStaticProps
   export async function getServerSideProps() {
     try {
       // Seu código aqui
     } catch (error) {
       return { notFound: true };
     }
   }
   ```

2. **Verificar hydration:**
   - Diferenças entre server/client
   - useEffect para código client-only

---

## 🔄 **Problemas de Rollback**

### **❌ "Rollback falhou"**

#### **🔍 Sintomas:**
```
❌ ROLLBACK FALHOU
Nenhum deployment seguro encontrado
```

#### **💡 Soluções:**
1. **Verificar deployments:**
   ```bash
   npx vercel ls SEU_PROJETO --token="TOKEN" --scope="SCOPE"
   ```

2. **Deploy manual emergencial:**
   ```bash
   # Fazer deploy de versão estável manualmente
   git checkout COMMIT_ESTAVEL
   npx vercel --prod --token="TOKEN"
   ```

3. **Verificar permissões:**
   - Token deve poder promover deployments
   - Verificar scope correto

---

## 🎯 **Problemas de Canary**

### **❌ "Canary falhou - erro alto"**

#### **🔍 Sintomas:**
```
🚨 CANARY REPROVADO
❌ Canary falhou (erro: 2.1%)
Taxa limite: 0.5%
```

#### **💡 Análise:**
1. **Verificar se é problema real:**
   ```bash
   # Testar URL manualmente várias vezes:
   for i in {1..10}; do
     curl -s -w "%{http_code}\n" https://seusite.com/ | tail -1
   done
   ```

2. **Verificar logs específicos:**
   - Vercel Function logs
   - Error tracking (Sentry, etc)

3. **Ajustar threshold se necessário:**
   ```yaml
   error_threshold: 1.0  # Aumentar temporariamente
   ```

---

### **❌ "Canary falhou - latência alta"**

#### **🔍 Sintomas:**
```
🚨 CANARY REPROVADO
❌ Latência: 3200ms > 3000ms
```

#### **💡 Soluções:**
1. **Verificar se é cold start:**
   - Primeiras requisições são mais lentas
   - Aguardar cache warming

2. **Otimizar performance:**
   - Database queries
   - API calls
   - Asset loading

3. **Ajustar threshold:**
   ```yaml
   latency_threshold: 5000  # Aumentar temporariamente
   ```

---

## 📱 **Problemas de Notificações**

### **❌ "Notificação não chega"**

#### **💡 Soluções:**
1. **Verificar bot ativo:**
   ```bash
   curl "https://api.telegram.org/botSEU_TOKEN/getMe"
   ```

2. **Verificar chat_id:**
   - Chat pessoal: número positivo
   - Grupo: número negativo
   - Canal: número negativo longo

3. **Verificar permissões:**
   - Bot deve estar no grupo/canal
   - Bot deve ter permissão para enviar mensagens

---

## 🔧 **Problemas de Workflow**

### **❌ "Workflow não executa"**

#### **🔍 Sintomas:**
```
Workflow não aparece no Actions
Push não triggera deploy
```

#### **💡 Soluções:**
1. **Verificar sintaxe YAML:**
   ```bash
   # Validar YAML online ou:
   python -c "import yaml; yaml.safe_load(open('.github/workflows/deploy.yml'))"
   ```

2. **Verificar path:**
   ```
   .github/workflows/deploy.yml  ✅ Correto
   .github/workflow/deploy.yml   ❌ Errado (falta 's')
   github/workflows/deploy.yml   ❌ Errado (falta '.')
   ```

3. **Verificar branch:**
   ```yaml
   on:
     push:
       branches: [main, master]  # Verificar nome correto da branch
   ```

---

### **❌ "Workflow usa reutilizável não encontrado"**

#### **🔍 Sintomas:**
```
Error: Repository not found
Workflow file not found
```

#### **💡 Soluções:**
1. **Verificar referência:**
   ```yaml
   uses: MinhaOrg/workflows/.github/workflows/deploy-universal-reusable.yml@main
   #     ^^^^^^^^^ ^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ^^^^
   #     Org       Repo      Path exato                                Tag/Branch
   ```

2. **Verificar permissões:**
   - Repo workflows deve ser público
   - Ou configurar access token

---

## 🚨 **Problemas Críticos**

### **❌ "Site está offline"**

#### **🚨 Ação Imediata:**
1. **Rollback manual:**
   ```bash
   # Listar deployments:
   npx vercel ls SEU_PROJETO --token="TOKEN"
   
   # Promover deployment anterior:
   npx vercel promote DEPLOYMENT_URL --token="TOKEN" --yes
   ```

2. **Verificar status Vercel:**
   - [status.vercel.com](https://status.vercel.com)
   - Pode ser problema na plataforma

---

### **❌ "Rollback não funciona"**

#### **🚨 Ação Imediata:**
1. **Deploy manual versão estável:**
   ```bash
   git checkout TAG_ESTAVEL
   npx vercel --prod --token="TOKEN" --yes
   ```

2. **Pausar deploys automáticos:**
   - Desativar workflow temporariamente
   - Investigar problema

---

## 📊 **Debug Avançado**

### **🔍 Logs Detalhados:**
```yaml
# Adicionar no workflow para debug:
- name: Debug Info
  run: |
    echo "Vercel Token: ${VERCEL_TOKEN:0:10}..."
    echo "Project: ${{ inputs.project_name }}"
    echo "URL: ${{ inputs.site_url }}"
    echo "Environment: ${{ inputs.environment }}"
```

### **🧪 Testar Localmente:**
```bash
# Simular health check:
curl -s -w "HTTPSTATUS:%{http_code};TIME:%{time_total}" \
     --max-time 30 "https://seusite.com/"

# Simular múltiplas requisições:
for i in {1..20}; do
  echo "Request $i:"
  curl -s -w "Status: %{http_code} | Time: %{time_total}s\n" \
       -o /dev/null "https://seusite.com/"
  sleep 2
done
```

---

## 📞 **Quando Pedir Ajuda**

### **🆘 Problemas que precisam de suporte:**
- Vercel platform issues
- Tokens não funcionam mesmo corretos
- Workflows param de funcionar sem mudanças
- Performance issues persistentes

### **📝 Informações para incluir:**
- Logs completos do GitHub Actions
- URL do deployment Vercel
- Configuração do workflow (sem secrets)
- Passos para reproduzir o problema

---

**A maioria dos problemas tem solução simples!** 🔧✨

**Em caso de dúvida: teste localmente primeiro!** 🧪🚀
