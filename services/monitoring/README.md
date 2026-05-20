# Monitoring — Portainer + Grafana

## Services

| Service | Port | URL |
|---------|------|-----|
| Portainer | 9000 | https://portainer.akanzair.com |
| Grafana | 3000 | https://grafana.akanzair.com |

## Déploiement

```bash
cd /opt/apps/monitoring
docker-compose up -d
```

## Prérequis

- Docker installé sur srv-app
- Nginx configuré (voir `lab03-control-node/nginx-configs/`)
