# BudgetMaster — Application de gestion budgétaire

## Stack

| Composant | Rôle |
|-----------|------|
| Django + Gunicorn | Backend API REST |
| React + Vite | Frontend (fichiers statiques) |
| PostgreSQL | Base de données (srv-db) |
| Redis | File de tâches Celery |
| Celery Worker | Tâches asynchrones |
| Celery Beat | Tâches planifiées |

## URL

```
https://budget.akanzair.com
```

## Configuration

```bash
cp .env.example .env
# Remplir les valeurs dans .env
```

## Prérequis

- PostgreSQL sur srv-db avec base `budget` et user `budget_user`
- Node.js 18+ pour builder le frontend
- Nginx configuré pour servir les fichiers statiques

## Déploiement

```bash
# 1. Builder le frontend
cd frontend && npm install && npm run build
sudo mkdir -p /var/www/budget
sudo cp -r dist/* /var/www/budget/

# 2. Démarrer les services
cd /opt/apps/budget
docker-compose up -d --build

# 3. Vérifier
docker-compose logs -f backend
```
