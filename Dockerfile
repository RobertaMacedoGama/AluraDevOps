# 1. Define a imagem base
# Usamos a imagem python:3.10-slim, que é otimizada e alinhada com o readme.md do projeto.
FROM python:3.13.5-alpine3.22

# 2. Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Copia o arquivo de dependências
# Fazemos isso antes de copiar o resto do código para aproveitar o cache do Docker.
# As dependências só serão reinstaladas se o requirements.txt mudar.
COPY requirements.txt .

# 4. Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o restante do código da aplicação
COPY . .

# 6. Expõe a porta que a aplicação vai rodar
EXPOSE 8000

# 7. Define o comando para iniciar a aplicação
# Para produção, removemos o --reload.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
