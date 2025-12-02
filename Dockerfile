# Stage 1: Build
FROM python:3.12-alpine AS builder

WORKDIR /app

# Dependências necessárias para compilar psycopg2-binary
RUN apk add --no-cache \
    postgresql-dev \
    gcc \
    musl-dev \
    linux-headers

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

COPY . .

# Stage 2: Runtime
FROM python:3.12-alpine

WORKDIR /app

# Dependências runtime do Postgres
RUN apk add --no-cache \
    postgresql-libs

# Copia libs Python instaladas no builder
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app

ENV PATH=/root/.local/bin:$PATH

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5000"]
