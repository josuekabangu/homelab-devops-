# 🏗️ Homelab DevOps — Infrastructure as Code

> Homelab DevOps progressif : VMs Vagrant → Configuration Ansible → Conteneurisation Docker → Exposition via tunnel SSH → vers Kubernetes

[![Vagrant](https://img.shields.io/badge/Vagrant-2.x-blue)](https://www.vagrantup.com/)
[![Ansible](https://img.shields.io/badge/Ansible-2.10-red)](https://www.ansible.com/)
[![Docker](https://img.shields.io/badge/Docker-29.x-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## 🎯 Objectif

Construire une infrastructure professionnelle à partir d'un PC Windows, en appliquant les pratiques DevOps réelles :
- **Infrastructure as Code** — tout est décrit dans des fichiers, rien à la main
- **Idempotence** — les scripts peuvent être relancés sans danger
- **Séparation des responsabilités** — dev, ops, monitoring clairement séparés

---

## 🗺️ Architecture

```
PC Windows (hôte)
├── srv-ansible  192.168.56.20  ← Control Node Ansible
├── srv-app      192.168.56.11  ← Docker + Nginx + Portainer
└── srv-db       192.168.56.12  ← PostgreSQL

srv-app:80 ──tunnel SSH -R──▶ VPS akanzair.com:8080
```

---

## 🧰 Stack technique

| Outil | Rôle |
|-------|------|
| **Vagrant** | Création et gestion des VMs |
| **VirtualBox** | Hyperviseur |
| **Ansible** | Configuration automatique des serveurs |
| **Docker** | Conteneurisation des applications |
| **Nginx** | Reverse proxy |
| **SSH Tunnel** | Exposition sécurisée sur internet |
| **Portainer** | Gestion Docker via interface web |

---

## 📚 Labs

| Lab | Objectif | Compétences |
|-----|----------|------------|
| [lab01](labs/lab01-premiere-vm/) | Première VM Vagrant | Vagrant, VirtualBox, provisioning |
| [lab02](labs/lab02-multi-vm/) | Ansible + 2 VMs | Ansible, inventory, playbook, rôles |
| [lab03](labs/lab03-control-node/) | Control Node Ansible | Architecture multi-VM, rôles avancés |
| [lab04](labs/lab04-tunnel-ssh/) | Tunnel SSH | SSH -R, exposition internet, pare-feu |

---

## 🚀 Démarrage rapide

### Prérequis
- VirtualBox 7+
- Vagrant 2+
- Git

### Lancer un lab
```bash
git clone https://github.com/josuekabangu/homelab-devops-.git
cd homelab-devops-/labs/lab03-control-node
vagrant up
```

### Résultat attendu
```
srv-app  →  ok=15  changed=0  failed=0  ✅
srv-db   →  ok=10  changed=0  failed=0  ✅
```

---

## 📁 Structure du projet

```
labs/
├── lab01-premiere-vm/
│   ├── Vagrantfile
│   └── GUIDE.md
├── lab02-multi-vm/
│   ├── Vagrantfile
│   ├── ansible/
│   │   ├── inventory.ini
│   │   ├── playbook.yml
│   │   └── roles/
│   └── GUIDE.md
├── lab03-control-node/
│   ├── Vagrantfile
│   ├── ansible/
│   │   ├── inventory.ini
│   │   ├── playbook.yml
│   │   └── roles/
│   │       ├── common/
│   │       ├── docker/
│   │       ├── nginx/
│   │       └── postgresql/
│   └── GUIDE.md
└── lab04-tunnel-ssh/
    └── GUIDE.md
```

---

## 🌐 Résultat final

Service Nginx de `srv-app` accessible publiquement via tunnel SSH :

```
http://akanzair.com:8080  →  srv-app:80 (Nginx)
```

---

## 🔭 Prochaines étapes

- [ ] Nginx reverse proxy — routing par sous-domaine
- [ ] Grafana — dashboards et métriques
- [ ] Ollama — LLM local sur GPU
- [ ] CI/CD — GitLab pipeline de déploiement
- [ ] Kubernetes — migration des conteneurs Docker

---

## 👤 Auteur

**Josué Kabangu** — Ingénieur DevOps Junior  
Diplômé DataScientest • Formation DevOps Engineer (2024-2025)  
📧 ajkabs2@gmail.com  
🌐 akanzair.com
