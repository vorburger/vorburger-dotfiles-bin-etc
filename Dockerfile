# TODO rename this from Dockerfile to Dockerfile-google-cloudshell as soon as `cloudshell env build-local` can build from anything else than only a Dockerfile named exactly `Dockerfile`, only.
# see https://cloud.google.com/shell/docs/customizing-container-image
FROM gcr.io/cloudshell-images/cloudshell:latest

COPY . /var/local/vorburger-dotfiles/

# RUN sudo apt install -y bash-completion file git procps unzip fish autojump fzf fd-find
RUN /var/local/vorburger-dotfiles/apt-install.sh 10

RUN /var/local/vorburger-dotfiles/symlink-homefree.sh
