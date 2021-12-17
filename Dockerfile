# TODO rename this from Dockerfile to Dockerfile-google-cloudshell as soon as `cloudshell env build-local` can build from anything else than only a Dockerfile named exactly `Dockerfile`, only.
# see https://cloud.google.com/shell/docs/customizing-container-image
FROM gcr.io/cloudshell-images/cloudshell:latest

# COPY . /tmp/vorburger-dotfiles/
ADD apt-install.sh /tmp/vorburger-dotfiles/

RUN /tmp/vorburger-dotfiles/apt-install.sh

# TODO set up 
# To trigger a rebuild of your Cloud Shell image:
# 1. Commit your changes locally: git commit -a
# 2. Push your changes upstream: git push origin master

# This triggers a rebuild of your image hosted at gcr.io/vorburger/cloudshell.
# You can find the Cloud Source Repository hosting this file at https://source.developers.google.com/p/vorburger/r/cloudshell
