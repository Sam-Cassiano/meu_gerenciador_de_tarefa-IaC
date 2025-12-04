# 🚀 Task Manager API — FastAPI + CI/CD + IaC (Terraform)

Este projeto é uma API de gerenciamento de tarefas (To-Do) construída com **FastAPI**, usando:

- CI/CD completo via GitHub Actions  
- Infraestrutura automatizada com Terraform  
- Deploy em Droplet DigitalOcean usando Docker Compose  
- Banco PostgreSQL em produção e SQLite para testes  
- Testes automatizados com PyTest  

Ele também demonstra como integrar **IaC + Docker + Pipelines** numa arquitetura real e fácil de estender.

## 📌 Arquitetura Geral

GitHub → (CI) Testes → (IaC) Terraform → Provisiona Droplet → (CD) Deploy Docker


**Produção:**
- FastAPI rodando em container Docker
- PostgreSQL 15 (Docker)
- Droplet DigitalOcean provisionado automaticamente
- Deploy contínuo a cada push no branch `main`

## 🌐 URLs da aplicação

| Serviço         | URL                              |
|-----------------|----------------------------------|
| API (GET /tasks)| http://45.55.58.91:5000/tasks    |
| Swagger UI      | http://45.55.58.91:5000/docs     |


## ⚙️ 1. API FastAPI

A API expõe endpoints CRUD para tarefas:

| Método   | Rota            | Descrição            |
|----------|------------------|----------------------|
| POST     | `/tasks/`        | Criar tarefa         |
| GET      | `/tasks`         | Listar tarefas       |
| GET      | `/tasks/{id}`    | Buscar tarefa        |
| PUT      | `/tasks/{id}`    | Atualizar tarefa     |
| DELETE   | `/tasks/{id}`    | Remover tarefa       |

**Modelo da Tarefa**

```json
{
  "id": 1,
  "title": "Minha tarefa",
  "description": "Detalhes",
  "completed": false
}
```
##
🌍4. Infraestrutura como Código (Terraform)

Infraestrutura provisionada:

Droplet DigitalOcean (Ubuntu 22.04)

Instala Docker + Docker Compose via cloud-init

Configuração do backend remoto (DO Spaces)

Comandos básicos:
```
cd terraform
terraform init
terraform apply
terraform output

```
##

🔁 5. Pipeline CI/CD (GitHub Actions)
Arquivo: .github/workflows/cicd.yml
💡 Fases da pipeline

Testes (CI)
Instala dependências
Executa PyTest
Só continua se os testes passarem

Provisionamento (IaC)
Executa Terraform
Cria/atualiza o Droplet
Captura o IP
Expõe o IP como output para o próximo job

Deploy (CD)

Conecta via SSH no Droplet

Faz login no DockerHub

Derruba containers antigos

Puxa nova imagem

Sobe containers atualizados

Valida se tudo subiu corretamente


Tudo 100% automatizado 🔥

##
🔐 6. Variáveis e Secrets Necessários (GitHub Secrets)
| Secret              | Descrição                           |
| ------------------- | ----------------------------------- |
| `DO_TOKEN`          | Token da DigitalOcean               |
| `DO_SPACES_KEY`     | Key do DO Spaces                    |
| `DO_SPACES_SECRET`  | Secret do DO Spaces                 |
| `SSH_PRIVATE_KEY`   | Chave privada cadastrada no droplet |
| `DOCKERHUB_USER`    | Usuário Docker Hub                  |
| `DOCKERHUB_TOKEN`   | Token Docker Hub                    |
| `POSTGRES_PASSWORD` | Senha do PostgreSQL                 |

🎉 Conclusão
código → teste → provisionamento → deploy automatizado



