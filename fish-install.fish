#!/usr/bin/env fish

mkdir -p $HOME/.config/fish/completions

# Like in apt-install.sh skip instalation of most of these tools in GitHub Codespaces (for now)
if test ! -n "$CODESPACES"

  # https://krew.sigs.k8s.io/docs/user-guide/setup/install/

  # NB: $HOME/.krew/bin is added to $PATH in dotfiles/fish/config.fish
  if test ! -e $HOME/.krew/bin/kubectl-krew
    set -x; set temp_dir (mktemp -d); cd "$temp_dir" &&
    set OS (uname | tr '[:upper:]' '[:lower:]') &&
    set ARCH (uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/') &&
    set KREW krew-$OS"_"$ARCH &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/$KREW.tar.gz" &&
    tar zxvf $KREW.tar.gz &&
    ./$KREW install krew &&
    set -e KREW temp_dir &&
    cd -
  end

  grep -v "#" packages/krew.txt > /tmp/krew-packages.txt
  $HOME/.krew/bin/kubectl-krew install < /tmp/krew-packages.txt

  # and https://github.com/kubernetes-sigs/krew/issues/810
  ln -fs $HOME/.krew/bin/kubectl-krew $HOME/.krew/bin/krew

  # ToDo: It is a shame that krew doesn't automatically install shell completion for plugins
  pushd .
  cd $HOME/.config/fish/completions/
  curl -fsSLO "https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.fish"
  curl -fsSLO "https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.fish"
  popd

  ln -fs $HOME/.krew/bin/kubectl-ctx $HOME/.krew/bin/kubectx
  ln -fs $HOME/.krew/bin/kubectl-ns $HOME/.krew/bin/kubens

  # TODO How come Fish can do completion for Helm even without this?!
  command -sq helm && helm completion fish > $HOME/.config/fish/completions/helm.fish
end

# Put Fish tools that we *DO* want to install in all Codespaces here
rg --generate complete-fish > "$HOME/.config/fish/completions/rg.fish"

# Without this, if there is no helm, it does not return when called from all-install.sh
echo "Exiting fish-install.fish"
