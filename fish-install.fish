#!/usr/bin/env fish

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

# see https://github.com/kubernetes-sigs/krew/pull/811
# and https://github.com/kubernetes-sigs/krew/issues/810
$HOME/.krew/bin/kubectl-krew completion fish > $HOME/.config/fish/completions/kubectl-krew.fish
ln -fs $HOME/.krew/bin/kubectl-krew $HOME/.krew/bin/krew

# ToDo: It is a shame that krew doesn't automatically install shell completion for plugins
pushd .
cd $HOME/.config/fish/completions/
curl -fsSLO "https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.fish"
curl -fsSLO "https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubens.fish"
popd

ln -fs $HOME/.krew/bin/kubectl-ctx $HOME/.krew/bin/kubectx
ln -fs $HOME/.krew/bin/kubectl-ns $HOME/.krew/bin/kubens
