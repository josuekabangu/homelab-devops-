# Guide — Lab01 : Première VM Vagrant

## Objectif
Créer une VM Ubuntu avec Vagrant, s'y connecter et explorer le provisioning.

## Prérequis
- VirtualBox installé
- Vagrant installé

## Étapes

### 1. Créer le Vagrantfile
```ruby
Vagrant.configure("2") do |config|
  config.vm.box      = "bento/ubuntu-22.04"
  config.vm.hostname = "srv-lab01"
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "virtualbox" do |vb|
    vb.name   = "lab01-srv"
    vb.memory = "2048"
    vb.cpus   = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update -y
    apt-get install -y curl wget git htop net-tools
  SHELL
end
```

### 2. Lancer la VM
```powershell
vagrant up
```

### 3. Se connecter
```powershell
vagrant ssh
```

### 4. Vérifier
```bash
hostname        # srv-lab01
hostname -I     # 192.168.56.10
curl --version  # curl installé
```

### 5. Éteindre / Supprimer
```powershell
vagrant halt     # éteindre
vagrant destroy  # supprimer
```

## Commandes essentielles

| Commande | Action |
|----------|--------|
| `vagrant up` | Créer et démarrer |
| `vagrant ssh` | Se connecter |
| `vagrant halt` | Éteindre |
| `vagrant destroy` | Supprimer |
| `vagrant status` | État des VMs |
| `vagrant provision` | Relancer le provisioning |

## Concepts clés
- **Box** : image de base préinstallée
- **Provider** : hyperviseur (VirtualBox)
- **Provisioning** : configuration automatique au démarrage
- **IaC** : tout est décrit dans un fichier texte
