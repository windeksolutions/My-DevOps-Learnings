# Stage 1: build — installs dependencies, including anything needing a compiler
FROM python:3.12-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Stage 2: runtime — clean slim image, no build tools carried over
FROM python:3.12-slim
RUN useradd --create-home appuser
WORKDIR /app
COPY --from=build /root/.local /home/appuser/.local
COPY . .
RUN chown -R appuser:appuser /app
USER appuser
ENV PATH=/home/appuser/.local/bin:$PATH
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "auth_app.wsgi:application"]