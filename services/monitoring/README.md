# Monitoring — Portainer + Grafana + Prometheus + Alertmanager

## Services

| Service | Port | URL / Accès |
|---------|------|-----|
| Portainer | 9000 | https://portainer.akanzair.com |
| Grafana | 3000 | https://grafana.akanzair.com |
| Prometheus | 9090 | interne (192.168.56.11:9090) |
| Alertmanager | 9093 | interne (192.168.56.11:9093) |
| node-exporter | 9100 | interne — métriques host |
| cAdvisor | 8080 | interne — métriques conteneurs Docker |

## Alerting

- **Prometheus** scrape `node-exporter` (métriques host) et `cAdvisor` (métriques conteneurs), évalue les règles d'alerte (`rules.yml` — CPU, RAM, disque)
- **Alertmanager** (`v0.27.0`) reçoit les alertes déclenchées et envoie un email via SMTP Gmail
- **Grafana** affiche le dashboard (ID:1860) et gère son propre alerting en complément

## Déploiement

```bash
cd /opt/apps/monitoring
docker-compose up -d
```

## Fichiers de config

```
monitoring/
├── docker-compose.yml      ← définit les 6 services (portainer, grafana, prometheus, node-export, cadvisor, alertmanager)
├── prometheus.yml          ← scrape configs + lien vers Alertmanager + rule_files
├── rules.yml               ← règles d'alerte (HighCPU, HighMemory, HighDisk)
├── alertmanager.yml        ← config SMTP + receiver email
└── .env                    ← secrets SMTP / admin Grafana (jamais commité)
```

> ⚠️ Le nom de **service** Docker (clé YAML, ex: `node-export`) sert de nom DNS interne entre conteneurs — `prometheus.yml` doit cibler ce nom-là, pas le `container_name`.

## Prérequis

- Docker installé sur srv-app
- Nginx configuré (voir `lab03-control-node/nginx-configs/`) — uniquement pour Portainer et Grafana, exposés publiquement
