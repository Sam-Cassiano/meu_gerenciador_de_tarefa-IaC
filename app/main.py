from fastapi import FastAPI
from app.routes import tasks
from app.database import engine, Base

app = FastAPI(title="Task Manager API")


# Cria as tabelas somente quando o servidor inicia
@app.on_event("startup")
def create_tables():
    Base.metadata.create_all(bind=engine)


# Inclui rotas
app.include_router(tasks.router)
