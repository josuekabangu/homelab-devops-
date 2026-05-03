# Guide — Lab03 : Control Node Ansible

## Objectif
Mettre en place un Control Node dédié (srv-ansible) qui configure les autres VMs.

## Architecture
```
srv-app      192.168.56.11  ← Docker + Nginx
srv-db       192.168.56.12  ← PostgreSQL
srv-ansible  192.168.56.20  ← Control Node (installe Ansible + lance playbook)
```

## Structure des fichiers
```
labs/lab03-control-node/
├── Vagrantfile
└── ansible/
    ├── inventory.ini
    ├── playbook.yml
    └── roles/
        ├── common/tasks/main.yml
        ├── docker/tasks/main.yml
        ├── nginx/tasks/main.yml
        └── postgresql/tasks/main.yml
```

## Playbook — ordre des plays
```yaml
1. hosts: all        → rôle common   (outils de base)
2. hosts: appservers → rôles docker + nginx
3. hosts: dbservers  → rôle postgresql
```

## Règle importante
Le rôle `common` ne doit contenir que des tâches **universelles**.
La tâche "ajouter vagrant au groupe docker" appartient au rôle `docker`, pas à `common`.

## Lancer
```powershell
vagrant up           # première fois
vagrant provision    # relancer la configuration
```

## Résultats attendus
```
srv-app  →  ok=15  changed=0  failed=0
srv-db   →  ok=10  changed=0  failed=0
```

## Vérifier Nginx
```powershell
vagrant ssh app
curl http://localhost:80
```
