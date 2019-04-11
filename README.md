# Usage

```bash
sudo yum install -y git ansible

mkdir -p ~/dev/github/vorburger ; cd ~/dev/github/vorburger
git clone git@github.com:vorburger/vorburger-dotfiles-bin-etc.git
cd vorburger-dotfiles-bin-etc/ansible

ansible-playbook -i hosts playbooks/all.yaml
```

## Develop

```bash
ansible-playbook --syntax-check playbooks/*.yaml
ansible-lint playbooks/*.yaml
```
