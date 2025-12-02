# tests/test_tasks.py

from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.main import app
from app.database import Base
from app.routes.tasks import get_db

# Banco de testes: SQLite em arquivo temporário
SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={"check_same_thread": False}
)

TestingSessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

# Cria todas as tabelas antes de rodar os testes
Base.metadata.create_all(bind=engine)

# Override do get_db para usar banco de teste
def override_get_db():
    db = TestingSessionLocal()
    try:
        yield db
    finally:
        db.close()

app.dependency_overrides[get_db] = override_get_db

client = TestClient(app)


def test_create_task():
    response = client.post("/tasks/", json={"title": "Tarefa Teste", "description": "Testando"})
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == "Tarefa Teste"
    assert data["completed"] is False
    assert "id" in data


def test_read_tasks():
    response = client.get("/tasks/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_read_task():
    create = client.post("/tasks/", json={"title": "Ler tarefa"})
    task_id = create.json()["id"]

    response = client.get(f"/tasks/{task_id}")
    assert response.status_code == 200
    assert response.json()["title"] == "Ler tarefa"


def test_update_task():
    create = client.post("/tasks/", json={"title": "Atualizar"})
    task_id = create.json()["id"]

    response = client.put(
        f"/tasks/{task_id}",
        json={"title": "Atualizado", "completed": True}
    )
    assert response.status_code == 200
    assert response.json()["title"] == "Atualizado"
    assert response.json()["completed"] is True


def test_delete_task():
    create = client.post("/tasks/", json={"title": "Deletar"})
    task_id = create.json()["id"]

    response = client.delete(f"/tasks/{task_id}")
    assert response.status_code == 200
    assert response.json()["detail"] == "Task deleted"

    check = client.get(f"/tasks/{task_id}")
    assert check.status_code == 404
