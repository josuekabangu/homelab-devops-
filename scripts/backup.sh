#!/bin/bash
# Script de backup automatique — srv-app
# Cron : 0 2 * * * /opt/scripts/backup.sh >> /opt/backups/backup.log 2>&1

source /opt/scripts/.env

DATE=$(date +%Y%m%d_%H%M)
BACKUP_DIR="/opt/backups"

mkdir -p $BACKUP_DIR/postgres
mkdir -p $BACKUP_DIR/volumes

echo "=== BACKUP $DATE ==="

# PostgreSQL — base n8n
echo "Backup n8n..."
PGPASSWORD="$N8N_DB_PASSWORD" pg_dump \
    -U n8n_user \
    -h 192.168.56.12 \
    n8n > $BACKUP_DIR/postgres/n8n_$DATE.sql

# PostgreSQL — base budget
echo "Backup budget..."
PGPASSWORD="$BUDGET_DB_PASSWORD" pg_dump \
    -U budget_user \
    -h 192.168.56.12 \
    budget > $BACKUP_DIR/postgres/budget_$DATE.sql

# Volumes Docker
echo "Backup volumes Docker..."
docker run --rm \
    -v monitoring_portainer_data:/data \
    -v $BACKUP_DIR/volumes:/backup \
    alpine tar czf /backup/portainer_$DATE.tar.gz /data 2>/dev/null

docker run --rm \
    -v monitoring_grafana_data:/data \
    -v $BACKUP_DIR/volumes:/backup \
    alpine tar czf /backup/grafana_$DATE.tar.gz /data 2>/dev/null

# Rotation — supprimer backups > 7 jours
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete

echo "✅ Backup terminé : $DATE"
