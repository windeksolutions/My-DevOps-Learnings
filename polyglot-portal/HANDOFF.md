# Polyglot Portal - Local Development Handoff

## 1. Local Startup Commands

### Auth Service (Django)
```bash
cd polyglot-portal/auth-service

# Create virtual environment and install dependencies
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Apply database migrations (if needed)
python manage.py migrate

# Start Django development server (binds to 0.0.0.0:8000)
python manage.py runserver 0.0.0.0:8000
```

### Dashboard Service (Node.js/Express)
```bash
cd polyglot-portal/dashboard-service

# Install dependencies
npm install

# Start the server (binds to 0.0.0.0:3000)
npm start
```

### Analytics Service (Go)
```bash
cd polyglot-portal/analytics-service

# Build the application
go build -o analytics-service .

# Run the application (binds to 0.0.0.0:8080)
./analytics-service
```

## 2. Required Environment Variables

### Auth Service
| Variable | Purpose | Default/Example |
|----------|---------|-----------------|
| `DJANGO_SECRET_KEY` | Django SECRET_KEY (must be set) | `django-insecure-xxxxxx` |
| `DJANGO_DEBUG` | Debug mode flag | `False` |
| `DJANGO_ALLOWED_HOSTS` | Comma-separated allowed hosts | `localhost,127.0.0.1` |
| `DB_HOST` | PostgreSQL database host | `localhost` |
| `DB_NAME` | Database name | `auth_db` |
| `DB_USER` | Database user | `auth_user` |
| `DB_PASS` | Database password | *(required)* |
| `DJANGO_LOG_LEVEL` | Logging level | `INFO` |

### Dashboard Service
| Variable | Purpose | Default/Example |
|----------|---------|-----------------|
| `PORT` | Application port (optional) | `3000` |

### Analytics Service
| Variable | Purpose | Default/Example |
|----------|---------|-----------------|
| `PORT` | Application port (optional) | `8080` |

## 3. Port Mapping and Health Endpoints

| Service | Internal Port | Health Endpoint URL | Expected Response |
|---------|---------------|---------------------|-------------------|
| Auth Service | 8000 | `http://localhost:8000/health` | `{"status":"healthy","service":"auth-service"}` |
| Dashboard Service | 3000 | `http://localhost:3000/health` | `{"status":"healthy","service":"dashboard-service"}` |
| Analytics Service | 8080 | `http://localhost:8080/health` | `{"status":"healthy","service":"analytics-service"}` |

## 4. Service Bindings and Logging

All three services are configured to:
- **Bind to `0.0.0.0`** (never `localhost`/`127.0.0.1`) – required for containerized execution
- **Log exclusively to stdout/stderr** – no file-based logging
- **Provide a `/health` endpoint** returning JSON with status information
- **Handle graceful shutdown** where supported (Django and Go handle SIGTERM; Node.js runs in foreground)

## 5. Security & Configuration

- **`SECRET_KEY`** is read exclusively from environment variable (`DJANGO_SECRET_KEY`) with no hardcoded fallback
- **`DEBUG`** is read from environment variable (`DJANGO_DEBUG`) with default `False` if unset
- **`ALLOWED_HOSTS`** is driven by environment variable (`DJANGO_ALLOWED_HOSTS`) with fallback to empty list
- **Database credentials** are all environment-variable driven
- **No secrets** are hardcoded in source files

Each service's configuration is fully externalized to environment variables, ensuring zero risk of credential leakage in the repository.

## Settings Consolidation

- Removed `auth-service/config/settings.py` because it was empty and not loaded by Django.
- `auth-service/auth_app/settings.py` is now the single source of truth for all environment-driven Django configuration.
- `auth-service/requirements.txt` contains exactly: `django`, `psycopg2-binary`, `gunicorn`, and `djangorestframework`.