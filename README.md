# 🏗️ Homelab DevOps — Infrastructure as Code

> Infrastructure complète : VMs Vagrant → Configuration Ansible → Docker → Tunnel SSH → HTTPS → Applications en production sur akanzair.com

[![Vagrant](https://img.shields.io/badge/Vagrant-2.x-blue)](https://www.vagrantup.com/)
[![Ansible](https://img.shields.io/badge/Ansible-2.10-red)](https://www.ansible.com/)
[![Docker](https://img.shields.io/badge/Docker-29.x-blue)](https://www.docker.com/)
[![HTTPS](https://img.shields.io/badge/HTTPS-Let's%20Encrypt-green)](https://letsencrypt.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## 🎯 Objectif

Transformer un PC Windows en serveur professionnel hébergeant plusieurs applications, accessibles sur internet via akanzair.com, en appliquant les pratiques DevOps réelles :
- **Infrastructure as Code** — tout est décrit dans des fichiers, rien à la main
- **Idempotence** — les scripts peuvent être relancés sans danger
- **Séparation des responsabilités** — infra, apps, secrets clairement séparés

---

## 🗺️ Architecture

```
Internet
    │
    ▼
akanzair.com (VPS — 72.62.21.162)
    │  tunnel SSH autossh (ports 80 + 443)
    ▼
srv-app (192.168.56.11) — Nginx reverse proxy
    ├── https://portainer.akanzair.com  → Portainer :9000
    ├── https://grafana.akanzair.com    → Grafana :3000
    ├── https://llm.akanzair.com        → Ollama :11434 (GPU)
    ├── https://n8n.akanzair.com        → n8n :5678
    └── https://budget.akanzair.com     → BudgetMaster :8000

srv-db (192.168.56.12) — PostgreSQL
    ├── base n8n
    └── base budget

PC Windows (hôte) — Ollama GPU (Quadro P2000)
```

---

## 🧰 Stack technique

| Outil | Rôle |
|-------|------|
| **Vagrant** | Création et gestion des VMs |
| **VirtualBox** | Hyperviseur |
| **Ansible** | Configuration automatique (6 rôles) |
| **Docker** | Conteneurisation des applications |
| **Nginx** | Reverse proxy + HTTPS |
| **Certbot** | Certificats SSL Let's Encrypt |
| **autossh** | Tunnel SSH permanent (systemd) |
| **Portainer** | Gestion Docker via interface web |
| **Grafana** | Visualisation des métriques |
| **Ollama** | LLM local sur GPU |
| **n8n** | Automatisation de workflows |

---

## 📚 Labs

| Lab | Objectif | Compétences |
|-----|----------|------------|
| [lab01](lab01-premiere-vm/) | Première VM Vagrant | Vagrant, VirtualBox, provisioning |
| [lab02](lab02-multi-vm/) | Ansible + 2 VMs | Ansible, inventory, playbook, rôles |
| [lab03](lab03-control-node/) | Control Node + 6 rôles | Architecture multi-VM, Docker, Nginx, Certbot |
| [lab04](lab04-tunnel-ssh/) | Tunnel SSH | SSH -R, autossh, systemd, exposition internet |

---

## 🚀 Démarrage rapide

### Prérequis
- VirtualBox 7+
- Vagrant 2+
- Git

### Lancer l'infrastructure complète
```bash
git clone https://github.com/josuekabangu/homelab-devops-.git
cd homelab-devops-/lab03-control-node
vagrant up
```

### Résultat attendu
```
srv-app  →  ok=24  changed=0  failed=0  ✅
srv-db   →  ok=10  changed=0  failed=0  ✅
```

---

## 📁 Structure du projet

```
homelab-devops/
│
├── lab01-premiere-vm/          ← VM simple + provisioning
├── lab02-multi-vm/             ← Ansible + 2 VMs
├── lab03-control-node/         ← Infrastructure complète
│   ├── Vagrantfile
│   ├── ansible/
│   │   ├── playbook.yml
│   │   └── roles/
│   │       ├── common/         ← outils de base
│   │       ├── docker/         ← Docker + Compose
│   │       ├── nginx/          ← reverse proxy
│   │       ├── nodejs/         ← Node.js 18
│   │       ├── postgresql/     ← base de données
│   │       └── certbot/        ← HTTPS Let's Encrypt
│   ├── nginx-configs/          ← configs reverse proxy
│   │   ├── portainer.conf
│   │   ├── grafana.conf
│   │   ├── llm.conf
│   │   ├── n8n.conf
│   │   └── budget.conf
│   └── systemd/
│       └── autossh-tunnel.service
│
├── lab04-tunnel-ssh/           ← Exposition internet
│
├── services/                   ← Configs de production
│   ├── monitoring/             ← Portainer + Grafana
│   ├── n8n/                    ← Automatisation
│   └── budget/                 ← App budget (BudgetMaster)
│
└── scripts/
    └── backup.sh               ← Backup PostgreSQL + volumes
```

---

## 🌐 Services déployés

| Service | URL | Stack |
|---------|-----|-------|
| Portainer | https://portainer.akanzair.com | Docker |
| Grafana | https://grafana.akanzair.com | Docker |
| Ollama LLM | https://llm.akanzair.com | GPU local |
| n8n | https://n8n.akanzair.com | Docker + PostgreSQL |
| BudgetMaster | https://budget.akanzair.com | Django + React + PostgreSQL |

---

## 🔭 Prochaines étapes

- [ ] Prometheus + alerting
- [ ] CI/CD — GitLab pipeline
- [ ] Kubernetes — migration des conteneurs

---

## 👤 Auteur

**Josué Kabangu** — Ingénieur DevOps Junior  
Diplômé DataScientest • Formation DevOps Engineer (2024-2025)  
📧 ajkabs2@gmail.com  
🌐 akanzair.com
