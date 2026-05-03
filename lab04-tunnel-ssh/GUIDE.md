# Guide — Lab04 : Tunnel SSH

## Objectif
Exposer Nginx (srv-app:80) sur internet via un tunnel SSH vers le VPS.

## Architecture
```
Navigateur
    │
    ▼
akanzair.com:8080 (VPS — 72.62.21.162)
    │  tunnel SSH -R
    ▼
srv-app:80 (192.168.56.11)
    │
    ▼
Nginx ✅
```

## Prérequis
- lab03 terminé (Nginx installé sur srv-app)
- VPS accessible : ssh root@72.62.21.162
- DNS : akanzair.com → 72.62.21.162

## Étapes

### 1. Configurer le VPS

```bash
# Ouvrir le port 8080
ufw allow 8080

# Activer GatewayPorts
echo "GatewayPorts yes" >> /etc/ssh/sshd_config
systemctl restart ssh
```

### 2. Générer les clés SSH sur srv-app

```bash
vagrant ssh app
ssh-keygen -t ed25519 -C "srv-app"
ssh-copy-id root@72.62.21.162
```

### 3. Créer le tunnel

```bash
# Depuis srv-app
ssh -R 8080:localhost:80 root@72.62.21.162
```

### 4. Tester

Depuis le VPS :
```bash
curl http://localhost:8080   # doit retourner la page Nginx
```

Depuis internet :
```
http://akanzair.com:8080
```

## Points clés
- `-R` = Remote — le trafic distant arrive sur le service local
- `GatewayPorts yes` = rend le tunnel accessible depuis internet (pas seulement localhost)
- Le port doit être ouvert dans `ufw` côté VPS
- Le service SSH sur Ubuntu 24.04 s'appelle `ssh` (pas `sshd`)

## Erreurs fréquentes

| Erreur | Cause | Solution |
|--------|-------|----------|
| `ERR_CONNECTION_TIMED_OUT` | Port fermé dans ufw | `ufw allow 8080` |
| `Unit sshd.service not found` | Mauvais nom sur Ubuntu 24.04 | `systemctl restart ssh` |
| Lignes corrompues dans sshd_config | Commandes collées sur une ligne | `sed -i '/ligne corrompue/d' /etc/ssh/sshd_config` |
