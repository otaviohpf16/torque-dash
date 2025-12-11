# Usa Python 3.9 (mais compatível com projetos dessa época)
FROM python:3.9-slim

# Define diretório de trabalho
WORKDIR /app

# Instala dependências do sistema necessárias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copia os requirements e instala
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código
COPY . .

# Expõe a porta 8050 (padrão do Dash)
EXPOSE 8050

# Comando de execução (Gunicorn rodando o objeto 'server' dentro de 'app.py')
CMD ["gunicorn", "--bind", "0.0.0.0:8050", "app:server"]
