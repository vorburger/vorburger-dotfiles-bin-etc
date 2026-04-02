# TODO: Remove overlap with bin/tmux3!

# https://github.com/Foxboron/ssh-tpm-agent#usage

# Set SSH_AUTH_SOCK only if it's unset or set to $HOME/.ssh/agent
if test -z "$SSH_AUTH_SOCK" -o "$SSH_AUTH_SOCK" = "$HOME/.ssh.agent"
  if type -q ssh-tpm-agent
    set -gx SSH_AUTH_SOCK (ssh-tpm-agent --print-socket)
  end
end
