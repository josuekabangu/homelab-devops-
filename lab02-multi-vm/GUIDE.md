# Guide — Lab02 : Ansible + 2 VMs

## Objectif
Configurer automatiquement 2 VMs avec Ansible depuis l'une d'elles.

## Architecture
```
srv-app  192.168.56.11  ← reçoit Docker
srv-db   192.168.56.12  ← reçoit PostgreSQL + lance Ansible
```

## Structure des fichiers
```
labs/lab02-multi-vm/
├── Vagrantfile
└── ansible/
    ├── inventory.ini
    ├── playbook.yml
    └── roles/
        ├── common/tasks/main.yml
        └── docker/tasks/main.yml
```

## Étapes

### 1. Vagrantfile — 2 VMs
Voir `Vagrantfile` — srv-db lance Ansible via `ansible_local`.

### 2. Inventory
```ini
[appservers]
srv-app ansible_host=192.168.56.11 ansible_ssh_private_key_file=/tmp/app_key

[dbservers]
srv-db ansible_host=192.168.56.12 ansible_ssh_private_key_file=/tmp/db_key

[all:vars]
ansible_user=vagrant
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

### 3. Playbook
```yaml
- name: Configuration ALL servers
  hosts: all
  become: true
  roles:
    - common

- name: Configuration srv-app
  hosts: appservers
  become: true
  roles:
    - docker

- name: Configuration srv-db
  hosts: dbservers
  become: true
  tasks:
    - name: Installer PostgreSQL
      apt:
        name: postgresql
        state: present
        update_cache: true
    - name: Démarrer PostgreSQL
      service:
        name: postgresql
        state: started
        enabled: true
```

### 4. Lancer
```powershell
vagrant up
```

### 5. Vérifier
```powershell
vagrant ssh app
docker --version

vagrant ssh db
psql --version
```

## Points clés
- `ansible_local` → Ansible s'installe et tourne dans la VM
- Les clés SSH sont copiées dans `/tmp/` avant le provisioning
- `state: present` + `enabled: true` = idempotence
- Le rôle `common` s'exécute en premier sur tous les serveurs
