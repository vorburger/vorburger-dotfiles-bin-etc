# Usage

## Simple (non-Ansible)

    mkdir -p ~/dev/
    cd ~/dev/
    git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc
    cd vorburger-dotfiles-bin-etc

    ./dnf-install.sh
    ./symlink.sh
    ./gnome-settings.sh


## Ansible (deprecated)

```bash
sudo yum install -y git ansible

mkdir -p ~/dev/github/vorburger ; cd ~/dev/github/vorburger
git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc.git
cd vorburger-dotfiles-bin-etc/ansible

ansible-playbook -i hosts playbooks/all.yaml
```

### Develop Ansible stuff (deprecated)

```bash
ansible-playbook --syntax-check playbooks/*.yaml
ansible-lint playbooks/*.yaml
```
