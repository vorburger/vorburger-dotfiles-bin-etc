# TODO rename this from Dockerfile to Dockerfile-google-cloudshell as soon as `cloudshell env build-local` can build from anything else than only a Dockerfile named exactly `Dockerfile`, only.
# see https://cloud.google.com/shell/docs/customizing-container-image
FROM gcr.io/cloudshell-images/cloudshell:latest

COPY . /tmp/vorburger-dotfiles/

RUN /tmp/vorburger-dotfiles/apt-install.sh
RUN /tmp/vorburger-dotfiles/setup-homeless.sh
