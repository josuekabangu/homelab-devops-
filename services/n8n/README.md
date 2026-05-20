# n8n — Automatisation de workflows

## Service

| Service | Port | URL |
|---------|------|-----|
| n8n | 5678 | https://n8n.akanzair.com |

## Prérequis

- PostgreSQL sur srv-db avec base `n8n` et user `n8n_user`
- pg_hba.conf autorise `192.168.56.11/32`

## Configuration

```bash
cp .env.example .env
# Remplir les valeurs dans .env
```

## Déploiement

```bash
cd /opt/apps/n8n
docker-compose up -d
docker-compose logs -f n8n
```
