# Meu Gerenciador de Tarefas

## Descrição

Aplicação de gerenciamento de tarefas construída com FastAPI, PostgreSQL e Docker. Este projeto possui pipeline de CI/CD configurado com GitHub Actions, que garante testes automáticos, build de imagens Docker e deploy automático no servidor de produção.

---

## Funcionalidades

* Criar, ler, atualizar e deletar tarefas (CRUD).
* Deploy automático via GitHub Actions no servidor remoto.
* Multi-container: API + banco de dados PostgreSQL.

---

## Configuração do Servidor

Antes do deploy automático, é necessário configurar o servidor:

1. Conectar via SSH ao servidor:

```bash
ssh root@138.197.195.201
```

2. Criar o diretório do projeto:

```bash
mkdir -p ~/meu_gerenciador_de_tarefas
cd ~/meu_gerenciador_de_tarefas
```

3. Criar o arquivo `.env` com as variáveis de produção:

```env
DOCKERHUB_USER=sammmghj
IMAGE_TAG=latest
POSTGRES_PASSWORD=senha123
```

4. Certifique-se que Docker e Docker Compose estão instalados:

```bash
docker --version
docker-compose --version
```

---

## GitHub Actions (CI/CD)

O workflow `cicd.yml` automatiza o deploy e testes:

* **Disparador:** push na branch `main`.
* **Etapas:**

  1. Checkout do repositório.
  2. Configuração do Python.
  3. Instalação de dependências.
  4. Execução de testes unitários (`pytest`).
  5. Login no Docker Hub.
  6. Build da imagem Docker.
  7. Push da imagem para Docker Hub.
  8. Deploy no servidor via SSH, atualizando os containers.

---

## Secrets necessários no GitHub

Para o deploy funcionar corretamente, configure os seguintes Secrets no repositório:

| Nome do Secret    | Descrição                           |
| ----------------- | ----------------------------------- |
| `DOCKERHUB_USER`  | Usuário do Docker Hub               |
| `DOCKERHUB_TOKEN` | Token/senha do Docker Hub           |
| `SSH_HOST`        | IP ou hostname do servidor remoto   |
| `SSH_USER`        | Usuário para conexão SSH            |
| `SSH_KEY`         | Chave privada SSH para autenticação |

---

## Testes

Os testes unitários cobrem todas as rotas do CRUD:

```bash
pytest
```

---

## Deploy

Após o push na branch `main`, o workflow do GitHub Actions:

* Constrói a imagem Docker da aplicação.
* Envia a imagem para o Docker Hub.
* Atualiza automaticamente os containers no servidor de produção.

**URL da aplicação:**

```
http://138.197.195.201:5000/tasks
http://138.197.195.201:5000/docs#/
```

---

## Badge de Status

Status do pipeline:
![CI/CD](https://github.com/Sam-Cassiano/meu_gerenciador_de_tarefa/actions/workflows/cicd.yml/badge.svg)

---

## Observações

* O arquivo `.env` **não deve ser versionado**.
* Sempre use SHA do commit como tag da imagem Docker em produção para versionamento seguro.
