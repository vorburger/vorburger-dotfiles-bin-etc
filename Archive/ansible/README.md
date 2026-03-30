# Usage

```bash
sudo yum install -y git ansible

mkdir -p ~/dev/github/vorburger ; cd ~/dev/github/vorburger
git clone git@github.com:vorburger/dotfiles.git
cd dotfiles/ansible

ansible-playbook -i hosts playbooks/all.yaml
```

### Develop

```bash
ansible-playbook --syntax-check playbooks/*.yaml
ansible-lint playbooks/*.yaml
```
