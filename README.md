# 🚀 Vercel Deploy + Rollback Automático

> Sistema profissional de deploy com rollback automático para projetos Next.js

## 🎯 O QUE É ESTE PROJETO?

Este é um **workflow reutilizável** do GitHub Actions que:

- ✅ Faz deploy automático no Vercel
- 🔍 Testa se tudo está funcionando
- 🔄 Faz rollback automático se algo quebrar
- 📱 Te notifica no Telegram sobre tudo
- 🕐 Monitora por 30 minutos para detectar problemas tardios

## 🏗️ COMO FUNCIONA?

### **1 Repositório Central** (este aqui)
Contém o workflow inteligente que faz todo o trabalho pesado.

### **Cada Projeto Seu** 
Só precisa de 1 arquivo pequeno (15 linhas) que chama este workflow.

```yaml
# .github/workflows/deploy.yml (em cada projeto)
name: Deploy Automático
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

## 📋 STATUS DO PROJETO

| Fase | Status | Descrição |
|------|--------|-----------|
| **Fase 1** | 🟡 Em Andamento | Preparação do repositório |
| **Fase 2** | ⚪ Pendente | Desenvolvimento do workflow |
| **Fase 3** | ⚪ Pendente | Funcionalidades avançadas |
| **Fase 4** | ⚪ Pendente | Testes e validação |
| **Fase 5** | ⚪ Pendente | Implementação nos projetos |

## 🤖 CONFIGURAÇÃO DO TELEGRAM

**Bot Token:** `8045408592:AAHtPkn2DTPTrL3rs5lLFbV4vhPDEMAqodw`  
**Chat ID:** `5649252463`  
**Status:** ✅ Configurado e funcionando

## 📚 DOCUMENTAÇÃO

- 📋 [**PLANO DE IMPLEMENTAÇÃO**](./PLANO-IMPLEMENTACAO.md) - Cronograma detalhado
- 🔧 [**GUIA DE CONFIGURAÇÃO**](./docs/SETUP.md) - Como configurar nos projetos *(em breve)*
- 🆘 [**TROUBLESHOOTING**](./docs/TROUBLESHOOTING.md) - Resolução de problemas *(em breve)*

## 🚀 INÍCIO RÁPIDO

### **Para Usar Agora** (quando pronto)
1. Copie o template para seu projeto
2. Configure o nome do projeto Vercel
3. Adicione os secrets necessários
4. Faça push e veja a mágica acontecer!

### **Para Contribuir**
1. Leia o [Plano de Implementação](./PLANO-IMPLEMENTACAO.md)
2. Escolha uma fase para trabalhar
3. Siga os padrões estabelecidos

## 🔐 SECRETS NECESSÁRIOS

Cada projeto precisa destes secrets configurados no GitHub:

| Secret | Onde Obter | Descrição |
|--------|------------|-----------|
| `VERCEL_TOKEN` | [vercel.com/account/tokens](https://vercel.com/account/tokens) | Token de acesso da API |
| `VERCEL_TEAM_ID` | Dashboard do Vercel | ID do seu time/organização |
| `VERCEL_SCOPE` | Dashboard do Vercel | Nome do seu time/organização |

## 📊 EXEMPLOS DE USO

### **E-commerce**
```yaml
with:
  vercelProject: "minha-loja"
  routes: "/,/produtos,/carrinho,/checkout"
```

### **Blog**
```yaml
with:
  vercelProject: "meu-blog"
  routes: "/,/posts,/sobre,/contato"
```

### **SaaS/Dashboard**
```yaml
with:
  vercelProject: "meu-saas"
  routes: "/,/login,/dashboard,/api/health"
```

## 🎯 ROADMAP

- [x] **v0.1** - Planejamento e estrutura
- [ ] **v0.5** - Workflow básico funcionando
- [ ] **v0.8** - Monitoramento pós-deploy
- [ ] **v1.0** - Sistema completo e testado
- [ ] **v1.1** - Otimizações e melhorias
- [ ] **v2.0** - Funcionalidades avançadas

## 🤝 CONTRIBUINDO

Este projeto está em desenvolvimento ativo. Contribuições são bem-vindas!

### **Como Ajudar:**
1. Reporte bugs ou problemas
2. Sugira melhorias
3. Contribua com código
4. Melhore a documentação

## 📄 LICENÇA

MIT License - Use à vontade em seus projetos!

## 📞 SUPORTE

- 🐛 **Issues:** Para bugs e problemas
- 💡 **Discussions:** Para ideias e sugestões
- 📧 **Email:** Para questões específicas

---

**⚡ Status:** Em Desenvolvimento Ativo  
**🎯 Próxima Milestone:** Workflow Básico Funcionando  
**📅 Última Atualização:** $(date)

---

> 💡 **Dica:** Acompanhe o [Plano de Implementação](./PLANO-IMPLEMENTACAO.md) para ver o progresso detalhado!