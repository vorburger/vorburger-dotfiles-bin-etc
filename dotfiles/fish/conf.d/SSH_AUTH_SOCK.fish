# TODO: Remove overlap with bin/tmux3!

# https://github.com/Foxboron/ssh-tpm-agent#usage

if type -q ssh-tpm-agent
  set -gx SSH_AUTH_SOCK (ssh-tpm-agent --print-socket)
end
