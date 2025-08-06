#!/usr/bin/env bash
set -euxo pipefail
shellcheck "$0"

systemctl stop ollama || yes

mkdir -p ~/Downloads/ollama
cd ~/Downloads/ollama

curl -LO https://ollama.com/download/ollama-linux-amd64.tgz
curl -LO https://ollama.com/download/ollama-linux-amd64-rocm.tgz

sudo rm "$(which ollama)"
sudo rm -rf /usr/local/lib/ollama
sudo tar -C /usr -xzf ollama-linux-amd64.tgz
sudo tar -C /usr -xzf ollama-linux-amd64-rocm.tgz

systemctl start ollama
systemctl status ollama

rm ollama-linux-amd64.tgz
rm ollama-linux-amd64-rocm.tgz
