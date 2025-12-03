# 🚀 Task Manager API — FastAPI + CI/CD + IaC (Terraform)

Este projeto é uma **API de gerenciamento de tarefas (To-Do)** construída com **FastAPI**, usando:

- **CI/CD completo via GitHub Actions**
- **Infraestrutura automatizada com Terraform**
- **Deploy em Droplet DigitalOcean usando Docker Compose**
- **Banco PostgreSQL em produção e SQLite para testes**
- **Testes automatizados com PyTest**

Ele também demonstra como integrar **IaC + Docker + Pipelines** numa arquitetura real e fácil de estender.

---

## 🌐 URLs da Aplicação

| Serviço | URL |
|--------|------|
| API (GET /tasks) | http://45.55.58.91:5000/tasks |
| Swagger UI | http://45.55.58.91:5000/docs |

---

# 📂 Estrutura do Projeto

app/
├── main.py
├── models.py
├── schemas.py
├── database.py
└── routes/
└── tasks.py
terraform/
├── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
tests/
└── test_tasks.py
docker-compose.prod.yml
Dockerfile
cicd.yml
requirements.txt


---

# ⚙️ 1. API FastAPI

A API expõe endpoints CRUD para tarefas:

| Método | Rota | Descrição |
|--------|------|-----------|
| POST | `/tasks/` | Criar tarefa |
| GET | `/tasks/` | Listar tarefas |
| GET | `/tasks/{id}` | Buscar tarefa |
| PUT | `/tasks/{id}` | Atualizar |
| DELETE | `/tasks/{id}` | Remover |

### Modelo da Tarefa

json
{
  "id": 1,
  "title": "Minha tarefa",
  "description": "Detalhes",
  "completed": false
}
---

🧪 2. Testes Automatizados (PyTest)

Os testes usam SQLite temporário com override do banco principal.

Para rodar localmente:

pytest -q

🐳 3. Deploy com Docker + Docker Compose

O deploy em produção usa:

Dockerfile multi-stage

docker-compose.prod.yml

4. Infraestrutura como Código (Terraform)

Infraestrutura provisionada automaticamente:

Droplet DigitalOcean (Ubuntu 22.04)

Instala Docker + Docker Compose via cloud-init

Configuração do backend remoto (DO Spaces)

cd terraform
terraform init
terraform apply
terraform output

🔁 5. Pipeline CI/CD (GitHub Actions)

Arquivo: cicd.yml

Fases da Pipeline
1️⃣ Testes (CI)

Instala dependências

Executa PyTest

Só continua se passar

2️⃣ Provisionamento (IaC)

Executa Terraform

Cria/atualiza o Droplet

Captura o IP de saída

3️⃣ Deploy (CD)

Conecta via SSH

Login no DockerHub

Recria containers

Valida se subiu corretamente

🔐 6. Variáveis e Secrets Necessários
| Secret              | Descrição                      |
| ------------------- | ------------------------------ |
| `DO_TOKEN`          | Token da DigitalOcean          |
| `DO_SPACES_KEY`     | Key do DO Spaces               |
| `DO_SPACES_SECRET`  | Secret do DO Spaces            |
| `SSH_PRIVATE_KEY`   | Chave privada cadastrada na DO |
| `DOCKERHUB_USER`    | Usuário Docker Hub             |
| `DOCKERHUB_TOKEN`   | Token Docker Hub               |
| `POSTGRES_PASSWORD` | Senha do PostgreSQL            |


🧱 Exemplos de Requisições
Criar tarefa

POST /tasks/
{
  "title": "Comprar pão",
  "description": "Integral"
}

Atualizar tarefa

PUT /tasks/1
{
  "title": "Comprar pão e leite",
  "completed": true
}

🛠 Tecnologias Utilizadas

FastAPI

SQLAlchemy

PostgreSQL / SQLite

Docker & Docker Compose

Terraform

DigitalOcean

GitHub Actions

PyTest

🎉 Conclusão

Esse projeto demonstra um fluxo completo: código → testes → infraestrutura → deploy automático.




